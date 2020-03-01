#!/bin/bash

wget -i sp3_urls
for file in *.SP3.gz; do
	gzip -d "$file"
done
for file in *.SP3; do
	mv -- "$file" "${file%.SP3}.sp3"
done
