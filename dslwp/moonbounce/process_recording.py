#!/usr/bin/env python3

#####################
### CONFIGURATION ###
#####################

# Path to GMAT executable

GMAT_PATH = '/home/daniel/GMAT/R2018a/'
GMAT_EXECUTABLE = GMAT_PATH + 'bin/GMAT-R2018a'

# Groundstation locations
# (latitude, longitude, altitude)
# latitude, longitude in degrees
# altitude in metres above the ellipsoid

PI9CAM = [52.81201944, 6.39616944, 0.025]

# Receiving Groundstation location

GS_LOCATION = PI9CAM

# Path to GMAT output script

SCRIPT_PATH = '/tmp/gmat_moonbounce.script'

# Path to GMAT output report

REPORT_PATH = '/tmp/gmat_moonbounce_report.txt'

# Recording sample rate

SAMPRATE = 40000

# Performance settings

SAMPLES_CHUNKSIZE = 2**20
FFT_SIZE = 2**14
PWR_AVERAGE = 2**12

#####################

import numpy as np
import scipy.signal
import xarray as xr
import dask.array as da
from dask.diagnostics import ProgressBar

import datetime

import subprocess
import sys
import pathlib

import re

c = 299792458
MOON_RADIUS = 1737.1
    
mjd_unixtimestamp_offset = 10587.5
seconds_in_day = 3600 * 24

def mjd2unixtimestamp(m):
    return (m - mjd_unixtimestamp_offset) * seconds_in_day

def unixtimestamp2mjd(u):
    return u / seconds_in_day + mjd_unixtimestamp_offset

def load_tracking_file_head(path):
    ncols = 7
    data = np.fromfile(str(path), sep=' ', count = ncols)
    return data

def datetime64tounixtimestamp(d):
    return d.astype('datetime64[s]').astype('float')

