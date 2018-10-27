#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import scipy.io.wavfile
import scipy.signal
import sys

def get_asm(baudrate):
    if baudrate == 500:
        a = [0x03, 0x47, 0x76, 0xC7, 0x27, 0x28, 0x95, 0xB0, 0xFC, 0xB8, 0x89, 0x38, 0xD8, 0xD7, 0x6A, 0x4F]
    elif baudrate == 250:
        a = [0x03,0x47,0x76,0xC7,0x27,0x28,0x95,0xB0]
    else:
        raise ValueError
    return np.unpackbits(np.array(a, dtype='uint8'))

def open_wav(path):
    rate, x = scipy.io.wavfile.read(path)
    x = x.astype('float')
    if len(x.shape) > 1: # iq file
        x = x[:,0] + 1j*x[:,1]
    return rate, x

def gaussian_taps(bt, samples_per_symbol, ntaps):
    taps = np.exp(-2*np.pi**2*bt**2*(np.arange(ntaps) - ntaps/2)**2/(np.log(2)*samples_per_symbol**2))
    return taps / np.sum(taps)

def generate_asm_samples(rate, baudrate):
    asm = get_asm(baudrate)
    asm_diff = asm[:-1] ^ asm[1:]
    asm_diff[1::2] ^= 1
    samples_per_symbol = rate // baudrate
    taps = np.convolve(gaussian_taps(0.5, samples_per_symbol, 4*samples_per_symbol), np.ones(samples_per_symbol))
    asm_interp = np.zeros(asm_diff.size * samples_per_symbol)
    asm_interp[::samples_per_symbol] = 2*asm_diff.astype('float')-1
    f_samps = scipy.signal.lfilter(taps, 1, asm_interp)[samples_per_symbol:]
    sensitivity = (np.pi / 2) / samples_per_symbol
    phase = np.cumsum(f_samps) * sensitivity
    return np.exp(1j*phase)

def compute_acq(x, rate, baudrate):
    asm = np.conj(generate_asm_samples(rate, baudrate))
    step = int((rate/baudrate)/4)
    acq = np.zeros(((x.size-asm.size)//step, asm.size))
    for j, offset in enumerate(range(0,(x.size-asm.size)//step*step,step)):
        acq[j,:] = np.abs(np.fft.fftshift(np.fft.fft(x[offset:offset+asm.size] * asm)))**2
    return acq, step

def cn0_estimator(acq, rate, tsync, fsync):
    f = acq[tsync,:]
    n = (np.average(f[fsync-50:fsync-4]) + np.average(f[fsync+5:fsync+51]))/2 # noise per FFT bin
    c = np.sum(f[fsync-1:fsync+2]) - 3*n
    hz_per_bin = rate / f.size
    n0 = n/hz_per_bin # noise per Hz
    return 10*np.log10(c/n0)

def print_usage():
    print('Usage: {} baudrate input.wav output_path label'.format(sys.argv[0]), file=sys.stderr)

def main():
    if len(sys.argv) != 5:
        print_usage()
        exit(1)

    baudrate = int(sys.argv[1])
    if baudrate != 250 and baudrate != 500:
        print('Baudrate needs to be either 250 or 500')
        exit(1)
    
    output_path = sys.argv[3]
    label = sys.argv[4]

    rate, x = open_wav(sys.argv[2])

    if rate % baudrate != 0:
        print('Input file sample rate must be a multiple of {}'.format(baudrate), file=sys.stderr)
        exit(1)

    acq, step = compute_acq(x, rate, baudrate)
    tsync = np.argmax(np.max(acq, axis=1))
    fsync = np.argmax(acq[tsync,:])
    ts = np.arange(acq.shape[0]) * step / rate
    fs = np.arange(-acq.shape[1]//2, acq.shape[1]//2) * rate / acq.shape[1]

    cn0 = cn0_estimator(acq, rate, tsync, fsync)
    ebn0 = cn0 - 10*np.log10(baudrate)
    snr = cn0 - 10*np.log10(2500)
    snr_info = 'CN0: {:.1f}dB, EbN0: {:.1f}dB, SNR (in 2500Hz): {:.1f}dB'.format(cn0, ebn0, snr)

    print('Start time: {:.2f}s\nFrequency: {:.1f}Hz\n{}'.format(ts[tsync], fs[fsync], snr_info))

    snr_str = '{:.1f}dB'.format(snr)

    plt.figure()
    plt.plot(ts, np.max(acq, axis=1))
    plt.title('{}: sync in time ({} SNR)'.format(label, snr_str))
    plt.xlabel('Transmission start (s)')
    plt.ylabel('Correlation')
    plt.savefig(output_path + '_time.png')

    plt.figure()
    plt.plot(ts[tsync-25:tsync+25], np.max(acq, axis=1)[tsync-25:tsync+25], '.-')
    plt.title('{}: sync in time (zoom) ({} SNR)'.format(label, snr_str))
    plt.xlabel('Transmission start (s)')
    plt.ylabel('Correlation')
    plt.savefig(output_path + '_time_fine.png')
    
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
