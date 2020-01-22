#!/bin/bash

# 435MHz

# 2019-06-03 Harbin, Shahe
# f_offset not known

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1559530800_1559538400.raw 1559530800.233614 Harbin \
			  /mnt/disk/dslwp/china/c64/meta_B_435_Shahe_1559530800_1559538400.raw 1559530800.206071 Shahe \
			  435.4e6 -220 outputs_2019_06/results_2019_06_03_435_harbin_shahe.npy \
			  outputs_2019_06/doppler_2019_06_03_435_harbin_shahe_1.nc outputs_2019_06/doppler_2019_06_03_435_harbin_shahe_2.nc \
			  outputs_2019_06/gmat_2019_06_03_435_harbin_shahe_1.nc outputs_2019_06/gmat_2019_06_03_435_harbin_shahe_2.nc

# 2019-06-06 PI9CAM, Harbin
# f_offset -220Hz

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-06-06T07:00:00_435.4MHz_40ksps_complex_tagged.raw 1559804308.277315 PI9CAM \
			  /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1559804667_1559811700.raw 1559804666.353428 Harbin \
			  435.4e6 -220 outputs_2019_06/results_2019_06_06_435_pi9cam_harbin.npy \
			  outputs_2019_06/doppler_2019_06_06_435_pi9cam_harbin_1.nc outputs_2019_06/doppler_2019_06_06_435_pi9cam_harbin_2.nc \
			  outputs_2019_06/gmat_2019_06_06_435_pi9cam_harbin_1.nc outputs_2019_06/gmat_2019_06_06_435_pi9cam_harbin_2.nc

# 2019-06-07 PI9CAM, Harbin, Shahe
# f_offset -225Hz

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-06-07T08:00:00_435.4MHz_40ksps_complex_tagged.raw 1559894366.287382 PI9CAM \
			  /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1559894100_1559901900.raw 1559894100.358330 Harbin \
			  435.4e6 -225 outputs_2019_06/results_2019_06_07_435_pi9cam_harbin.npy \
			  outputs_2019_06/doppler_2019_06_07_435_pi9cam_harbin_1.nc outputs_2019_06/doppler_2019_06_07_435_pi9cam_harbin_2.nc \
			  outputs_2019_06/gmat_2019_06_07_435_pi9cam_harbin_1.nc outputs_2019_06/gmat_2019_06_07_435_pi9cam_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-06-07T08:00:00_435.4MHz_40ksps_complex_tagged.raw 1559894366.287382 PI9CAM \
			  /mnt/disk/dslwp/china/c64/meta_B_435_Shahe_1559896262_1559901900.raw 1559896261.228034 Shahe \
			  435.4e6 -225 outputs_2019_06/results_2019_06_07_435_pi9cam_shahe.npy \
			  outputs_2019_06/doppler_2019_06_07_435_pi9cam_shahe_1.nc outputs_2019_06/doppler_2019_06_07_435_pi9cam_shahe_2.nc \
			  outputs_2019_06/gmat_2019_06_07_435_pi9cam_shahe_1.nc outputs_2019_06/gmat_2019_06_07_435_pi9cam_shahe_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1559894100_1559901900.raw 1559894100.358330 Harbin \
			  /mnt/disk/dslwp/china/c64/meta_B_435_Shahe_1559896262_1559901900.raw 1559896261.228034 Shahe \
			  435.4e6 -225 outputs_2019_06/results_2019_06_07_435_harbin_shahe.npy \
			  outputs_2019_06/doppler_2019_06_07_435_harbin_shahe_1.nc outputs_2019_06/doppler_2019_06_07_435_harbin_shahe_2.nc \
			  outputs_2019_06/gmat_2019_06_07_435_harbin_shahe_1.nc outputs_2019_06/gmat_2019_06_07_435_harbin_shahe_2.nc

# 436MHz

# 2019-06-03 Harbin, Shahe
# f_offset not known

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1559530800_1559538400.raw 1559530800.233614 Harbin \
			  /mnt/disk/dslwp/china/c64/meta_B_436_Shahe_1559530800_1559538400.raw 1559530800.206071 Shahe \
			  436.4e6 -265 outputs_2019_06/results_2019_06_03_436_harbin_shahe.npy \
			  outputs_2019_06/doppler_2019_06_03_436_harbin_shahe_1.nc outputs_2019_06/doppler_2019_06_03_436_harbin_shahe_2.nc \
			  outputs_2019_06/gmat_2019_06_03_436_harbin_shahe_1.nc outputs_2019_06/gmat_2019_06_03_436_harbin_shahe_2.nc

# 2019-06-06 PI9CAM, Harbin
# f_offset -261Hz

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-06-06T07:00:00_436.4MHz_40ksps_complex_tagged.raw 1559804308.277315 PI9CAM \
			  /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1559804667_1559811700.raw 1559804666.353428 Harbin \
			  436.4e6 -261 outputs_2019_06/results_2019_06_06_436_pi9cam_harbin.npy \
			  outputs_2019_06/doppler_2019_06_06_436_pi9cam_harbin_1.nc outputs_2019_06/doppler_2019_06_06_436_pi9cam_harbin_2.nc \
			  outputs_2019_06/gmat_2019_06_06_436_pi9cam_harbin_1.nc outputs_2019_06/gmat_2019_06_06_436_pi9cam_harbin_2.nc

# 2019-06-07 PI9CAM, Harbin, Shahe
# f_offset -266Hz

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-06-07T08:00:00_436.4MHz_40ksps_complex_tagged.raw 1559894366.287382 PI9CAM \
			  /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1559894100_1559901900.raw 1559894100.358330 Harbin \
			  436.4e6 -266 outputs_2019_06/results_2019_06_07_436_pi9cam_harbin.npy \
			  outputs_2019_06/doppler_2019_06_07_436_pi9cam_harbin_1.nc outputs_2019_06/doppler_2019_06_07_436_pi9cam_harbin_2.nc \
			  outputs_2019_06/gmat_2019_06_07_436_pi9cam_harbin_1.nc outputs_2019_06/gmat_2019_06_07_436_pi9cam_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-06-07T08:00:00_436.4MHz_40ksps_complex_tagged.raw 1559894366.287382 PI9CAM \
			  /mnt/disk/dslwp/china/c64/meta_B_436_Shahe_1559896262_1559901900.raw 1559896261.228034 Shahe \
			  436.4e6 -266 outputs_2019_06/results_2019_06_07_436_pi9cam_shahe.npy \
			  outputs_2019_06/doppler_2019_06_07_436_pi9cam_shahe_1.nc outputs_2019_06/doppler_2019_06_07_436_pi9cam_shahe_2.nc \
			  outputs_2019_06/gmat_2019_06_07_436_pi9cam_shahe_1.nc outputs_2019_06/gmat_2019_06_07_436_pi9cam_shahe_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1559894100_1559901900.raw 1559894100.358330 Harbin \
			  /mnt/disk/dslwp/china/c64/meta_B_436_Shahe_1559896262_1559901900.raw 1559896261.228034 Shahe \
			  436.4e6 -266 outputs_2019_06/results_2019_06_07_436_harbin_shahe.npy \
			  outputs_2019_06/doppler_2019_06_07_436_harbin_shahe_1.nc outputs_2019_06/doppler_2019_06_07_436_harbin_shahe_2.nc \
			  outputs_2019_06/gmat_2019_06_07_436_harbin_shahe_1.nc outputs_2019_06/gmat_2019_06_07_436_harbin_shahe_2.nc

