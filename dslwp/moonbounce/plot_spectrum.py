#!/usr/bin/env python3

import numpy as np
import xarray as xr
import matplotlib.pyplot as plt

import sys
import pathlib

def plot_centre_spectrum(spectrum, bins = 2000):
    freqsel = slice(spectrum.coords['freq'].size//2-bins//2,spectrum.coords['freq'].size//2+bins//2)
    (10*np.log10(spectrum[freqsel])).plot()

def do_plots(spectrum, out_path): # TODO add recording start-end
    plt.figure(figsize = (12,8))
    plot_centre_spectrum(spectrum['spectrum_direct'])
    plot_centre_spectrum(spectrum['spectrum_moonbounce'])
    plt.title('Doppler corrected spectrum\n{start} - {end} {baudrate}baud'.format(\
                start = spectrum.attrs['recording_start'],\
                end = spectrum.attrs['recording_end'].split('.')[0],\
                baudrate = spectrum.attrs['gmsk_baudrate']))
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('PSD (dB/Hz)')
    plt.legend(['Direct', 'Moonbounce'])
    plt.savefig(out_path)
    plt.close()

def process(input_file, output_file):
    s = xr.open_dataset(input_file)
    do_plots(s, output_file)

def usage(f = sys.stderr):
    print(f'Usage: {sys.argv[0]} input_folder output_folder')
    
def main():
    if len(sys.argv) != 3:
        usage()
        sys.exit(1)

    input_path = pathlib.Path(sys.argv[1])
    output_path = pathlib.Path(sys.argv[2])

    for input_file in input_path.glob('*_spectrum.nc'):
        tag = input_file.name.strip('_spectrum.nc')
        output_file = output_path / (tag + '.jpg')
        process(input_file, output_file)        

if __name__ == '__main__':
    main()
