#!/usr/bin/env python3

# Converts a GMAT report file with ECEF coordinates
# into a tracking file in the format used by gr-dswlp
#
# This script reads a GMAT report with columns
# MJD X Y Z VX VY VZ
# (in ECEF)
# in the standard input and writes to the standard output

import sys

for l in sys.stdin.readlines():
    s = l.split()
    utc = int(round((float(s[0]) - 10587.5) * 24 * 3600))
    x, y, z = map(float, s[1:4])
    vx, vy, vz = map(float, s[4:7])
    print('{:010d} {:015f} {:015f} {:015f} {:010f} {:010f} {:010f}'.format(utc, x, y, z, vx, vy, vz))
