#!/bin/bash

# 435MHz

# 2019-06-30 Dwingeloo, Harbin
# f_offset -256 (unknown)

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Dwingeloo_2019-06-30.raw 1561873858.194385 PI9CAM \
                          /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1561872540_1561879860.raw 1561872540.097832 Harbin \
			  435.4e6 -256 outputs_2019_07/results_2019_06_30_435_pi9cam_harbin.npy \
			  outputs_2019_07/doppler_2019_06_30_435_pi9cam_harbin_1.nc outputs_2019_07/doppler_2019_06_30_435_pi9cam_harbin_2.nc \
			  outputs_2019_07/gmat_2019_06_30_435_pi9cam_harbin_1.nc outputs_2019_07/gmat_2019_06_30_435_pi9cam_harbin_2.nc

# 2019-07-01 Dwingeloo, Harbin
# f_offset -256 (unknown)

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Dwingeloo_2019-07-01.raw 1561960652.677609 PI9CAM \
                          /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1561959300_1561966260.raw 1561959300.217615 Harbin \
			  435.4e6 -256 outputs_2019_07/results_2019_07_01_435_pi9cam_harbin.npy \
			  outputs_2019_07/doppler_2019_07_01_435_pi9cam_harbin_1.nc outputs_2019_07/doppler_2019_07_01_435_pi9cam_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_01_435_pi9cam_harbin_1.nc outputs_2019_07/gmat_2019_07_01_435_pi9cam_harbin_2.nc


# 2019-07-03 Dwingeloo, Harbin
# f_offset -256

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Dwingeloo_2019-07-03.raw 1562133983.611612 PI9CAM \
                          /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1562133300_1562141100.raw 1562133300.223793 Harbin \
			  435.4e6 -256 outputs_2019_07/results_2019_07_03_435_pi9cam_harbin.npy \
			  outputs_2019_07/doppler_2019_07_03_435_pi9cam_harbin_1.nc outputs_2019_07/doppler_2019_07_03_435_pi9cam_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_03_435_pi9cam_harbin_1.nc outputs_2019_07/gmat_2019_07_03_435_pi9cam_harbin_2.nc

# 2019-07-04 Dwingeloo, Shahe, Harbin, Wakayama
# f_offset -254

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Dwingeloo_2019-07-04.raw 1562223867.847919 PI9CAM \
                          /mnt/disk/dslwp/china/c64/meta_B_435_Shahe_1562221500_1562229300.raw 1562221500.199090 Shahe \
			  435.4e6 -254 outputs_2019_07/results_2019_07_04_435_pi9cam_shahe.npy \
			  outputs_2019_07/doppler_2019_07_04_435_pi9cam_shahe_1.nc outputs_2019_07/doppler_2019_07_04_435_pi9cam_shahe_2.nc \
			  outputs_2019_07/gmat_2019_07_04_435_pi9cam_shahe_1.nc outputs_2019_07/gmat_2019_07_04_435_pi9cam_shahe_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Dwingeloo_2019-07-04.raw 1562223867.847919 PI9CAM \
                          /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1562221500_1562229300.raw 1562221500.224388 Harbin \
			  435.4e6 -254 outputs_2019_07/results_2019_07_04_435_pi9cam_harbin.npy \
			  outputs_2019_07/doppler_2019_07_04_435_pi9cam_harbin_1.nc outputs_2019_07/doppler_2019_07_04_435_pi9cam_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_04_435_pi9cam_harbin_1.nc outputs_2019_07/gmat_2019_07_04_435_pi9cam_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Dwingeloo_2019-07-04.raw 1562223867.847919 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-04.raw 1562221414.427565 Wakayama \
			  435.4e6 -254 outputs_2019_07/results_2019_07_04_435_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_04_435_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_04_435_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_04_435_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_04_435_pi9cam_wakayama_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_435_Shahe_1562221500_1562229300.raw 1562221500.199090 Shahe \
			  /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1562221500_1562229300.raw 1562221500.224388 Harbin \
			  435.4e6 -254 outputs_2019_07/results_2019_07_04_435_shahe_harbin.npy \
			  outputs_2019_07/doppler_2019_07_04_435_shahe_harbin_1.nc outputs_2019_07/doppler_2019_07_04_435_shahe_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_04_435_shahe_harbin_1.nc outputs_2019_07/gmat_2019_07_04_435_shahe_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_435_Shahe_1562221500_1562229300.raw 1562221500.199090 Shahe \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-04.raw 1562221414.427565 Wakayama \
			  435.4e6 -254 outputs_2019_07/results_2019_07_04_435_shahe_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_04_435_shahe_wakayama_1.nc outputs_2019_07/doppler_2019_07_04_435_shahe_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_04_435_shahe_wakayama_1.nc outputs_2019_07/gmat_2019_07_04_435_shahe_wakayama_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1562221500_1562229300.raw 1562221500.224388 Harbin \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-04.raw 1562221414.427565 Wakayama \
			  435.4e6 -254 outputs_2019_07/results_2019_07_04_435_harbin_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_04_435_harbin_wakayama_1.nc outputs_2019_07/doppler_2019_07_04_435_harbin_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_04_435_harbin_wakayama_1.nc outputs_2019_07/gmat_2019_07_04_435_harbin_wakayama_2.nc

