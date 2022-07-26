#!/usr/bin/env python3

import datetime
import pathlib
import sys
import sigmf
from sigmf.sigmffile import SigMFFile

freqs = {
    'CELESTA': 436500000,
    'MTCube2': 436750000,
    'GREENCUBE': 435310000,
    'ASTROBIO': 437425000,
    'ASTROBIO2': 435600000,
}

times = {
    '2022-07-24T18_47_38': '2022-07-24T18:47:41.418',
    '2022-07-24T19_25_49': '2022-07-24T19:26:03.481',
    '2022-07-24T19_29_02': '2022-07-24T19:29:05.368',
}

for f in pathlib.Path('.').glob('*.sigmf-data'):
    filename = f.name.replace('.sigmf-data', '')
    satellite = filename.split('_')[0]
    collection = 'Vega-C_MEO_cubesats_2022-07-24'
    freq = freqs[satellite]
    time = times['_'.join(filename.split('_')[1:])]

    # create the metadata
    meta = SigMFFile(
        data_file = filename + '.sigmf-data', # extension is optional
        global_info = {
            SigMFFile.DATATYPE_KEY: 'ci16_le',
            SigMFFile.SAMPLE_RATE_KEY: 40000,
            SigMFFile.AUTHOR_KEY: 'Daniel Estévez <daniel@destevez.net>',
            SigMFFile.DESCRIPTION_KEY: f'{satellite} (Vega-C MEO cubesat) 436 MHz telemetry recording',
            SigMFFile.VERSION_KEY: '1.0.0',
            SigMFFile.LICENSE_KEY: 'https://creativecommons.org/licenses/by/4.0/',
            SigMFFile.RECORDER_KEY: 'GNU Radio 3.10',
            SigMFFile.HW_KEY: 'USRP B205mini, 7 element 435 MHz yagi',
            SigMFFile.COLLECTION_KEY: collection,
            }
        )

    # create a capture key at time index 0
    meta.add_capture(0, metadata={
        SigMFFile.FREQUENCY_KEY: freq,
        SigMFFile.DATETIME_KEY: time,
    })

    # check for mistakes & write to disk
    assert meta.validate()
    meta.tofile(filename + '.sigmf-meta') # extension is optional
