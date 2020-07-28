#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Copyright 2018-2019 Daniel Estevez <daniel@destevez.net>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

import ccsds

import sys
from datetime import datetime, timedelta
import struct
import functools

def usage():
    print(f'Usage: {sys.argv[0]} input_file format')
    print()
    print('Format can be either full or short')
    print("""Full indicates a file format which is a concatenation of
256 byte frames composed by the 4 byte CCSDS syncword, 220 bytes of
useful data (which is an AOS Space Data Link frame) and 32 Reed-Solomon
parity check bytes (which are ignored here).

Short indicates a file format which is a concatenation of 220 byte
frames composed only by the useful data.""")

def read_frame(f, frame_type):
    frame_size = 220 if frame_type == 'short' else 256
    b = f.read(frame_size)
    if not b:
        return None
    if frame_type == 'full':
        b = b[4:-32]
    return ccsds.AOSFrame.parse(b)
    
def main():
    if len(sys.argv) != 3:
        usage()
        exit(1)

    frame_type = sys.argv[2]
    if frame_type not in ['full', 'short']:
        usage()
        exit(1)


    f = open(sys.argv[1], 'rb')
    frames = iter(functools.partial(read_frame, f, frame_type), None)

    # The unexplained correction of -3400.2 seconds below has been
    # determined experimentally by using data collected by M0EYT
    # on 2020-07-23 06 to 07 UTC when the spacecraft was ~30e3 km
    # from Earth and trying to adjust the timestamp for a best fit
    # between propagation of the first vector, and the last vector
    # in the data series
    epoch = datetime(2015,12,31,16,00,00)
    print('Using epoch', epoch)

    for packet in ccsds.extract_space_packets(frames, 245, 1):
        if ccsds.SpacePacketPrimaryHeader.parse(packet).APID == 1287:
            timestamp_field = packet[18:][:6]
            timestamp_value = struct.unpack('>Q', b'\x00\x00' + timestamp_field)[0]
            timestamp = epoch + timedelta(seconds = timestamp_value * 1e-4)
            state_vector = struct.unpack('>6d', packet[72:][:6*8])
            print(f'[{timestamp_field.hex()}]', timestamp, *(s for s in state_vector))

if __name__ == '__main__':
    main()
