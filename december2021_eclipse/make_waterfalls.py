#!/usr/bin/env python3

import argparse
import pathlib

import numpy as np


def waterfall(input_filename, output_filename):
    fs = 200
    nfft = 8192
    w = np.blackman(nfft)
    x = np.fromfile(input_filename, 'int16')
    x = (x[::2] + 1j*x[1::2])/2**15
    freq_span = 5
    nbins = round(freq_span / fs * nfft)
    # In these recordings the internal reference was used, so there
    # is a frequency offset
    freq_offset = 11.6 if '2021-12-08T12:57:25' in input_filename.name else 0
    band = int(input_filename.name.split('_')[-2].replace('kHz', ''))
    # 1.6 Hz offset is at 10 MHz
    freq_offset *= band / 10000
    bin_offset = round(freq_offset / fs * nfft)
    freq_sel = slice(nfft//2-nbins+bin_offset, nfft//2+nbins+1+bin_offset)
    x = x[:x.size//nfft*nfft]
    f = np.fft.fftshift(
        np.fft.fft(w * x.reshape(-1, nfft)),
        axes=1)
    f = np.abs(f[:, freq_sel])**2
    np.save(output_filename, f.astype('float32'))


def parse_args():
    parser = argparse.ArgumentParser(
        description='Make waterfalls from the December 2021 eclipse IQ data')
    parser.add_argument('input_folder',
                        help='Input folder')
    parser.add_argument('output_folder',
                        help='Output folder')
    return parser.parse_args()


def main():
    args = parse_args()
    input_files = pathlib.Path(args.input_folder).glob('*.sigmf-data')
    output_path = pathlib.Path(args.output_folder)
    for f_in in input_files:
        f_out_name = f_in.name.replace('.sigmf-data', '_waterfall.npy')
        f_out = output_path / f_out_name
        waterfall(f_in, f_out)


if __name__ == '__main__':
    main()
