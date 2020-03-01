#!/usr/bin/env python3

from ctypes import *
from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import ASYNCHRONOUS
import sys
import pathlib

libgnsscalcs = CDLL('libgnsscalcs.so')
libgnsscalcs.compute_dops.argtypes = [c_int, POINTER(c_double), c_double, POINTER(c_double)]

def compute_dops(azels, elevmask = 5):
    numsats = len(azels)
    azels_arr = (c_double * (2 * numsats))()
    azels_arr[::2] = [azel[0] for azel in azels]
    azels_arr[1::2] = [azel[1] for azel in azels]
    dops = (c_double * 4)()
    libgnsscalcs.compute_dops(numsats, azels_arr, elevmask, dops)
    return list(dops)

def compute_constellation_dops(record, constellations, elevation_mask = 5):
    sats = [k.rstrip('_el') for k in record.values.keys() if k.endswith('_el')]
    sats_in_constellation = [s for s in sats if s[0] in constellations]
    azels = [(record[f'{sat}_az'], record[f'{sat}_el']) for sat in sats_in_constellation]
    return compute_dops(azels, elevation_mask)

def usage():
    print(f'Usage: {sys.argv[0]} start_time end_time')
    exit(1)

def main():
    if len(sys.argv) != 3:
        usage()

    start_time, end_time = sys.argv[1:]

    client = InfluxDBClient.from_config_file('influxdb.ini')
    query_api = client.query_api()
    write_api = client.write_api(write_options = ASYNCHRONOUS)

    query = f"""import "strings"

                from (bucket: "gnss")
                |> range(start: {start_time}, stop: {end_time})
                |> filter(fn: (r) => r._measurement == "azel" and strings.containsAny(v: r.svn, chars: "GE"))
                |> pivot(rowKey: ["_time"], columnKey: ["svn", "_field"], valueColumn: "_value")"""
    
    print('Querying InfluxDB for azels...')
    records = query_api.query_stream(query)

    for record in records:
        print('Computing DOPs for', record.get_time())
        for constellation in ['E', 'G', 'EG']:
            dops = compute_constellation_dops(record, constellation)
            dop_record = Point('dop').time(record.get_time()).tag('constellation', constellation).\
              tag('ship', record['ship']).\
              field('gdop', dops[0]).\
              field('pdop', dops[1]).\
              field('hdop', dops[2]).\
              field('vdop', dops[3])
            write_api.write(bucket = 'gnss', record = dop_record)

if __name__ == '__main__':
    main()
