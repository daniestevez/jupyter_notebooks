#!/bin/bash

PROCESS=./process_recording.py
OUTPUT=output

for file in $1/*_40ksps_complex.raw; do
    echo $file
    $PROCESS $file $2 $OUTPUT
done