# 2019-07-05 Dwingeloo, Shahe, Harbin, Wakayama
# f_offset -256

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Dwingeloo_2019-07-05.raw 1562311463.634765 PI9CAM \
			  /mnt/disk/dslwp/china/c64/meta_B_435_Shahe_1562311500_1562319300.raw 1562311500.204876 Shahe \
			  435.4e6 -256 outputs_2019_07/results_2019_07_05_435_pi9cam_shahe.npy \
			  outputs_2019_07/doppler_2019_07_05_435_pi9cam_shahe_1.nc outputs_2019_07/doppler_2019_07_05_435_pi9cam_shahe_2.nc \
			  outputs_2019_07/gmat_2019_07_05_435_pi9cam_shahe_1.nc outputs_2019_07/gmat_2019_07_05_435_pi9cam_shahe_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Dwingeloo_2019-07-05.raw 1562311463.634765 PI9CAM \
			  /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1562311740_1562319060.raw 1562311740.203486 Harbin \
			  435.4e6 -256 outputs_2019_07/results_2019_07_05_435_pi9cam_harbin.npy \
			  outputs_2019_07/doppler_2019_07_05_435_pi9cam_harbin_1.nc outputs_2019_07/doppler_2019_07_05_435_pi9cam_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_05_435_pi9cam_harbin_1.nc outputs_2019_07/gmat_2019_07_05_435_pi9cam_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Dwingeloo_2019-07-05.raw 1562311463.634765 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-05.raw 1562310127.267374 Wakayama \
			  435.4e6 -256 outputs_2019_07/results_2019_07_05_435_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_05_435_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_05_435_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_05_435_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_05_435_pi9cam_wakayama_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_435_Shahe_1562311500_1562319300.raw 1562311500.204876 Shahe \
			  /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1562311740_1562319060.raw 1562311740.203486 Harbin \
			  435.4e6 -256 outputs_2019_07/results_2019_07_05_435_shahe_harbin.npy \
			  outputs_2019_07/doppler_2019_07_05_435_shahe_harbin_1.nc outputs_2019_07/doppler_2019_07_05_435_shahe_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_05_435_shahe_harbin_1.nc outputs_2019_07/gmat_2019_07_05_435_shahe_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_435_Shahe_1562311500_1562319300.raw 1562311500.204876 Shahe \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-05.raw 1562310127.267374 Wakayama \
			  435.4e6 -256 outputs_2019_07/results_2019_07_05_435_shahe_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_05_435_shahe_wakayama_1.nc outputs_2019_07/doppler_2019_07_05_435_shahe_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_05_435_shahe_wakayama_1.nc outputs_2019_07/gmat_2019_07_05_435_shahe_wakayama_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_435_Harbin_1562311740_1562319060.raw 1562311740.203486 Harbin \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-05.raw 1562310127.267374 Wakayama \
			  435.4e6 -256 outputs_2019_07/results_2019_07_05_435_harbin_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_05_435_harbin_wakayama_1.nc outputs_2019_07/doppler_2019_07_05_435_harbin_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_05_435_harbin_wakayama_1.nc outputs_2019_07/gmat_2019_07_05_435_harbin_wakayama_2.nc


