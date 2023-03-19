#!/usr/bin/env python3

import argparse
import asyncio
import datetime
import sys

import numpy as np
import requests
import websockets


def parse_args():
    parser = argparse.ArgumentParser(
        description='Records QO-100 WB transponder waterfall using Maia SDR')
    parser.add_argument('--center_freq', type=int, default=int(745e6),
                        help='Center frequency [default=%(default)r]')
    parser.add_argument('--rx_gain', type=int, default=50,
                        help='RX gain [default=%(default)r]')
    parser.add_argument('--samp_rate', type=int, default=int(20e6),
                        help='Sampling rate [default=%(default)r]')
    parser.add_argument('--spectrum_rate', type=float, default=5,
                        help='Spectrum rate [default=%(default)r]')
    parser.add_argument('--integrations', type=int, default=50,
                        help='integrations [default=%(default)r]')
    parser.add_argument('maiasdr_url', type=str,
                        help='Maia SDR base URL')
    return parser.parse_args()


def setup_maiasdr(args):
    response = requests.patch(
        args.maiasdr_url + '/api/ad9361',
        json={
            'sampling_frequency': args.samp_rate,
            'rx_rf_bandwidth': args.samp_rate,
            'rx_lo_frequency': args.center_freq,
            'rx_gain': args.rx_gain,
            'rx_gain_mode': 'Manual',
        })
    if response.status_code != 200:
        print(response.text)
        sys.exit(1)
    response = requests.patch(
        args.maiasdr_url + '/api/spectrometer',
        json={
            'output_sampling_frequency': args.spectrum_rate,
        })
    if response.status_code != 200:
        print(response.text)
        sys.exit(1)


async def spectrum_loop(args):
    ws_url = 'ws:' + ':'.join(args.maiasdr_url.split(':')[1:]) + '/waterfall'
    async with websockets.connect(ws_url) as ws:
        start = datetime.datetime.utcnow()
        start = start.isoformat().split('.')[0].replace(':', '_')
        tstamp_path = f'QO-100_WB_{start}_timestamps'
        spectrum_path = f'QO-100_WB_{start}_spectrum'
        with (open(tstamp_path, 'wb') as tstamp_f,
              open(spectrum_path, 'wb') as spectrum_f):
            while True:
                t = np.datetime64(datetime.datetime.utcnow()
                                  ).astype('datetime64[ns]')
                specs = []
                for _ in range(args.integrations):
                    specs.append(np.frombuffer(await ws.recv(), 'float32'))
                spec = np.average(specs, axis=0)
                tstamp_f.write(bytes(t))
                spec.tofile(spectrum_f)
                tstamp_f.flush()
                spectrum_f.flush()


def main():
    args = parse_args()
    setup_maiasdr(args)
    asyncio.run(spectrum_loop(args))


if __name__ == '__main__':
    main()
