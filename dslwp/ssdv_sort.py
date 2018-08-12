#!/usr/bin/env python3

import numpy as np
import subprocess
import sys

def seqnum(packet):
    return packet[1]*256 + packet[2]

input_file = sys.argv[1]
output_file = sys.argv[2]

x = np.fromfile(input_file, dtype='uint8').reshape((-1,218))
ids = set(x[:,0])

for i in ids:
    l = list(x[x[:,0]==i,:])
    l.sort(key=seqnum)
    ssdv = '{}_{}.ssdv'.format(output_file, i)
    jpeg = '{}_{}.jpg'.format(output_file, i)
    np.array(l).tofile(ssdv)
    print('Calling SSDV decoder for image {}'.format(hex(i)))
    subprocess.call(['ssdv', '-d', '-D', ssdv, jpeg])
    print()
