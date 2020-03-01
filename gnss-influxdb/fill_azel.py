#!/usr/bin/env python3

from ctypes import *
from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import ASYNCHRONOUS
import sys
import pathlib

libgnsscalcs = CDLL('libgnsscalcs.so')

libgnsscalcs.load_sp3.argtypes = [c_char_p]
libgnsscalcs.compute_azel.argtypes = [c_char_p, POINTER(c_double), c_double, c_double, c_double,
                                    POINTER(c_double)]

satellites_str = 'G01G02G03G04G05G06G07G08G09G10G11G12G13G14G15G16G17G18G19G20G21G22G23G24G25G26G27G28G29G30G31G32R01R02R03R04R05R07R08R09R11R12R13R14R15R16R17R18R19R20R21R22R23R26E01E02E03E04E05E07E08E09E11E12E13E14E15E18E19E21E24E25E26E27E30E31E33E36C06C07C08C09C10C11C12C13C14C16J01J02J03'
satellites = [satellites_str[i:i+3] for i in range(0,len(satellites_str),3)]

def load_sp3(path):
    path = bytes(path, encoding = 'ascii')
    if libgnsscalcs.load_sp3(path) < 0:
        print('Could not load SP3 file')
        exit(1)    

def compute_azel(satellite, ship_record):
    utc_epoch = (c_double * 6)()
    azel = (c_double * 2)()

    timestamp = ship_record.get_time()
    utc_epoch[:] = timestamp.year, timestamp.month, timestamp.day, timestamp.hour, timestamp.minute, timestamp.second

    height = 0
    svn = c_char_p(bytes(satellite, encoding = 'ascii'))
    if libgnsscalcs.compute_azel(svn, utc_epoch, ship_record['lat'], ship_record['lon'], height, azel) < 0:
        raise ValueError
    return list(azel)

def usage():
    print(f'Usage: {sys.argv[0]} sp3_path start_time end_time')
    exit(1)

def main():
    if len(sys.argv) != 4:
        usage()

    sp3_path, start_time, end_time = sys.argv[1:]

    print('Loading SP3 files...')
    for sp3 in pathlib.Path(sp3_path).glob('*.sp3'):
        load_sp3(str(sp3))

    client = InfluxDBClient.from_config_file('influxdb.ini')
    query_api = client.query_api()
    write_api = client.write_api(write_options = ASYNCHRONOUS)

    query = f"""from (bucket:"hesperides")
                |> range(start: {start_time}, stop: {end_time})
                |> aggregateWindow(every: 1m, fn: first)
                |> filter(fn: (r) => r._measurement == "position" and r.ship == "hesperides" and (r._field == "lat" or r._field == "lon"))
                |> pivot(rowKey: ["_time"], columnKey: ["_field"], valueColumn: "_value")"""

    print('Querying InfluxDB for positions...')
    records = query_api.query_stream(query)

    for record in records:
        print('Computing azels for', record.get_time())
        for satellite in satellites:
            azel = compute_azel(satellite, record)
            azel_record = Point('azel').time(record.get_time()).tag('svn', satellite).tag('ship', 'hesperides').field('az', azel[0]).field('el', azel[1])
            write_api.write(bucket = 'gnss', record = azel_record)            

if __name__ == '__main__':
    main()

