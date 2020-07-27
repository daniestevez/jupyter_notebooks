#!/usr/bin/env python3

import numpy as np
from astropy.time import Time
from astropy import units as u
from astropy.coordinates import Angle

import sys

mjd_unixtimestamp_offset = 10587.5
seconds_in_day = 3600 * 24

def mjd2unixtimestamp(m):
    return (m - mjd_unixtimestamp_offset) * seconds_in_day



report = np.fromfile(sys.argv[1], sep = ' ').reshape((-1,4))
t = Time(np.round(mjd2unixtimestamp(report[:,0])), format='unix')
ra = Angle(report[:,1], unit = u.deg).wrap_at(360 * u.deg)
dec = Angle(report[:,2], unit = u.deg)
rmag = report[:,3]

with open(sys.argv[2], 'w') as f:
    print('Timestamp              RA (HHMMSS)  DEC (DDMMSS)  Distance (km)', file = f)
    for tt,r,d,mag in zip(t.datetime, ra, dec,rmag):
        print(f'{tt}    {int(r.hms.h):02d}{int(r.hms.m):02d}{int(round(r.hms.s)):02d}       {int(d.dms.d):02d}{int(d.dms.m):02d}{int(round(d.dms.s)):02d}        {mag:.3f}',
                  file = f)
