#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Copyright 2018-2019 Daniel Estevez <daniel@destevez.net>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

import numpy as np

epoch_dt64 = np.datetime64('2015-12-31T16:00')

def parse_timestamp_datetime64(t):
    return epoch_dt64 + np.timedelta64(1, 'us') * t * 100