# 2019-07-09 Dwingeloo (x2), Wakayama
# f_offset -210 (might be wrong, DSLWP-B_PI9CAM_2019-07-09T14:30:00_435.4MHz_40ksps_complex_tagged.raw gives -900)

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-09T14:30:00_435.4MHz_40ksps_complex_tagged.raw 1562678074.565398 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-09T14:40:00_435.4MHz_40ksps_complex_tagged.raw 1562681922.029440 PI9CAM \
			  435.4e6 -210 outputs_2019_07/results_2019_07_09_435_pi9cam_pi9cam2.npy \
			  outputs_2019_07/doppler_2019_07_09_435_pi9cam_pi9cam2_1.nc outputs_2019_07/doppler_2019_07_09_435_pi9cam_pi9cam2_2.nc \
			  outputs_2019_07/gmat_2019_07_09_435_pi9cam_pi9cam2_1.nc outputs_2019_07/gmat_2019_07_09_435_pi9cam_pi9cam2_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-09T14:30:00_435.4MHz_40ksps_complex_tagged.raw 1562678074.565398 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-09.raw 1562675270.203557 Wakayama \
			  435.4e6 -210 outputs_2019_07/results_2019_07_09_435_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_09_435_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_09_435_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_09_435_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_09_435_pi9cam_wakayama_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-09T14:40:00_435.4MHz_40ksps_complex_tagged.raw 1562681922.029440 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-09.raw 1562675270.203557 Wakayama \
			  435.4e6 -210 outputs_2019_07/results_2019_07_09_435_pi9cam2_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_09_435_pi9cam2_wakayama_1.nc outputs_2019_07/doppler_2019_07_09_435_pi9cam2_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_09_435_pi9cam2_wakayama_1.nc outputs_2019_07/gmat_2019_07_09_435_pi9cam2_wakayama_2.nc

# 2019-07-10 Dwingeloo, Wakayama
# f_offset -210

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-10T13:39:31_435.4MHz_40ksps_complex_tagged.raw 1562765980.433423 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-10.raw 1562765985.202346 Wakayama \
			  435.4e6 -210 outputs_2019_07/results_2019_07_10_435_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_10_435_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_10_435_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_10_435_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_10_435_pi9cam_wakayama_2.nc

# 2019-07-23 Dwingeloo, Wakayama
# note: meta_B_435_Wakayama_2019-07-23.raw starts on 2019-07-22 really
# f_offset -210

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-23T23:11:10_435.4MHz_40ksps_complex_tagged.raw 1563923479.515347 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-24.raw 1563922876.205565 Wakayama \
			  435.4e6 -210 outputs_2019_07/results_2019_07_23_435_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_23_435_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_23_435_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_23_435_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_23_435_pi9cam_wakayama_2.nc

# 2019-07-28 Dwingeloo, Wakayama
# f_offset -212

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-28T03:19:42_435.4MHz_40ksps_complex_tagged.raw 1564283991.525825 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-28.raw 1564283364.196892 Wakayama \
			  435.4e6 -212 outputs_2019_07/results_2019_07_28_435_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_28_435_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_28_435_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_28_435_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_28_435_pi9cam_wakayama_2.nc

# 2019-07-31 Dwingeloo, Wakayama
# f_offset -225

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-31T06:29:59_435.4MHz_40ksps_complex_tagged.raw 1564554607.458337 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_435_Wakayama_2019-07-31.raw 1564553487.203739 Wakayama \
			  435.4e6 -225 outputs_2019_07/results_2019_07_31_435_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_31_435_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_31_435_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_31_435_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_31_435_pi9cam_wakayama_2.nc

# 436MHz

