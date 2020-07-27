#!/usr/bin/env python3

import numpy as np
import struct
from construct import *

import sys
from datetime import datetime, timedelta

AOSPrimaryHeader = BitStruct('transfer_frame_version_number' / BitsInteger(2),
                                 'spacecraft_id' / BitsInteger(8),
                                 'virtual_channel_id' / BitsInteger(6),
                                 'virtual_channel_frame_count' / BitsInteger(24),
                                 'replay_flag' / Flag,
                                 'vc_frame_count_usage_flag' / Flag,
                                 'rsvd_spare' / BitsInteger(2),
                                 'vc_framecount_cycle' / BitsInteger(4))




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

def main():
    if len(sys.argv) != 3:
        usage()
        exit(1)

    frame_type = sys.argv[2]
    if frame_type not in ['full', 'short']:
        usage()
        exit(1)

    frame_size = 220 if frame_type == 'short' else 256
    frames = np.fromfile(sys.argv[1], dtype = 'uint8')
    frames = frames[:frames.size//frame_size*frame_size].reshape((-1, frame_size))
    if frame_size == 256:
        frames = frames[:,4:-32] # throw away syncword and RS check bytes

    #  parse AOS primary headers
    primary_headers = [AOSPrimaryHeader.parse(bytes(f)) for f in frames]
    sc_id = np.array([p.spacecraft_id for p in primary_headers])
    vcid = np.array([p.virtual_channel_id for p in primary_headers])
    vcfc = np.array([p.virtual_channel_frame_count for p in primary_headers])

    # State vectors are contained in the last 48 bytes of frames using
    # spacecraft ID 245, virtual channel 1 and having virtual channel
    # frame count equal to 22 moulo 64
    # These frames are transmitted every 32 seconds
    state_vector_frames = (sc_id == 245) & (vcid == 1) & (vcfc % 64 == 22)

    # The unexplained correction of -3400.2 seconds below has been
    # determined experimentally by using data collected by M0EYT
    # on 2020-07-23 06 to 07 UTC when the spacecraft was ~30e3 km
    # from Earth and trying to adjust the timestamp for a best fit
    # between propagation of the first vector, and the last vector
    # in the data series
    epoch = datetime(2020, 7, 23) - timedelta(seconds = 3400.2)


    for frame in frames[state_vector_frames]:
        timestamp = epoch + timedelta(seconds = struct.unpack('>I', bytes(frame[120:124]))[0] * 1e-4)
        state_vector = struct.unpack('>6d', bytes(frame[-6*8:]))
        print(timestamp, *(s for s in state_vector))

if __name__ == '__main__':
    main()
