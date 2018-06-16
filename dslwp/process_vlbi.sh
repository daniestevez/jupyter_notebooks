#!/bin/bash

PATH=/home/daniel/jupyter_notebooks/dslwp:$PATH

DOPPLER_FILE=/home/daniel/jupyter_notebooks/dslwp/VLBI_Doppler.txt

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 Package_a Package_b output_dir"
    exit 1
fi

dir=`pwd`

echo "Extracting packages..."
mkdir -p /tmp/{a,b,current}
cd /tmp/a
tar zxf $1
cd /tmp/b
tar zxf $2
cd /tmp/current
echo "Packages extracted"
for utc in `ls /tmp/a/* | sed -e "s/.*_\([0-9]\+\)\.tar\.bz2.*/\1/"`; do
if ls `echo /tmp/b/*$utc.tar.bz2` >/dev/null 2>&1; then
    tar jxf `echo /tmp/a/*$utc.tar.bz2`
    mv *_435.raw_package a435.raw_package
    mv *_436.raw_package a436.raw_package
    tar jxf `echo /tmp/b/*$utc.tar.bz2`
    mv *_435.raw_package b435.raw_package
    mv *_436.raw_package b436.raw_package
    time_a435=`gr_read_file_metadata a435.raw_package | grep Seconds | head -n 1 | awk '{print $2}'`
    time_a436=`gr_read_file_metadata a436.raw_package | grep Seconds | head -n 1 | awk '{print $2}'`
    time_b435=`gr_read_file_metadata b435.raw_package | grep Seconds | head -n 1 | awk '{print $2}'`
    time_b436=`gr_read_file_metadata b436.raw_package | grep Seconds | head -n 1 | awk '{print $2}'`
    convert_metadata_file.py --infile=a435.raw_package --outfile=a435.raw
    rm -f a435.raw_package
    convert_metadata_file.py --infile=a436.raw_package --outfile=a436.raw
    rm -f a436.raw_package
    convert_metadata_file.py --infile=b435.raw_package --outfile=b435.raw
    rm -f b435.raw_package
    convert_metadata_file.py --infile=b436.raw_package --outfile=b436.raw
    rm -f b436.raw_package
    cd $dir
    echo "UTC $utc"
    echo "435MHz"
    vlbi.py 435.4e6 /tmp/current/a435.raw /tmp/current/b435.raw $time_a435 $time_b435 $DOPPLER_FILE $3
    echo "436MHz"
    vlbi.py 436.4e6 /tmp/current/a436.raw /tmp/current/b436.raw $time_a436 $time_b436 $DOPPLER_FILE $3
    cd /tmp/current
    rm -f a435.raw a436.raw b435.raw b436.raw
fi
done
rm -rf /tmp/{a,b,current}
