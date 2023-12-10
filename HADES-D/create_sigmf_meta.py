#!/usr/bin/env python3

import datetime
import pathlib
import sys
import sigmf
from sigmf.sigmffile import SigMFFile

files = pathlib.Path('.').glob('*.sigmf-data')
for f in files:
    filename = str(f).replace('.sigmf-data', '')
    timestamp = ('2023-12-09T11:14:50.3592431562500000Z'
                 if '2023-12-09T11_14_50' in filename
                 else '2023-12-09T11:20:03.4641939375000000Z')

    # create the metadata
    meta = SigMFFile(
        data_file = filename + '.sigmf-data', # extension is optional
        global_info = {
            SigMFFile.DATATYPE_KEY: 'cf32_le' if '32ksps' in filename else 'ci16_le',
            SigMFFile.SAMPLE_RATE_KEY: 32000 if '32ksps' in filename else 4_000_000,
            SigMFFile.AUTHOR_KEY: 'Daniel Estévez <daniel@destevez.net>',
            SigMFFile.DESCRIPTION_KEY: 'Recording of HADES-D satellite',
            SigMFFile.VERSION_KEY: '1.0.0',
            SigMFFile.LICENSE_KEY: 'https://creativecommons.org/licenses/by/4.0/',
            SigMFFile.RECORDER_KEY: 'GNU Radio 3.10',
            SigMFFile.HW_KEY: (
                '7 element 435 MHz Arrow Yagi (hand pointed), USRP B205mini'),
            SigMFFile.GEOLOCATION_KEY: {
                "type": "Point",
                "coordinates": [-3.696103, 40.596216, 750]
            }
        }
    )

    # create a capture key at time index 0
    meta.add_capture(0, metadata={
        SigMFFile.FREQUENCY_KEY: (436_666_000 if '32ksps' in filename
                                  else 436_500_000),
        SigMFFile.DATETIME_KEY: timestamp,
    })

    meta.tofile(filename + '.sigmf-meta') # extension is optional
