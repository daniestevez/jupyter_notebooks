#!/usr/bin/env python3

import numpy as np
import dask.array as da
import xarray as xr
import datetime
import pathlib
import scipy.signal

import sys
sys.path.append('..')
import moonbounce.process_recording as process

TRACKING_FILES_PATH = '../tracking_files/'

GS_LOCATIONS = {
    'PI9CAM' : process.PI9CAM,
    'Shahe' : [40.1175139, 116.2299139, 0.049],
    'Harbin' : [45.9530917, 126.8002056, 0.117],
    'Wakayama' : [34.267316, 135.150097, 0.080]
}

NUM_PARAMETERS = 13
def usage():
    print('Usage: {} file1 file1_start_timestamp file1_groundstation file2 file2_start_timestamp file2_groundstation centre_freq tx_freq_offset results.npy doppler1.nc doppler2.nc gmat1.nc gmat2.nc'.format(sys.argv[0]), file=sys.stderr)

FFT_SIZE = 2**17
CORR_WINDOW_SIZE = 200
BIN_SWEEP = 2

TOTAL_CORR = 2 * CORR_WINDOW_SIZE + 1

def process_block(b):
    results = np.empty((b.shape[0], 1 + TOTAL_CORR), dtype = np.complex64)
    max_pos = np.argmax(np.abs(b), axis = 1)
    results[:, 0] = max_pos # maximum positions
    get_indices = max_pos.reshape((-1,1)) + np.arange(-CORR_WINDOW_SIZE, CORR_WINDOW_SIZE + 1).reshape((1,-1))
    get_indices[get_indices < 0] = 0
    get_indices[get_indices >= b.shape[1]] = b.shape[1] - 1
    get = np.repeat(np.arange(get_indices.shape[0]), get_indices.shape[1]).reshape(get_indices.shape)
    results[:, 1:] = b[get, get_indices]
    return results

def process_vlbi(x):
    return x.map_blocks(process_block, dtype = np.complex64, chunks = (x.chunksize[0], 1 + TOTAL_CORR))

def main():
    if len(sys.argv) != NUM_PARAMETERS + 1:
        usage()
        return 1

    start_timestamp_1 = float(sys.argv[2])
    start_1 = np.datetime64(datetime.datetime.utcfromtimestamp(start_timestamp_1))
    start_timestamp_2 = float(sys.argv[5])
    start_2 = np.datetime64(datetime.datetime.utcfromtimestamp(start_timestamp_2))

    samples_1 = process.open_samples_file(sys.argv[1])
    sample_time_1 = process.compute_sample_time(samples_1, start_1)
    samples_2 = process.open_samples_file(sys.argv[4])
    sample_time_2 = process.compute_sample_time(samples_2, start_2)

    samples_throw = int(np.round(np.abs(start_1 - start_2).astype('timedelta64[ns]').astype('float')*1e-9*process.SAMPRATE))
    if start_1 < start_2:
        samples_1 = samples_1[samples_throw:]
        sample_time_1 = sample_time_1[samples_throw:]
    else:
        samples_2 = samples_2[samples_throw:]
        sample_time_2 = sample_time_2[samples_throw:]
    samples_len = min(samples_1.size, samples_2.size)
    samples_1 = samples_1[:samples_len]
    samples_2 = samples_2[:samples_len]
    sample_time_1 = sample_time_1[:samples_len]
    sample_time_2 = sample_time_2[:samples_len]

    print('First sample timestamp:', sample_time_1[0].compute())
    clock_offset = sample_time_1[0].compute() - sample_time_2[0].compute()
    print('Clock offset between 1 and 2:', clock_offset)

    centre_freq = float(sys.argv[7])

    doppler_start = sample_time_1[0].compute()
    doppler_end = sample_time_1[-1].compute()
    
    tracking_files = pathlib.Path(TRACKING_FILES_PATH)
    tracking_file = process.select_best_tracking_file(tracking_files, doppler_start)
    trk = process.load_tracking_file_head(tracking_file)

    process.GS_LOCATION = GS_LOCATIONS[sys.argv[3]]
    process.run_gmat(trk, doppler_start, doppler_end)
    gmat_data_1 = process.load_gmat_report(process.REPORT_PATH)

    process.GS_LOCATION = GS_LOCATIONS[sys.argv[6]]
    process.run_gmat(trk, doppler_start, doppler_end)
    gmat_data_2 = process.load_gmat_report(process.REPORT_PATH)

    gmat_data_1.to_netcdf(sys.argv[12])
    gmat_data_2.to_netcdf(sys.argv[13])

    doppler_1 = process.compute_direct_doppler(gmat_data_1, centre_freq)
    doppler_2 = process.compute_direct_doppler(gmat_data_2, centre_freq)

    doppler_1.to_netcdf(sys.argv[10])
    doppler_2.to_netcdf(sys.argv[11])

    tx_freq_offset = float(sys.argv[8])

    samples_no_doppler_1 = process.remove_doppler(samples_1, sample_time_1, doppler_1 + tx_freq_offset)
    samples_no_doppler_2 = process.remove_doppler(samples_2, sample_time_2, doppler_2 + tx_freq_offset)
    samples_filtered_1 = process.filter_signal(samples_no_doppler_1, 1000)
    samples_filtered_2 = process.filter_signal(samples_no_doppler_2, 1000)

    fft_1 = da.fft.fft(samples_filtered_1[:samples_filtered_1.size//FFT_SIZE*FFT_SIZE].reshape((-1, FFT_SIZE)), axis = 1)
    fft_conj_2 = np.conj(da.fft.fft(samples_filtered_2[:samples_filtered_2.size//FFT_SIZE*FFT_SIZE].reshape((-1, FFT_SIZE)), axis = 1))
    
    bins = np.arange(-BIN_SWEEP, BIN_SWEEP+1)
    results = np.empty((bins.size, fft_1.shape[0], 1 + TOTAL_CORR), dtype = np.complex64)
    for j, b in enumerate(bins):
        print(f'Doing bin {j+1}/{bins.size}')
        roll_positions = np.concatenate((np.arange(FFT_SIZE-b, FFT_SIZE), np.arange(FFT_SIZE-b))) if b >= 0 else \
            np.concatenate((np.arange(-b, FFT_SIZE), np.arange(-b)))
        fft_conj_shifted_2 = fft_conj_2[:, roll_positions]
        correlations = da.fft.fftshift(da.fft.ifft(fft_1 * fft_conj_shifted_2), axes = 1)
        results[j, ...] = process_vlbi(correlations)

    np.save(sys.argv[9], results)

    return 0

if __name__ == '__main__':
    main()
