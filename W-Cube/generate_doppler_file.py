#!/usr/bin/env python3

import argparse
import datetime

import numpy as np
import scipy.constants
import skyfield.api
from skyfield.api import wgs84, EarthSatellite


DAY_S = 24 * 3600


ts = skyfield.api.load.timescale()


# ESTEC groundstation
groundstation = wgs84.latlon(
    52.218494723816654, 4.419545169893418, 0.0)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('tle_file')
    parser.add_argument('unix_timestamp', type=float)
    parser.add_argument('--time-step', default=0.1, type=float)
    parser.add_argument('--duration', default=15*60, type=float)
    parser.add_argument('--f-carrier', default=75e9, type=float)
    return parser.parse_args()


def main():
    args = parse_args()
    with open(args.tle_file) as f:
        lines = f.readlines()
    if len(lines) != 2:
        raise RuntimeError('TLE file must have exactly 2 lines')
    unix_epoch = datetime.datetime(1970, 1, 1, tzinfo=skyfield.api.utc)
    satellite = EarthSatellite(lines[0], lines[1], 'W-CUBE', ts)
    t0 = unix_epoch + datetime.timedelta(seconds=args.unix_timestamp)
    t0 = ts.from_datetime(t0.replace(tzinfo=skyfield.api.utc))
    t = t0 + np.arange(0, (args.duration + args.time_step) / DAY_S,
                       args.time_step / DAY_S)
    t = ts.tai_jd([s.tai for s in t])
    topocentric = (satellite - groundstation).at(t)
    range_rate = topocentric.frame_latlon_and_rates(
        groundstation)[5].km_per_s * 1e3
    doppler = - range_rate / scipy.constants.c * args.f_carrier
    for s, f in zip(t, doppler):
        s = (s.utc_datetime() - unix_epoch).total_seconds()
        print(f'{s}\t{f}')


if __name__ == '__main__':
    main()
