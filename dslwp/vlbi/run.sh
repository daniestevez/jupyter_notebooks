#!/bin/bash

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/vlbi/c64/DSLWP-B_PI9CAM_2018-11-21_436MHz.raw 1542822198.224856 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/vlbi/c64/meta_B_436_Beijing_1542819300_1542827100.raw 1542819300.208239 Shahe \
			  436.4e6 -250 outputs/results_pi9cam_shahe.npy outputs/doppler_pi9cam_shahe_1.nc outputs/doppler_pi9cam_shahe_2.nc outputs/gmat_pi9cam_shahe_1.nc outputs/gmat_pi9cam_shahe_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/vlbi/c64/DSLWP-B_PI9CAM_2018-11-21_436MHz.raw 1542822198.224856 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/vlbi/c64/meta_B_436_Harbin_1542819300_1542827100.raw 1542819300.227890 Harbin \
			  436.4e6 -250 outputs/results_pi9cam_harbin.npy outputs/doppler_pi9cam_harbin_1.nc outputs/doppler_pi9cam_harbin_2.nc outputs/gmat_pi9cam_harbin_1.nc outputs/gmat_pi9cam_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/vlbi/c64/meta_B_436_Beijing_1542819300_1542827100.raw 1542819300.208239 Shahe \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/vlbi/c64/meta_B_436_Harbin_1542819300_1542827100.raw 1542819300.227890 Harbin \
			  436.4e6 -250 outputs/results_shahe_harbin.npy outputs/doppler_shahe_harbin_1.nc outputs/doppler_shahe_harbin_2.nc outputs/gmat_shahe_harbin_1.nc outputs/gmat_shahe_harbin_2.nc
