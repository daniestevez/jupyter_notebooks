#!/usr/bin/env python3

import argparse
import gzip
import json
import pathlib
import shutil
import sys


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--min-time', default=1720858800, type=float)
    parser.add_argument('--max-time', default=1720858800+7300, type=float)
    parser.add_argument('--min-lat', default=39, type=float)
    parser.add_argument('--max-lat', default=42.5, type=float)
    parser.add_argument('--min-lon', default=-5.5, type=float)
    parser.add_argument('--max-lon', default=-1.0, type=float)
    parser.add_argument('traces')
    parser.add_argument('geofenced')
    return parser.parse_args()


def check_trace(filename, args):
    with gzip.open(filename) as f:
        dataz = f.read()
    data = json.loads(dataz)
    timestamp = data['timestamp']
    for point in data['trace']:
        time = timestamp + point[0]
        if time < args.min_time or time > args.max_time:
            continue
        lat = point[1]
        if lat < args.min_lat or lat > args.max_lat:
            continue
        lon = point[2]
        if lon < args.min_lon or lon > args.max_lon:
            continue
        return True
    return False


def main():
    args = parse_args()
    traces = pathlib.Path(args.traces).rglob('*.json')
    geofenced = pathlib.Path(args.geofenced)
    copied = set()
    for trace in traces:
        print(trace.name)
        if check_trace(trace, args):
            if trace.name in copied:
                raise RuntimeError(f'{trace.name} already copied')
            shutil.copyfile(trace, geofenced / trace.name)
            copied.add(trace.name)


if __name__ == '__main__':
    main()
