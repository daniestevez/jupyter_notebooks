#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Copyright 2020 Daniel Estevez <daniel@destevez.net>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

import ccsds

import sys
import pathlib
import functools
import pickle

def usage():
    print(f'Usage: {sys.argv[0]} input_file format output_dir')
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
    if len(sys.argv) != 4:
        usage()
        exit(1)

    frame_type = sys.argv[2]
    if frame_type not in ['full', 'short']:
        usage()
        exit(1)


    infile = pathlib.Path(sys.argv[1])
    f = open(sys.argv[1], 'rb')
    frames = iter(functools.partial(read_frame, f, frame_type), None)

    outdir = pathlib.Path(sys.argv[3])

    packets = list(ccsds.extract_space_packets(frames, 245, 1, get_timestamps = True))
    apids = [ccsds.SpacePacketPrimaryHeader.parse(p[0]).APID for p in packets]
    by_apid = {apid : [p for a,p in zip(apids, packets) if a == apid]
                   for apid in set(apids)}

    for a, ps in by_apid.items():
        apid_dir = outdir / f'APID_{a}'
        apid_dir.mkdir(parents = True, exist_ok = True)
        fname = apid_dir / infile.name
        with open(fname, 'wb') as f:
            pickle.dump(ps, f)        

if __name__ == '__main__':
    main()