GMAT_TEMPLATE = """
%----------------------------------------
%---------- Spacecraft
%----------------------------------------

Create Spacecraft DSLWP_B;
DSLWP_B.DateFormat = UTCModJulian;
DSLWP_B.Epoch = {epoch};
DSLWP_B.CoordinateSystem = EarthFixed;
DSLWP_B.DisplayStateType = Cartesian;
DSLWP_B.X = {x[0]};
DSLWP_B.Y = {x[1]};
DSLWP_B.Z = {x[2]};
DSLWP_B.VX = {v[0]};
DSLWP_B.VY = {v[1]};
DSLWP_B.VZ = {v[2]};
DSLWP_B.DryMass = 45;
DSLWP_B.DragArea = 0.25;
DSLWP_B.SRPArea = 0.25;

%----------------------------------------
%---------- ForceModels
%----------------------------------------

Create ForceModel LunaProp_ForceModel;
LunaProp_ForceModel.CentralBody = Luna;
LunaProp_ForceModel.PrimaryBodies = {{Luna}};
LunaProp_ForceModel.PointMasses = {{Earth, Jupiter, Mars, Neptune, Saturn, Sun, Uranus, Venus}};
LunaProp_ForceModel.Drag = None;
LunaProp_ForceModel.SRP = On;
LunaProp_ForceModel.RelativisticCorrection = On;
LunaProp_ForceModel.ErrorControl = RSSStep;
LunaProp_ForceModel.GravityField.Luna.Degree = 10;
LunaProp_ForceModel.GravityField.Luna.Order = 10;
LunaProp_ForceModel.GravityField.Luna.StmLimit = 100;
LunaProp_ForceModel.GravityField.Luna.PotentialFile = 'LP165P.cof';

%----------------------------------------
%---------- Propagators
%----------------------------------------

Create Propagator LunaProp;
LunaProp.FM = LunaProp_ForceModel;
LunaProp.Type = PrinceDormand78;
LunaProp.InitialStepSize = 1;
LunaProp.Accuracy = 1e-13;
LunaProp.MinStep = 0;
LunaProp.MaxStep = 10;
LunaProp.MaxStepAttempts = 50;

%----------------------------------------
%---------- GroundStations
%----------------------------------------

Create GroundStation GS;
GS.CentralBody = Earth;
GS.StateType = Spherical;
GS.HorizonReference = Ellipsoid;
GS.Location1 = {gs[0]};
GS.Location2 = {gs[1]};
GS.Location3 = {gs[2]};
GS.Id = 'Groundstation';

%----------------------------------------
%---------- Coordinate Systems
%----------------------------------------

Create CoordinateSystem LunaInertial;
LunaInertial.Origin = Luna;
LunaInertial.Axes = BodyInertial;

Create CoordinateSystem LunaFixed;
LunaFixed.Origin = Luna;
LunaFixed.Axes = BodyFixed;

Create CoordinateSystem GSTopo;
GSTopo.Origin = GS;
GSTopo.Axes = Topocentric;

%----------------------------------------
%---------- Subscribers
%----------------------------------------

Create ReportFile Rep;
Rep.Filename = {report_path};
Rep.Add = {{DSLWP_B.UTCModJulian, DSLWP_B.GSTopo.X, DSLWP_B.GSTopo.Y, DSLWP_B.GSTopo.Z, DSLWP_B.GSTopo.VX, DSLWP_B.GSTopo.VY, DSLWP_B.GSTopo.VZ, DSLWP_B.LunaFixed.X, DSLWP_B.LunaFixed.Y, DSLWP_B.LunaFixed.Z, GS.LunaFixed.X, GS.LunaFixed.Y, GS.LunaFixed.Z}};
Rep.WriteHeaders = false;

%----------------------------------------
%---------- Mission Sequence
%----------------------------------------

BeginMissionSequence;
Toggle Rep Off
If DSLWP_B.UTCModJulian <= {start}
    Propagate LunaProp(DSLWP_B) {{DSLWP_B.UTCModJulian = {start}}}
Else
    Propagate BackProp LunaProp(DSLWP_B) {{DSLWP_B.UTCModJulian = {start}}}
EndIf
Toggle Rep On
Propagate LunaProp(DSLWP_B) {{DSLWP_B.UTCModJulian = {end}}}
"""

def run_gmat(tracking_row, start, end):
    data = dict()
    data['start'] = unixtimestamp2mjd(datetime64tounixtimestamp(start))
    data['end'] = unixtimestamp2mjd(datetime64tounixtimestamp(end))
    data['epoch'] = unixtimestamp2mjd(tracking_row[0])
    data['x'] = tracking_row[1:4]
    data['v'] = tracking_row[4:7]
    data['gs'] = GS_LOCATION
    data['report_path'] = REPORT_PATH
    with open(SCRIPT_PATH, 'w') as f:
        f.write(GMAT_TEMPLATE.format(**data))
    subprocess.call([GMAT_EXECUTABLE, '-r', SCRIPT_PATH, '-x', '-m'])

