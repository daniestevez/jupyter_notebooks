#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import scipy.signal

E42_E1C_PRN_string = '9C6674915677A62A7AFD4FCB27B45F8E6DDDD08980B7DBE1131E6E2425C5ADBEE8474E93A8A2D4E495B195A6B83F2CF6472A36E690928362B9A1FA994A9FEB7BCBA7FDCB771F59FB434ED289CCEABDAFAE29113389EB98D6F17E5508D5976E11BC8A1E93AF9F7B1C81686265930B4D334568E3F29E1C2F58A62572A610016C1C1C1C9E1D0EB3FEB2B3A210C59EB3980C44BC656FA7C5E05A4472D4255B40B8A1604FE39D8B5026A976310648D5C84CEBC87A8BF6545DC843A3A0B64DC4CCAF2D2203122DDD75BA42E096844899A35A899FDFD72C26E3392EA03351DC78BB9F62F51D913F8008DB00969C64003773FB2014FAF97E794A45792495BD52D7BE7ACA47FF2BF570CF88303377092B5B6BFF3B01D38A53E8A68B0D81FC2D1D375EB27C7AEEDD70679E8DDBA6DE656442ED951478FB96A979B4A9091F344EF39AF23DAA886C6FBAA8611C61686332C630690109E2869D18EE7A2C21B22921B9E3DE40BF063E370FF64E7AFE160B7EBFC4AF6AEDA043042552F5F36C2CABD339FE1442242EAD931D1B83968D1A31A7E32A0838401DBB9C1034D56ADCAF5942462EF63440FD70F91520137A50372D0D125A6285F7D715FD9225D03A109E1FC5EB547303CD7708F88FEED2814607171930436B249924714E8D8E024C24B3C0C9E40127DECE1AD966C3F9DF01793864615F291B73F73D27B624ACBEAD3D371B8D4FDA823C0'
prn = 1 - 2*np.unpackbits(np.frombuffer(bytes.fromhex(E42_E1C_PRN_string + '0'), dtype = 'uint8'))[:4092].astype('int')
secondary_code = 1 - 2*np.array([0,0,1,1,1,0,0,0,0,0,0,0,1,0,1,0,1,1,0,1,1,0,0,1,0])

fs = 1.5e6 # sample rate
fc = 0.25 * 1.023e6 # chip rate
boc_order = 1
t_ambiguity = prn.size * secondary_code.size / fc

repeat_samples = int(t_ambiguity * fs)

boc = np.tile([1,-1], boc_order)
prn_subchips = np.repeat(prn, boc.size) * np.tile(boc, prn.size)

calibration_RX_delay_samples = 93

def load_file(filename):
    N = 708
    x = np.memmap(filename, dtype = 'int16')
    x = x[:x.size//N*N].reshape((-1,N))
    block_no = x[:,10].ravel()
    x = x[:,12:].ravel()
    if np.any(np.diff((block_no).view('uint16')) != 1):
        raise Exception('lost packets')
    return x

def acquire(x):
    N = prn.size / fc * fs
    subchip_idx = np.int32(np.arange(N) * boc.size * fc / fs) % prn_subchips.size
    r = prn_subchips[subchip_idx]
    
    doppler_bins = np.arange(-10,11)
    best = -np.inf
    x = x[:4*r.size:2] + 1j * x[1:4*r.size:2]
    fx = np.fft.fft(x)
    fr = np.fft.fft(r, n = 2*r.size)
    for doppler in doppler_bins:
        corr = np.fft.ifft(np.roll(fx, doppler) * np.conj(fr))
        M = np.max(np.abs(corr))
        if M > best:
            best_doppler = doppler
            best_corr = corr
            best = M
    return {'doppler' : best_doppler, 'corr' : best_corr}

def track(x, code_delay, secondary_code_phase = None, el_spacing = 0.01,
          block_samples = int(1e-3 * fs), max_correlations = None, freq = 0):
    dll_slope = 3
    
    code_freq_delta = 0
    acc = acc_e = acc_l = 0 + 1j*0
    phase = 0

    correlations = list()

    block_starts = np.arange(0, x.size//2, block_samples)[:-1]
    
    code_delays = np.empty_like(block_starts, dtype = 'float')
    phases = np.empty_like(code_delays)
    freqs = np.empty_like(code_delays)
    sec_code_phases = np.empty_like(code_delays)
    code_delays[:] = np.nan
    phases[:] = np.nan
    freqs[:] = np.nan
    sec_code_phases[:] = np.nan

    for j,sample in enumerate(block_starts):
        # tracking state
        code_delays[j] = code_delay
        freqs[j] = freq
        phases[j] = phase
        if secondary_code_phase is not None:
            sec_code_phases[j] = secondary_code_phase
    
        # update code NCO
        chip = np.arange(block_samples + 1) * (fc + code_freq_delta) / fs + code_delay
        code_delay = chip[-1] % prn.size
    
        # compute replicas
        r = prn_subchips[np.int32(boc.size * chip[:-1]) % prn_subchips.size] # prompt replica
        r_e = prn_subchips[np.int32(boc.size * (chip[:-1] + el_spacing/2)) % prn_subchips.size] # early replica
        r_l = prn_subchips[np.int32(boc.size * (chip[:-1] - el_spacing/2)) % prn_subchips.size] # late replica
    
        # update carrier NCO
        phi = np.arange(block_samples + 1) * freq / fs + phase
        phase = phi[-1]
    
        # carrier MIX
        y = x[2*sample:][:2*block_samples].astype('float32').view('complex64')
        y = y * np.exp(-1j * phi[:-1])
    
        # compute correlations
        prod = y * r
        prod_e = y * r_e
        prod_l = y * r_l
        secondary_symbol = 1 if secondary_code_phase is None else secondary_code[secondary_code_phase]
        acc += secondary_symbol * np.sum(prod[chip[:-1] < prn.size])
        acc_e += secondary_symbol * np.sum(prod_e[chip[:-1] < prn.size])
        acc_l += secondary_symbol * np.sum(prod_l[chip[:-1] < prn.size])
    
        # process dump
        if chip[-1] >= prn.size:
            correlations.append(acc)
            if max_correlations is not None and len(correlations) >= max_correlations:
                break
        
            # PLL
            err_pll = np.angle(acc**2)/2 if secondary_code_phase is None else np.angle(acc)
            freq += 5 * err_pll
            phase += 1 * err_pll
        
            # DLL
            err_dll = (acc_e.real - acc_l.real)/(acc.real * dll_slope * 2)
            code_freq_delta += 1 * err_dll
            code_delay += 1 * err_dll
        
            # start next correlation
            if secondary_code_phase is not None:
                secondary_code_phase = (secondary_code_phase + 1) % secondary_code.size
            secondary_symbol = 1 if secondary_code_phase is None else secondary_code[secondary_code_phase]
            acc = secondary_symbol * np.sum(prod[chip[:-1] >= prn.size])
            acc_e = secondary_symbol * np.sum(prod_e[chip[:-1] >= prn.size])
            acc_l = secondary_symbol * np.sum(prod_l[chip[:-1] >= prn.size])
    
    return {'correlations' : np.array(correlations),
            'code_delay' : code_delays,
            'freq' : freqs,
            'phase' : phases,
            'symbol' : sec_code_phases}
