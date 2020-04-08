#!/usr/bin/env python3

from collections import deque
import numpy as np

word_size = 8
frame_size = 32 * word_size
sync_start = np.array([0, 1, 0, 0, 1, 0, 0, 1], dtype = 'uint8')
sync_end = np.array([0, 0, 0, 1, 1, 1, 0, 0], dtype = 'uint8')

def check_sync(two_frames):
    if len(two_frames) != 2 * frame_size:
        # two_frames is too short
        return False
    two_frames = np.array(two_frames, dtype = 'uint8')
    return np.all(two_frames[:word_size] == sync_start) \
            and np.all(two_frames[frame_size-word_size:frame_size] == sync_end) \
            and np.all(two_frames[frame_size:frame_size+word_size] == 1 ^ sync_start) \
            and np.all(two_frames[-word_size:] == 1 ^ sync_end)

def check_frame(frame):
    check = np.concatenate((frame[:word_size] ^ sync_start, frame[-word_size:] ^ sync_end))
    return np.all(check == 0) or np.all(check == 1)

def generate_frames(bitgen):
    # initialization of state
    sync = False
    sync_size = frame_size * 2
    sync_deque = deque(maxlen = sync_size)
    
    while True:
        if not sync:
            try:
                sync_deque.append(next(bitgen))
            except StopIteration:
                return
            if check_sync(sync_deque):
                # we are synchronized
                # store second frame in sync_deque for next call and return first
                sync = True
                sd_arr = np.array(sync_deque, dtype = 'uint8')
                frame = sd_arr[-frame_size:]
                yield sd_arr[:frame_size]
        else:
            to_yield = frame
            try:
                frame = np.array([next(bitgen) for _ in range(frame_size)], dtype = 'uint8')
            except StopIteration:
                return
            if not check_frame(frame):
                sync = False
                sync_deque = deque(frame, maxlen = sync_size)
            yield frame

def generate_bits_from_symbolsf32(symbols_f32):
    symbols_diff = -symbols_f32[:-1] * symbols_f32[1:]
    return iter((symbols_diff > 0).astype('uint8'))

def frame_number(frames):
    return np.packbits(frames[...,2*8+4:2*8+6], axis = -1)[...,0] >> 6
