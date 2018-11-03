#!/usr/bin/env python3

import numpy as np

def ma2ta(ma_deg, eccentricity, kepler_iterations = 100):
    M = np.deg2rad(ma_deg)
    e = eccentricity
    # Solve Kepler equation for eccentric anomaly by iteration
    E = M
    for _ in range(kepler_iterations):
        E = M + e * np.sin(E)
    nu = 2*np.angle(np.sqrt(1-e)*np.cos(E/2) + 1j*np.sqrt(1+e)*np.sin(E/2))
    return np.rad2deg(nu)
