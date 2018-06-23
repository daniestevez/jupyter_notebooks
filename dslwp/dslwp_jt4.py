#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import scipy.io.wavfile
import scipy.signal
import sys

sync = 2*np.array(list(map(int,'00011000110110010100000001100000000000010110110101111101000100100111110001010001111011001000110101010101111101010110101011100101101111000011011000111011101110010001101100100011111100110000110001011011110101')), dtype='int8')-1

def open_wav(path):
    rate, x = scipy.io.wavfile.read(path)
    x = x.astype('float')
    if len(x.shape) > 1: # iq file
        x = x[:,0] + 1j*x[:,1]
    return rate, x

def compute_acq(x, fs):
    N = 8 * fs // 35 # fft size
    f_shift = 312.5 / 4.375
    f_shifts = np.int32(np.round(np.arange(1,4)*f_shift))
    
    f_even = np.abs(np.fft.fftshift(np.fft.fft(x[:x.size//N*N].reshape((-1, N)), axis=1), axes=1))**2/N
    f_even = f_even[:,f_shifts[0]:-f_shifts[2]+f_shifts[0]] + f_even[:,f_shifts[2]:] - f_even[:,:-f_shifts[2]] - f_even[:,f_shifts[1]:-f_shifts[2]+f_shifts[1]]
    f_odd = np.abs(np.fft.fftshift(np.fft.fft(x[N//2:x.size//N*N-N//2].reshape((-1, N)), axis=1), axes = 1))**2/N
    f_odd = f_odd[:,f_shifts[0]:-f_shifts[2]+f_shifts[0]] + f_odd[:,f_shifts[2]:] - f_odd[:,:-f_shifts[2]] - f_odd[:,f_shifts[1]:-f_shifts[2]+f_shifts[1]]

    acq = np.empty((f_even.shape[0] + f_odd.shape[0] - 2*sync.size + 2, f_even.shape[1]))
    acq[::2,:] = scipy.signal.lfilter(sync[::-1], 1, f_even, axis=0)[sync.size-1:,:]
    acq[1::2,:] = scipy.signal.lfilter(sync[::-1], 1, f_odd, axis=0)[sync.size-1:,:]

    return acq

def snr_estimator(x, fs, tsync, fsync):
    N = 8 * fs // 35 # fft size
    f_shift = 312.5 / 4.375
    f_shifts = np.int32(np.round(np.arange(1,4)*f_shift))
    
    f = np.sum(np.abs(np.fft.fftshift(np.fft.fft(x[N//2*tsync:N//2*tsync + sync.size*N].reshape((sync.size, N)), axis=1), axes=1))**2, axis=0)
    f = f[f_shifts[0]:-f_shifts[2]+f_shifts[0]] + f[f_shifts[2]:] + f[:-f_shifts[2]] + f[f_shifts[1]:-f_shifts[2]+f_shifts[1]]
    n = (np.average(f[fsync-50:fsync-10]) + np.average(f[fsync+10:fsync+50]))/8 # noise per FFT bin
    s = np.sum(f[fsync-2:fsync+3]) - 4*5*n
    n = n*2500/4.375 # noise per 2500Hz
    return 10*np.log10(s/n)

def print_usage():
    print('Usage: {} input.wav output_path label'.format(sys.argv[0]), file=sys.stderr)

def main():
    if len(sys.argv) != 4:
        print_usage()
        exit(1)

    output_path = sys.argv[2]
    label = sys.argv[3]

    rate, x = open_wav(sys.argv[1])

    if rate % 35 != 0:
        print('Input file sample rate must be a multiple of 35', file=sys.stderr)
        exit(1)

    acq = compute_acq(x, rate)
    tsync = np.argmax(np.max(acq, axis=1))
    fsync = np.argmax(acq[tsync,:])
    ts = np.arange(acq.shape[0])/2/4.375
    fs = np.fft.fftshift(np.fft.fftfreq(8*rate//35, 1/rate))[:acq.shape[1]] #np.arange(-acq.shape[1]//2, acq.shape[1]//2)*4.375

    snr = snr_estimator(x, rate, tsync, fsync)
    snr_str = '{:.1f}dB'.format(snr)

    print('Start time: {:.2f}s\nFrequency: {:.1f}Hz\nSNR: {} in 2500Hz'.format(ts[tsync], fs[fsync], snr_str))

    plt.figure()
    plt.plot(ts, np.max(acq, axis=1))
    plt.title('{}: sync in time ({} SNR)'.format(label, snr_str))
    plt.xlabel('Transmission start (s)')
    plt.ylabel('Correlation')
    plt.savefig(output_path + '_time.png')

    plt.figure()
    plt.plot(fs, acq[tsync,:])
    plt.title('{}: sync in frequency ({} SNR)'.format(label, snr_str))
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Correlation')
    plt.savefig(output_path + '_freq.png')

    span = 50
    plt.figure()
    plt.plot(fs[fsync-span:fsync+span], acq[tsync,fsync-span:fsync+span],'.-')
    plt.title('{}: sync in frequency (zoom) ({} SNR)'.format(label, snr_str))
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Correlation')
    plt.savefig(output_path + '_freq_fine.png')

    return 0

if __name__ == "__main__":
    main()