def load_gmat_report(path):
    GMAT_COLS = 13
    data = np.fromfile(path, sep=' ').reshape((-1, GMAT_COLS))
    t = [np.datetime64(datetime.datetime.utcfromtimestamp(s)) for s in mjd2unixtimestamp(data[:,0])]
    xr_data = xr.DataArray(data[:,1:].reshape((-1, (GMAT_COLS-1)//3 ,3)), dims = ('time', 'object', 'xyz'),\
                           coords = {'time' : t, 'object' : ['dslwpb_gstopo_x', 'dslwpb_gstopo_v', 'dslwpb_lunafixed_x', 'gs_lunafixed_x'], 'xyz' : ['x', 'y', 'z']})
    return xr_data

def rangerate(x, v):
    return (x * v).sum('xyz') / np.sqrt((x**2).sum('xyz')) * 1e3

def rangerate2doppler(x, freq):
    return -x * freq / c

def compute_moonbounce_range(data):
    N_GRIDPOINTS = 1000
    TIMECHUNK = 1
    longitude = np.linspace(-np.pi, np.pi, N_GRIDPOINTS)
    latitude = np.linspace(-np.pi/2, np.pi/2, N_GRIDPOINTS)
    longitude = xr.DataArray(longitude, dims = 'longitude', coords = {'longitude' : longitude})
    latitude = xr.DataArray(latitude, dims = 'latitude', coords = {'latitude' : latitude})
    moon_x = MOON_RADIUS * np.cos(longitude) * np.cos(latitude)
    moon_y = MOON_RADIUS * np.sin(longitude) * np.cos(latitude)
    moon_z = MOON_RADIUS * np.sin(latitude)
    moon_surface = xr.concat((moon_x, moon_y, moon_z), coords = 'all', dim = 'xyz')
    moon_surface.coords['xyz'] = ['x', 'y', 'z']
    dslwpb = data.sel(object = 'dslwpb_lunafixed_x').drop('object').chunk({'time' : TIMECHUNK})
    gs = data.sel(object = 'gs_lunafixed_x').drop('object').chunk({'time' : TIMECHUNK})
    dslwpb_dist = np.sqrt(((dslwpb - moon_surface)**2).sum('xyz'))
    gs_dist = np.sqrt(((gs - moon_surface)**2).sum('xyz'))
    min_dist = (dslwpb_dist + gs_dist).min(('latitude','longitude'))
    return min_dist.compute()

def compute_moonbounce_doppler(r, freq):
    return -r.differentiate('time', datetime_unit = 's') * 1e3 * freq / c

def compute_direct_doppler(data, freq):
    return rangerate2doppler(rangerate(data.sel(object = 'dslwpb_gstopo_x').drop('object'), data.sel(object = 'dslwpb_gstopo_v').drop('object')), freq)

def open_samples_file(path, chunksize = SAMPLES_CHUNKSIZE):
    data = np.memmap(str(path), mode='r', dtype=np.complex64)
    return da.from_array(data[:data.size//FFT_SIZE*FFT_SIZE], chunks = chunksize)

def compute_sample_time(samples, samples_start_timestamp):
    Ts = np.timedelta64(int(1e9/SAMPRATE), 'ns')
    return da.arange(samples.size, chunks = samples.chunksize) * Ts + samples_start_timestamp

def remove_doppler(samples, sample_time, doppler):
    # compute phase
    dt = doppler.coords['time'].diff('time').astype('float')*1e-9
    phase = np.concatenate(([0], np.cumsum(0.5 * (doppler.values[:-1] + doppler.values[1:]) * dt)))
    phase = xr.DataArray(phase, dims = 'time', coords = doppler.coords)
    
    sample_phase = sample_time.map_blocks(lambda b: phase.interp(time = b, assume_sorted = True, kwargs={'fill_value' : 'extrapolate'}).values, dtype = 'float')
    lo = np.exp(-1j*2*np.pi*sample_phase)
    
    return samples * lo

def compute_spectrum(samples, freq, N = FFT_SIZE):
    spec = da.sum(np.abs(da.fft.fftshift(da.fft.fft(samples.reshape((-1,N))), axes = 1)**2), axis=0).compute()
    return xr.DataArray(spec, dims = 'freq', coords = {'freq' : freq + np.fft.fftshift(np.fft.fftfreq(N, 1/SAMPRATE))})

def filter_signal(samples, bandwidth):
    lowpass = scipy.signal.firwin(2048, bandwidth / SAMPRATE) # filter to +- baudrate/2
    return samples.map_overlap(lambda b: scipy.signal.convolve(lowpass, b, method='fft')[:-(lowpass.size-1)], lowpass.size-1)

def compute_power(samples, sample_time, bandwidth, avg_win = PWR_AVERAGE):
    samples_filt = filter_signal(samples, bandwidth)
    pwr = da.sum((np.abs(samples_filt[:samples_filt.size//avg_win*avg_win])**2).reshape((-1,avg_win)), axis = 1).compute()
    return xr.DataArray(pwr, dims = 'time', coords = {'time' : sample_time[:samples_filt.size//avg_win*avg_win][::avg_win].compute()})

def detect_gmsk_spectrum(spectrum, binwidth = 2000, binoffset = 0):
    freqsel = slice(spectrum.size//2 + binoffset - binwidth//2, spectrum.size//2 + binoffset + binwidth//2)
    s = spectrum[freqsel]
    threshold = 1.1
    channels = 1*(s > s.median() + 0.5*s.std())
    channels[0] = 0
    channels[-1] = 0
    channel_edges = channels.diff('freq')
    left_edges = channel_edges[channel_edges == 1].coords['freq'].values
    right_edges = channel_edges[channel_edges == -1].coords['freq'].values
    bandwidths = right_edges - left_edges
    print('GMSK detector detected channels with bandwidths:', bandwidths)
    best = None
    bw_min = [120, 310]
    bw_max = [300, 550]
    bw_nominal = [250, 500]
    for bw in range(2):
        good_channels = (bw_min[bw] < bandwidths) & (bandwidths < bw_max[bw])
        if not good_channels.any():
            continue
        channel_centres = 0.5*(left_edges[good_channels] + right_edges[good_channels])
        channel_powers = s.sel(freq = channel_centres, method = 'nearest')
        best_channel = channel_powers.sortby(channel_powers, ascending = False)[0]
        if best is None or best_channel > best:
            best_bandwidth = bw_nominal[bw]
            best = best_channel

    if best is None:
        return None

    freq_offset = best.coords['freq'].values - spectrum.coords['freq'][spectrum.size//2].values
    return freq_offset, best_bandwidth

def check_output_exists(output_dir, output_base_name):
    return np.all(np.array([(output_dir / (output_base_name + f'_{mod}.nc')).exists() for mod in ('doppler', 'spectrum', 'power')]))

def process_recording(recording_path, recording_start, recording_centre_freq, tracking_file_path, output_dir, output_base_name):
    samples = open_samples_file(recording_path)
    sample_time = compute_sample_time(samples, recording_start)
    
    trk = load_tracking_file_head(tracking_file_path)
    recording_end = sample_time[-1].compute()
    run_gmat(trk, recording_start, recording_end)
    gmat_data = load_gmat_report(REPORT_PATH)

    xr.Dataset({'gmat' : gmat_data}, attrs = {'tracking_file' : tracking_file_path.name}).to_netcdf(output_dir / (output_base_name + '_gmat.nc'))
    
    print('Computing Moonbounce...')
    with ProgressBar():
        r = compute_moonbounce_range(gmat_data)
    doppler_moonbounce = compute_moonbounce_doppler(r, recording_centre_freq)
    doppler_direct = compute_direct_doppler(gmat_data, recording_centre_freq)

    attributes_doppler = {'centre_frequency' : recording_centre_freq, 'tracking_file' : tracking_file_path.name}
    xr.Dataset({'doppler_direct' : doppler_direct, 'doppler_moonbounce' : doppler_moonbounce}, attrs = attributes_doppler).to_netcdf(output_dir / (output_base_name + '_doppler.nc'))

    print('Computing spectrum...')
    with ProgressBar():
        spec = compute_spectrum(remove_doppler(samples, sample_time, doppler_direct), recording_centre_freq)

    ret = detect_gmsk_spectrum(spec)
    if ret is None:
        print('No GMSK signal detected.')
        xr.Dataset({'spectrum_rejected' : spec}, attrs = attributes_doppler).to_netcdf(output_dir / (output_base_name + '_rejectedspectrum.nc'))
        return

    freq_offset, bandwidth = ret
    print(f'Detected GMSK signal at {freq_offset:.2f}Hz with baudrate {bandwidth:.0f}')

    attributes = {'frequency_offset' : freq_offset, 'gmsk_baudrate' : bandwidth, 'centre_frequency' : recording_centre_freq,\
                  'tracking_file' : tracking_file_path.name, 'recording_file' : recording_path.name,\
                  'recording_start' : str(recording_start), 'recording_end' : str(recording_end)}

    print('Computing offset-corrected direct spectrum...')
    with ProgressBar():
        spec_direct = compute_spectrum(remove_doppler(samples, sample_time, doppler_direct + freq_offset), recording_centre_freq)
    print('Computing offset-corrected Moonbounce spectrum...')
    with ProgressBar():
        spec_moonbounce = compute_spectrum(remove_doppler(samples, sample_time, doppler_moonbounce + freq_offset), recording_centre_freq)

    xr.Dataset({'spectrum_direct' : spec_direct, 'spectrum_moonbounce' : spec_moonbounce}, attrs = attributes).to_netcdf(output_dir / (output_base_name + '_spectrum.nc'))
    del spec_direct, spec_moonbounce
        
    print('Computing direct power...')
    with ProgressBar():
        pwr_direct = compute_power(remove_doppler(samples, sample_time, doppler_direct + freq_offset), sample_time, bandwidth)
    print('Computing Moonbounce power...')
    with ProgressBar():
        pwr_moonbounce= compute_power(remove_doppler(samples, sample_time, doppler_moonbounce + freq_offset), sample_time, bandwidth)

    xr.Dataset({'power_direct' : pwr_direct, 'power_moonbounce' : pwr_moonbounce}, attrs = attributes).to_netcdf(output_dir / (output_base_name + '_power.nc'))
    del pwr_direct, pwr_moonbounce

def select_best_tracking_file(tracking_files_path, start):
    dist = None
    tracking_file = None
    for f in tracking_files_path.iterdir():
        m = re.match('program_tracking_dslwp-b_(\\d{4})(\\d{2})(\\d{2}).txt', f.name)
        if m:
            date = np.datetime64(f'{m.group(1)}-{m.group(2)}-{m.group(3)}')
            dist_new = np.abs(date - start)
            if dist is None or dist_new < dist:
                tracking_file = f
                dist = dist_new
    return tracking_file

def parse_filename(filename, tagged = False):
    tag = '_tagged' if tagged else ''
    try:
        m = re.match(f'DSLWP-B_PI9CAM_(?P<datetime>\\d+-\\d+-\\d+T\\d+(_|:)\\d+(_|:)\\d+)_(?P<frequency>\\d+(\\.\\d+)?)MHz_40ksps_complex{tag}.raw$', filename.name)
        start = np.datetime64(m.group('datetime').replace('_',':'))
        frequency = float(m.group('frequency')) * 1e6
    except (AttributeError, ValueError):
        return None
    return start, frequency

def print_usage(file = sys.stdout):
    print(f'Usage: {sys.argv[0]} DSLWP-B_PI9CAM_recording_40ksps_complex.raw tracking_files_directory output_directory tagged(1||0)', file = file)

def main():
    if len(sys.argv) != 5:
        print_usage(file = sys.stderr)
        exit(1)
    
    recording = pathlib.Path(sys.argv[1])
    tracking_files = pathlib.Path(sys.argv[2])
    output = pathlib.Path(sys.argv[3])
    tagged = bool(int(sys.argv[4]))
    
    try:
        start, freq = parse_filename(recording, tagged)
    except TypeError:
        print('Invalid recording filename', file = sys.stderr)
        sys.exit(1)

    base_name = f'{start}_{freq*1e-6:.1f}MHz'
        
    if check_output_exists(output, base_name):
        print('Output exists. Not running again.', file = sys.stderr)
        sys.exit(0)

    tracking_file = select_best_tracking_file(tracking_files, start)
    if tracking_file is None:
        print('Could not select appropriate tracking file', file = sys.stderr)
        sys.exit(1)

    process_recording(recording, start, freq, tracking_file, output, base_name)

if __name__ == '__main__':
    main()
