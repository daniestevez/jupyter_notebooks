#!/usr/bin/env python3

import argparse

from astroquery.jplhorizons import Horizons
from astropy.time import Time, TimeDelta
import matplotlib.pyplot as plt
import numpy as np
import scipy.constants


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--downlink-carrier-frequency', type=float, required=True,
                        help='Downlink carrier frequency (MHz)')
    parser.add_argument('--receiver', type=str, default='Hat Creek',
                        help=('Receiver [default=%(default)r]'))
    parser.add_argument('--transmitter', type=str, default='Goldstone',
                        help=('Transmitter [default=%(default)r]'))
    parser.add_argument('--spacecraft', type=str, required=True,
                        help='Spacecraft name')
    parser.add_argument('--start-epoch', type=str, required=True,
                        help='Start epoch (ISO 8601 format)')
    parser.add_argument('--duration', type=float, required=True,
                        help='Duration (seconds)')
    parser.add_argument('--time-step', type=float, default=10.0,
                        help='Time step (seconds) [default=%(default)r]')
    parser.add_argument('--output-file', type=str, required=True,
                        help='Output file path')
    parser.add_argument('--simulation-mode', action='store_true',
                        help='Simulation mode (inverts sign of output)')
    parser.add_argument('--add-offset', type=float, default=0.0,
                        help='Add offset (Hz) to output [default=%(default)r]')
    parser.add_argument('--plot', action='store_true',
                        help='Show plot')
    return parser.parse_args()


def main():
    args = parse_args()

    num_steps = int(np.ceil(args.duration / args.time_step))
    start_epoch = Time(args.start_epoch)
    stop_epoch = start_epoch + TimeDelta(args.duration, format='sec')

    query_up = Horizons(
        id=args.spacecraft, location=args.transmitter,
        epochs={'start': start_epoch.value,
                'stop': stop_epoch.value,
                'step': str(num_steps)},
    )
    eph_up = query_up.ephemerides()
    query_down = Horizons(
        id=args.spacecraft, location=args.receiver,
        epochs={'start': start_epoch.value,
                'stop': stop_epoch.value,
                'step': str(num_steps)},
    )
    eph_down = query_up.ephemerides()
    delta_rate = (eph_up['delta_rate'] + eph_down['delta_rate']) * 1e3  # convert km -> m
    carrier_freq = args.downlink_carrier_frequency * 1e6  # convert MHz -> Hz
    doppler = -delta_rate / scipy.constants.c * carrier_freq

    times = Time(eph_down['datetime_jd'], format='jd')
    ts = times.unix
    fs = doppler.value.data + args.add_offset
    fs_output = -fs if args.simulation_mode else fs
    with open(args.output_file, 'w') as doppler_file:
        for t, f in zip(ts, fs_output):
            print(t, f, file=doppler_file)

    if args.plot:
        plt.plot(times.datetime, fs)
        plt.title(f'HORIZONS Doppler data for {args.spacecraft} '
                  f'at {args.downlink_carrier_frequency:.3f} MHz '
                  f'(transmitter {args.transmitter}, receiver {args.receiver})')
        plt.xlabel('UTC time')
        plt.ylabel('Doppler frequency (Hz)')
        plt.show()


if __name__ == '__main__':
    main()
