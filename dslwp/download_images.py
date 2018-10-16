#!/usr/bin/env python3

import sys
import json
import urllib.request

JSON_URL = 'http://lilacsat.hit.edu.cn:9000/get_data?sat=DSLWP-B&type=image'
IMAGE_URL = 'http://lilacsat.hit.edu.cn/DSLWP-B/{}'

def usage():
    print(f'Usage {sys.argv[0]} output_dir')
    sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        usage()

    output_dir = sys.argv[1]
    
    res = urllib.request.urlopen(JSON_URL)
    image_list = json.loads(res.read()[13:-1])['data']
    for image in image_list:
        image_data = urllib.request.urlopen(IMAGE_URL.format(image)).read()
        with open('{}/{}'.format(output_dir, image), 'wb') as f:
            f.write(image_data)

