#!/bin/sh

~/gr-satellites/examples/doppler_correction/tle_to_doppler_file.py --tle-file hades-d.tle --unix-timestamp 1702120490 \
	--f-carrier 436.666e6 --output-file hades-d_doppler_1702120490.txt \
       	--lat 40.596216 --lon=-3.696103 --alt 750