# 2019-06-30 Dwingeloo, Harbin
# f_offset -310 (unknown)

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Dwingeloo_2019-06-30.raw 1561873858.194385 PI9CAM \
                          /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1561872540_1561879860.raw 1561872540.097832 Harbin \
			  436.4e6 -310 outputs_2019_07/results_2019_06_30_436_pi9cam_harbin.npy \
			  outputs_2019_07/doppler_2019_06_30_436_pi9cam_harbin_1.nc outputs_2019_07/doppler_2019_06_30_436_pi9cam_harbin_2.nc \
			  outputs_2019_07/gmat_2019_06_30_436_pi9cam_harbin_1.nc outputs_2019_07/gmat_2019_06_30_436_pi9cam_harbin_2.nc

# 2019-07-01 Dwingeloo, Harbin
# f_offset -310

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Dwingeloo_2019-07-01.raw 1561960652.677609 PI9CAM \
                          /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1561959300_1561966260.raw 1561959300.217615 Harbin \
			  436.4e6 -310 outputs_2019_07/results_2019_07_01_436_pi9cam_harbin.npy \
			  outputs_2019_07/doppler_2019_07_01_436_pi9cam_harbin_1.nc outputs_2019_07/doppler_2019_07_01_436_pi9cam_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_01_436_pi9cam_harbin_1.nc outputs_2019_07/gmat_2019_07_01_436_pi9cam_harbin_2.nc

# 2019-07-03 Dwingeloo, Harbin
# f_offset -310

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Dwingeloo_2019-07-03.raw 1562133983.611612 PI9CAM \
                          /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1562133300_1562141100.raw 1562133300.223793 Harbin \
			  436.4e6 -310 outputs_2019_07/results_2019_07_03_436_pi9cam_harbin.npy \
			  outputs_2019_07/doppler_2019_07_03_436_pi9cam_harbin_1.nc outputs_2019_07/doppler_2019_07_03_436_pi9cam_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_03_436_pi9cam_harbin_1.nc outputs_2019_07/gmat_2019_07_03_436_pi9cam_harbin_2.nc

# 2019-07-04 Dwingeloo, Shahe, Wakayama
# f_offset -291

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Dwingeloo_2019-07-04.raw 1562223867.847919 PI9CAM \
                          /mnt/disk/dslwp/china/c64/meta_B_436_Shahe_1562221500_1562229300.raw 1562221500.199090 Shahe \
			  436.4e6 -291 outputs_2019_07/results_2019_07_04_436_pi9cam_shahe.npy \
			  outputs_2019_07/doppler_2019_07_04_436_pi9cam_shahe_1.nc outputs_2019_07/doppler_2019_07_04_436_pi9cam_shahe_2.nc \
			  outputs_2019_07/gmat_2019_07_04_436_pi9cam_shahe_1.nc outputs_2019_07/gmat_2019_07_04_436_pi9cam_shahe_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Dwingeloo_2019-07-04.raw 1562223867.847919 PI9CAM \
                          /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1562221500_1562229300.raw 1562221500.224388 Harbin \
			  436.4e6 -291 outputs_2019_07/results_2019_07_04_436_pi9cam_harbin.npy \
			  outputs_2019_07/doppler_2019_07_04_436_pi9cam_harbin_1.nc outputs_2019_07/doppler_2019_07_04_436_pi9cam_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_04_436_pi9cam_harbin_1.nc outputs_2019_07/gmat_2019_07_04_436_pi9cam_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Dwingeloo_2019-07-04.raw 1562223867.847919 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-04.raw 1562221414.427565 Wakayama \
			  436.4e6 -291 outputs_2019_07/results_2019_07_04_436_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_04_436_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_04_436_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_04_436_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_04_436_pi9cam_wakayama_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_436_Shahe_1562221500_1562229300.raw 1562221500.199090 Shahe \
			  /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1562221500_1562229300.raw 1562221500.224388 Harbin \
			  436.4e6 -291 outputs_2019_07/results_2019_07_04_436_shahe_harbin.npy \
			  outputs_2019_07/doppler_2019_07_04_436_shahe_harbin_1.nc outputs_2019_07/doppler_2019_07_04_436_shahe_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_04_436_shahe_harbin_1.nc outputs_2019_07/gmat_2019_07_04_436_shahe_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_436_Shahe_1562221500_1562229300.raw 1562221500.199090 Shahe \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-04.raw 1562221414.427565 Wakayama \
			  436.4e6 -291 outputs_2019_07/results_2019_07_04_436_shahe_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_04_436_shahe_wakayama_1.nc outputs_2019_07/doppler_2019_07_04_436_shahe_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_04_436_shahe_wakayama_1.nc outputs_2019_07/gmat_2019_07_04_436_shahe_wakayama_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1562221500_1562229300.raw 1562221500.224388 Harbin \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-04.raw 1562221414.427565 Wakayama \
			  436.4e6 -291 outputs_2019_07/results_2019_07_04_436_harbin_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_04_436_harbin_wakayama_1.nc outputs_2019_07/doppler_2019_07_04_436_harbin_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_04_436_harbin_wakayama_1.nc outputs_2019_07/gmat_2019_07_04_436_harbin_wakayama_2.nc

