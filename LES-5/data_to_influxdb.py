#!/usr/bin/env python3

from influxdb_client import InfluxDBClient, Point
from influxdb_client.domain.write_precision import WritePrecision
import rx
from rx import operators as ops
import sys
import struct

def regs(path):
    f = open(path, 'rb')
    while True:
        r = f.read(36)
        if not r:
            break
        yield r

def point(reg):
    fields = struct.unpack('I32B', reg)
    words = fields[1:]
    words_idx = [w for w in range(31) if w % 5 != 0]
    p = Point('frame')
    p.time(fields[0])
    for idx in words_idx:
        p.field(f'word_{idx:02d}', words[idx])
    frame_number = (words[2] >> 2) & 0x3
    p.tag('frame_number', frame_number)
    if frame_number == 0 and words[7] == 0b11110100:
        p.tag('start_of_group', True)
    return p
        
def usage():
    print(f'Usage: {sys.argv[0]} data_file')
    exit(1)

def main():
    if len(sys.argv) != 2:
        usage()

    data_file = sys.argv[1]

    client = InfluxDBClient.from_config_file('influxdb.ini')
    write_api = client.write_api()

    data = rx.from_iterable(regs(data_file)) \
      .pipe(ops.map(point))

    write_api.write(bucket = 'les5', record = data, write_precision = WritePrecision.S)
    
    write_api.__del__()
    client.__del__()

if __name__ == '__main__':
    main()

    
