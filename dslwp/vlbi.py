#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import scipy.signal
import scipy.io
import scipy.optimize

import sys

c = 299792458

fs = 40000

doppler_correction = -200

num_args = 7
def usage():
    print("Usage {}: freq file0.raw file1.raw file0_utc file1_utc doppler_file output_folder".format(sys.argv[0]), file=sys.stderr)

def load_signal():
    signals = [np.fromfile(path, dtype='complex64') for path in sys.argv[2:4]]
    length = np.min([sig.size for sig in signals])
    return np.vstack((sig[:length] for sig in signals))

def mjd2unixtimestamp(m):
    mjd_unixtimestamp_offset = 10587.5
    seconds_in_day = 3600 * 24
    return (m - mjd_unixtimestamp_offset) * seconds_in_day

def load_doppler_file(path):
    ncols = 13
    data = np.fromfile(path, sep=' ')
    return data.reshape((-1,ncols))

def range_rate(tracking):
    return np.sum(tracking[:,0:3] * tracking[:,3:6], axis = 1)/np.sqrt(np.sum(tracking[:,0:3]**2, axis=1))*1e3

def estimate_dopplers(time, freq):
    doppler_file = load_doppler_file(sys.argv[6])
    doppler_utcs = mjd2unixtimestamp(doppler_file[:,0])
    doppler = np.empty(2)
    for j in range(2):
        idx = np.where(doppler_utcs < time[j])[0][-1]
        dopplers = -range_rate(doppler_file[idx:idx+2, 1+6*j:1+6*(j+1)]) * freq / c
        tau = (time[j] - doppler_utcs[idx])/(doppler_utcs[idx+1] - doppler_utcs[idx])
        doppler[j] = np.sum(dopplers * [tau, 1 - tau]) + doppler_correction
    return doppler

def convert_baseband(x, f_lo):
    lowpass = scipy.signal.firwin(512, 0.0125)
    return scipy.signal.lfilter(lowpass, 1, x * np.exp(-1j*2*np.pi*np.arange(x.shape[1])*f_lo/fs))

def peak_estimator_parabola(x):
    return np.clip(0.5*(x[2]-x[0])/(2*x[1]-x[0]-x[2]), -0.5, 0.5)

def correlate(x, freq_search_hz = 10):
    hz_per_bin = fs/x.shape[1]
    bin_search = int(np.ceil(freq_search_hz/hz_per_bin))
    f = np.fft.fft(x)
    best_corr = 0
    for freq_bin in range(-bin_search,bin_search):
        corr = np.fft.ifft(f[0,:]*np.conj(np.roll(f[1,:], freq_bin)))
        corr_max = np.max(np.abs(corr))
        if corr_max > best_corr:
            best_ifft = corr
            best_corr = corr_max
            best_freq_bin = freq_bin
    return best_ifft, best_corr, best_freq_bin

def delta_range(x, fft_size, clock_difference):
    return ((np.fmod(x + fft_size/2, fft_size) - fft_size/2)/fs + clock_difference)*c

def main():
    if len(sys.argv) != num_args + 1:
        return usage()
    try:
        freq = float(sys.argv[1])
        time = np.empty(2)
        time[0] = float(sys.argv[4])
        time[1] = float(sys.argv[5])
    except ValueError:
        return usage()

    clock_difference = time[0] - time[1]

    signal = load_signal()
    
    f_lo = estimate_dopplers(time, freq).reshape((2,1))

    signal_bb = convert_baseband(signal, f_lo)

    best_ifft, best_corr, best_freq_bin = correlate(signal_bb)
    np.savez(sys.argv[7] + '/{}_{}.npz'.format(freq, int(time[0])), corr=best_ifft, freq_bin=best_freq_bin, time=time, freq=freq, f_lo=f_lo)

    corr_peak = np.argmax(np.abs(best_ifft))
    corr_peak += peak_estimator_parabola(np.abs(best_ifft[corr_peak-1:corr_peak+2]))
    print('Delta-range (parabola)', delta_range(corr_peak, signal.shape[1], clock_difference))
    delta_velocity = -(best_freq_bin*fs/signal.shape[1] + f_lo[0,0] - f_lo[1,0]) * c / freq
    print('Delta-velocity', delta_velocity)
    
    return 0

if __name__ == "__main__":
    main()