# 2019-07-05 Dwingeloo, Harbin, Shahe, Wakayama
# f_offset -293

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Dwingeloo_2019-07-05.raw 1562311463.634765 PI9CAM \
			  /mnt/disk/dslwp/china/c64/meta_B_436_Shahe_1562311500_1562319300.raw 1562311500.204876 Shahe \
			  436.4e6 -293 outputs_2019_07/results_2019_07_05_436_pi9cam_shahe.npy \
			  outputs_2019_07/doppler_2019_07_05_436_pi9cam_shahe_1.nc outputs_2019_07/doppler_2019_07_05_436_pi9cam_shahe_2.nc \
			  outputs_2019_07/gmat_2019_07_05_436_pi9cam_shahe_1.nc outputs_2019_07/gmat_2019_07_05_436_pi9cam_shahe_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Dwingeloo_2019-07-05.raw 1562311463.634765 PI9CAM \
			  /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1562311740_1562319060.raw 1562311740.203486 Harbin \
			  436.4e6 -293 outputs_2019_07/results_2019_07_05_436_pi9cam_harbin.npy \
			  outputs_2019_07/doppler_2019_07_05_436_pi9cam_harbin_1.nc outputs_2019_07/doppler_2019_07_05_436_pi9cam_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_05_436_pi9cam_harbin_1.nc outputs_2019_07/gmat_2019_07_05_436_pi9cam_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Dwingeloo_2019-07-05.raw 1562311463.634765 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-05.raw 1562310127.267374 Wakayama \
			  436.4e6 -293 outputs_2019_07/results_2019_07_05_436_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_05_436_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_05_436_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_05_436_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_05_436_pi9cam_wakayama_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_436_Shahe_1562311500_1562319300.raw 1562311500.204876 Shahe \
			  /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1562311740_1562319060.raw 1562311740.203486 Harbin \
			  436.4e6 -293 outputs_2019_07/results_2019_07_05_436_shahe_harbin.npy \
			  outputs_2019_07/doppler_2019_07_05_436_shahe_harbin_1.nc outputs_2019_07/doppler_2019_07_05_436_shahe_harbin_2.nc \
			  outputs_2019_07/gmat_2019_07_05_436_shahe_harbin_1.nc outputs_2019_07/gmat_2019_07_05_436_shahe_harbin_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_436_Shahe_1562311500_1562319300.raw 1562311500.204876 Shahe \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-05.raw 1562310127.267374 Wakayama \
			  436.4e6 -293 outputs_2019_07/results_2019_07_05_436_shahe_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_05_436_shahe_wakayama_1.nc outputs_2019_07/doppler_2019_07_05_436_shahe_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_05_436_shahe_wakayama_1.nc outputs_2019_07/gmat_2019_07_05_436_shahe_wakayama_2.nc

./correlate_recordings.py /mnt/disk/dslwp/china/c64/meta_B_436_Harbin_1562311740_1562319060.raw 1562311740.203486 Harbin \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-05.raw 1562310127.267374 Wakayama \
			  436.4e6 -293 outputs_2019_07/results_2019_07_05_436_harbin_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_05_436_harbin_wakayama_1.nc outputs_2019_07/doppler_2019_07_05_436_harbin_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_05_436_harbin_wakayama_1.nc outputs_2019_07/gmat_2019_07_05_436_harbin_wakayama_2.nc

