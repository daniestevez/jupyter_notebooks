#!/usr/bin/env python3

import pmt
from gnuradio.blocks import parse_file_metadata
import numpy as np

import pathlib
import datetime
import subprocess
import time

samp_rate = 40000

path = pathlib.Path('/mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/')
c64_path = path / 'c64'
CONVERT = '/home/daniel/jupyter_notebooks/dslwp/convert_metadata_file.py'
CORRELATE = '/home/daniel/jupyter_notebooks/dslwp/vlbi/correlate_recordings.py'
output_dir = pathlib.Path('/home/daniel/jupyter_notebooks/dslwp/vlbi/results')

def read_meta_info(file):
    with open(file, 'rb') as f:
        header = pmt.deserialize_str(f.read(parse_file_metadata.HEADER_LENGTH))
        info = parse_file_metadata.parse_header(header, False)
    info['st_size'] = file.stat().st_size
    bandsname = {435 : ['_435_', '_435.4MHz_', '_435MHz'],
                 436 : ['_436_', '_436.4MHz_', '_436MHz']}
    isband = {k : np.any([vv in str(file) for vv in v]) for k, v in bandsname.items()}
    if not np.any(list(isband.values())):
        raise ValueError(f'Could not deduce band from filename: {str(file)}')
    info['band'] = [k for k, v in isband.items() if v][0]
    return info

def brackets_overlap(f1, f2):
    s1 = f1[1]['rx_time']
    e1 = f1[1]['rx_time'] + f1[1]['st_size']/(16 * samp_rate)
    s2 = f2[1]['rx_time']
    e2 = f2[1]['rx_time'] + f2[1]['st_size']/(16 * samp_rate)
    s = max(s1, s2)
    e = min(e1, e2)
    return s < e

def same_band(f1, f2):
    return f1[1]['band'] == f2[1]['band']

def baseline_name(b):
    start = max(b[2]['rx_time'], b[5]['rx_time'])
    start = datetime.datetime(1970, 1, 1) + datetime.timedelta(seconds = start)
    return start.strftime('%Y-%m-%dT%H_%M_%S') + f'_{b[2]["band"]}_{b[0]}_{b[3]}'

freq_offset = {435 : {
    '2018-11-21' : -220, # unkown. approximate
    '2018-11-22' : -220, # unkown. approximate
    '2018-11-25' : -220, # unkown. approximate
    '2019-06-03' : -220, # unknown, taken from 2019-06-06
    '2019-06-06' : -220,
    '2019-06-07' : -225,
    '2019-06-30' : -256, # unknown, taken from 2019-07-03
    '2019-07-01' : -256, # unknown, taken from 2019-07-03
    '2019-07-03' : -256,
    '2019-07-04' : -254,
    '2019-07-05' : -256,
    '2019-07-09' : -210,
    '2019-07-10' : -210,
    '2019-07-22' : -210, # unknown, taken from 2019-07-23
    '2019-07-23' : -210,
    '2019-07-25' : -210, # unknown, taken from 2019-07-23
    '2019-07-28' : -212,
    '2019-07-29' : -212, # unknown, taken from 2019-07-28
    '2019-07-30' : -225, # unknown, taken from 2019-07-30
    '2019-07-31' : -225,
    },
               436 : {
    '2018-11-21' : -250,
    '2018-11-22' : -250, # unknown, taken from 2018-11-21
    '2018-11-25' : -250, # unknown, taken from 2018-11-21
    '2019-06-03' : -265, # unknown. approximate
    '2019-06-06' : -261,
    '2019-06-07' : -266,
    '2019-06-30' : -310, # unknown, taken from 2019-07-03
    '2019-07-01' : -310, # unknown, taken from 2019-07-03
    '2019-07-03' : -310,
    '2019-07-04' : -291,
    '2019-07-05' : -293,
    '2019-07-09' : -259,
    '2019-07-10' : -266,
    '2019-07-22' : -259, # unknown, taken from 2019-07-23
    '2019-07-23' : -259,
    '2019-07-25' : -261, # unknown, taken from 2019-07-23
    '2019-07-28' : -261,
    '2019-07-29' : -261, # unknown, taken from 2019-07-28
    '2019-07-30' : -269, # unknown, taken from 2019-07-31
    '2019-07-31' : -269,
    }
}

def c64_filename(f):
    return c64_path / f.name

def convert_to_c64(f):
    convert = subprocess.Popen([CONVERT, '--infile', str(f), '--outfile', str(c64_filename(f))])
    size = 0
    while True:
        time.sleep(10)
        new_size = c64_filename(f).stat().st_size
        if new_size == size:
            convert.terminate()
            return
        size = new_size
        
def rx_time_str(info):
    secs = int(info['rx_secs'])
    nsecs = int(np.round(info['rx_time_fracs'] * 1e9))
    return str(secs * 1000000000 + nsecs)
        
def correlate_baseline(b):
    name = baseline_name(b)
    output_corr = output_dir / (name + '_correlations.npy')
    if output_corr.exists():
        # do not correlate if results exist
        return
    
    convert_to_c64(b[1])
    convert_to_c64(b[4])

    subprocess.run([CORRELATE,
                    str(c64_filename(b[1])), rx_time_str(b[2]), b[0],
                    str(c64_filename(b[4])), rx_time_str(b[5]), b[3],
                    '435.4e6' if b[2]['band'] == 435 else '436.4e6',
                    str(freq_offset[b[2]['band']][name.split('T')[0]]),
                    str(output_corr),
                    str(output_dir / (name + '_doppler_1.nc')),
                    str(output_dir / (name + '_doppler_2.nc')),
                    str(output_dir / (name + '_gmat_1.nc')),
                    str(output_dir / (name + '_gmat_2.nc')),
                    str(output_dir / (name + '_timing_info.npz')),
                   ])
    
    c64_filename(b[1]).unlink()
    c64_filename(b[4]).unlink()
    
def main():
    recordings = {'PI9CAM' : list(path.glob('*_complex_tagged.raw')) + list(path.glob('meta_B_*_Dwingeloo_*')) + list(path.glob('DSLWP-B_PI9CAM_2018-11-21_*.raw')),
              'Harbin' : list(path.glob('meta_B_*_Harbin_*')),
              'Shahe' : list(path.glob('meta_B_*_Shahe_*')) + list(path.glob('meta_B_*_Beijing_*')),
              'Wakayama' : list(path.glob('meta_B_*_Wakayama_*')),
             }
    recordings = {k : [(p, read_meta_info(p)) for p in v] for k, v in recordings.items()}

    baselines = list()
    stations = list(recordings.keys())
    for j in range(len(stations)):
        s1 = stations[j]
        for k in range(j + 1, len(stations)):
            s2 = stations[k]
            baselines.extend([(s1,r1[0],r1[1],s2,r2[0],r2[1])
                                for r1 in recordings[s1]
                                for r2 in recordings[s2]
                                if brackets_overlap(r1,r2) and same_band(r1,r2)])

    baselines_files = {b[1] for b in baselines} | {b[4] for b in baselines}

    for b in baselines:
        correlate_baseline(b)

if __name__ == '__main__':
    main()