# 2019-07-09 Dwingeloo (x2), Wakayama
# f_offset -259

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-09T14:30:00_436.4MHz_40ksps_complex_tagged.raw 1562678074.565398 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-09T14:40:00_436.4MHz_40ksps_complex_tagged.raw 1562681922.029440 PI9CAM \
			  436.4e6 -259 outputs_2019_07/results_2019_07_09_436_pi9cam_pi9cam2.npy \
			  outputs_2019_07/doppler_2019_07_09_436_pi9cam_pi9cam2_1.nc outputs_2019_07/doppler_2019_07_09_436_pi9cam_pi9cam2_2.nc \
			  outputs_2019_07/gmat_2019_07_09_436_pi9cam_pi9cam2_1.nc outputs_2019_07/gmat_2019_07_09_436_pi9cam_pi9cam2_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-09T14:30:00_436.4MHz_40ksps_complex_tagged.raw 1562678074.565398 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-09.raw 1562675270.203557 Wakayama \
			  436.4e6 -259 outputs_2019_07/results_2019_07_09_436_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_09_436_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_09_436_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_09_436_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_09_436_pi9cam_wakayama_2.nc

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-09T14:40:00_436.4MHz_40ksps_complex_tagged.raw 1562681922.029440 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-09.raw 1562675270.203557 Wakayama \
			  436.4e6 -259 outputs_2019_07/results_2019_07_09_436_pi9cam2_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_09_436_pi9cam2_wakayama_1.nc outputs_2019_07/doppler_2019_07_09_436_pi9cam2_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_09_436_pi9cam2_wakayama_1.nc outputs_2019_07/gmat_2019_07_09_436_pi9cam2_wakayama_2.nc

# 2019-07-10 Dwingeloo, Wakayama
# f_offset -266

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-10T13:39:31_436.4MHz_40ksps_complex_tagged.raw 1562765980.433423 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-10.raw 1562765985.202346 Wakayama \
			  436.4e6 -266 outputs_2019_07/results_2019_07_10_436_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_10_436_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_10_436_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_10_436_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_10_436_pi9cam_wakayama_2.nc

# 2019-07-23 Dwingeloo, Wakayama
# note: meta_B_435_Wakayama_2019-07-23.raw starts on 2019-07-22 really
# f_offset -259

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-23T23:11:10_436.4MHz_40ksps_complex_tagged.raw 1563923479.515347 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-24.raw 1563922876.205565 Wakayama \
			  436.4e6 -259 outputs_2019_07/results_2019_07_23_436_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_23_436_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_23_436_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_23_436_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_23_436_pi9cam_wakayama_2.nc

# 2019-07-28 Dwingeloo, Wakayama
# f_offset -261

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-28T03:19:42_436.4MHz_40ksps_complex_tagged.raw 1564283991.525825 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-28.raw 1564283364.196892 Wakayama \
			  436.4e6 -261 outputs_2019_07/results_2019_07_28_436_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_28_436_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_28_436_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_28_436_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_28_436_pi9cam_wakayama_2.nc

# 2019-07-31 Dwingeloo, Wakayama
# f_offset -269

./correlate_recordings.py /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/DSLWP-B_PI9CAM_2019-07-31T06:29:59_436.4MHz_40ksps_complex_tagged.raw 1564554607.458337 PI9CAM \
			  /mnt/disk/dslwp/charon.camras.nl/public/dslwp-b/c64/meta_B_436_Wakayama_2019-07-31.raw 1564553487.203739 Wakayama \
			  436.4e6 -269 outputs_2019_07/results_2019_07_31_436_pi9cam_wakayama.npy \
			  outputs_2019_07/doppler_2019_07_31_436_pi9cam_wakayama_1.nc outputs_2019_07/doppler_2019_07_31_436_pi9cam_wakayama_2.nc \
			  outputs_2019_07/gmat_2019_07_31_436_pi9cam_wakayama_1.nc outputs_2019_07/gmat_2019_07_31_436_pi9cam_wakayama_2.nc
