import numpy as np
import matplotlib.pyplot as plt

import functools

# Psedurandom sequence following Section 7.2 in 3GPP TS 36.211
def c_seq(c_init, M_PN):
    x1 = 1
    x2 = c_init
    NC = 1600
    c = np.zeros(M_PN, 'uint8')
    # Drop the first NC terms
    for j in range(NC + M_PN):
        if j >= NC:
            c[j - NC] = (x1 ^ x2) & 1
        x1 = (((x1 ^ (x1 >> 3)) & 1) << 30) | (x1 >> 1)
        x2 = (((x2 ^ (x2 >> 1) ^ (x2 >> 2) ^ (x2 >> 3)) & 1) << 30) | (x2 >> 1)
    return c


# Turbo coding

def block_interleaver_turbo(x, last_branch=False):
    NC = 32
    NR = (len(x) + NC - 1) // NC
    x = [None] * (NC * NR - len(x)) + x
    # If x has no None's (which happens when 32 divides len(x)), then
    # the transformation to np.array will break tuples as another dimension
    # of the array. We add and remove a None entry just to prevent this.
    x = np.array(x + [None], dtype='object')[:-1].reshape(NR, NC)
    column_permutation = np.array([
        0, 16, 8, 24, 4, 20, 12, 28, 2, 18, 10, 26, 6, 22, 14, 30,
        1, 17, 9, 25, 5, 21, 13, 29, 3, 19, 11, 27, 7, 23, 15, 31
    ])
    if last_branch:
        pi_k = np.array([(column_permutation[k // NR] + NC * (k % NR) + 1) % x.size
                         for k in range(x.size)])
        return x.ravel()[pi_k]
    return x[:, column_permutation].T.ravel()

# Calculations for input->output mapping of the rate matching block for Turbo coding
# D - number of input bits
# E - number of output bits
# rv_idx - redundancy version index
def rate_matching_turbo(D, E, rv_idx):
    rate_matching_input_idx = [[(j, k) for k in range(D)] for j in range(3)]
    interleaved = [block_interleaver_turbo(x, last_branch=j==2)
                   for j, x in enumerate(rate_matching_input_idx)]
    # the following is just used to create an array of the correct size that starts
    # by interleaved[0]
    buffer = np.concatenate(interleaved)
    # interleaved[1] and interleaved[2] must be interleaved into the last 2/3rds of
    # buffer
    buffer[len(interleaved[0]):][::2] = interleaved[1]
    buffer[len(interleaved[0]):][1::2] = interleaved[2]
    rate_matching_output_idx = []
    NR = (D + 31) // 32
    k = NR * (2 * ((len(buffer) + 8 * NR - 1) // (8 * NR)) * rv_idx + 2)
    for j in range(E):
        while True:
            element = buffer[k % len(buffer)]
            k += 1
            if element is not None:
                rate_matching_output_idx.append(element)
                break
    return rate_matching_output_idx

# Collect soft symbols according to rate matching (for soft combining)
def rate_matching_collect_turbo(symbols_and_rv_idxs, D):
    rate_matching_input_idx = [[(j, k) for k in range(D)] for j in range(3)]
    collect = {b: [] for a in rate_matching_input_idx for b in a}
    for symbols, rv_idx in symbols_and_rv_idxs:
        rate_matching_output_idx = rate_matching_turbo(D, symbols.size, rv_idx)
        for j, bit in enumerate(symbols):
            collect[rate_matching_output_idx[j]].append(bit)
    return collect

def symbols_to_LLRs(symbols, noise_sigma):
    return -2 * symbols / noise_sigma**2

def turbo_len(transport_size):
    crc_len = 24
    turbo_tail = 4
    return transport_size + crc_len + turbo_tail

# Table 5.1.3-3 in TS 36.212
def f1f2_table(K):
    return {
 40: (3, 10),
 48: (7, 12),
 56: (19, 42),
 64: (7, 16),
 72: (7, 18),
 80: (11, 20),
 88: (5, 22),
 96: (11, 24),
 104: (7, 26),
 112: (41, 84),
 120: (103, 90),
 128: (15, 32),
 136: (9, 34),
 144: (17, 108),
 152: (9, 38),
 160: (21, 120),
 168: (101, 84),
 176: (21, 44),
 184: (57, 46),
 192: (23, 48),
 200: (13, 50),
 208: (27, 52),
 216: (11, 36),
 224: (27, 56),
 232: (85, 58),
 240: (29, 60),
 248: (33, 62),
 256: (15, 32),
 264: (17, 198),
 272: (33, 68),
 280: (103, 210),
 288: (19, 36),
 296: (19, 74),
 304: (37, 76),
 312: (19, 78),
 320: (21, 120),
 328: (21, 82),
 336: (115, 84),
 344: (193, 86),
 352: (21, 44),
 360: (133, 90),
 368: (81, 46),
 376: (45, 94),
 384: (23, 48),
 392: (243, 98),
 400: (151, 40),
 408: (155, 102),
 416: (25, 52),
 424: (51, 106),
 432: (47, 72),
 440: (91, 110),
 448: (29, 168),
 456: (29, 114),
 464: (247, 58),
 472: (29, 118),
 480: (89, 180),
 488: (91, 122),
 496: (157, 62),
 504: (55, 84),
 512: (31, 64),
 528: (17, 66),
 544: (35, 68),
 560: (227, 420),
 576: (65, 96),
 592: (19, 74),
 608: (37, 76),
 624: (41, 234),
 640: (39, 80),
 656: (185, 82),
 672: (43, 252),
 688: (21, 86),
 704: (155, 44),
 720: (79, 120),
 736: (139, 92),
 752: (23, 94),
 768: (217, 48),
 784: (25, 98),
 800: (17, 80),
 816: (127, 102),
 832: (25, 52),
 848: (239, 106),
 864: (17, 48),
 880: (137, 110),
 896: (215, 112),
 912: (29, 114),
 928: (15, 58),
 944: (147, 118),
 960: (29, 60),
 976: (59, 122),
 992: (65, 124),
 1008: (55, 84),
 1024: (31, 64),
 1056: (17, 66),
 1088: (171, 204),
 1120: (67, 140),
 1152: (35, 72),
 1184: (19, 74),
 1216: (39, 76),
 1248: (19, 78),
 1280: (199, 240),
 1312: (21, 82),
 1344: (211, 252),
 1376: (21, 86),
 1408: (43, 88),
 1440: (149, 60),
 1472: (45, 92),
 1504: (49, 846),
 1536: (71, 48),
 1568: (13, 28),
 1600: (17, 80),
 1632: (25, 102),
 1664: (183, 104),
 1696: (55, 954),
 1728: (127, 96),
 1760: (27, 110),
 1792: (29, 112),
 1824: (29, 114),
 1856: (57, 116),
 1888: (45, 354),
 1920: (31, 120),
 1952: (59, 610),
 1984: (185, 124),
 2016: (113, 420),
 2048: (31, 64),
 2112: (17, 66),
 2176: (171, 136),
 2240: (209, 420),
 2304: (253, 216),
 2368: (367, 444),
 2432: (265, 456),
 2496: (181, 468),
 2560: (39, 80),
 2624: (27, 164),
 2688: (127, 504),
 2752: (143, 172),
 2816: (43, 88),
 2880: (29, 300),
 2944: (45, 92),
 3008: (157, 188),
 3072: (47, 96),
 3136: (13, 28),
 3200: (111, 240),
 3264: (443, 204),
 3328: (51, 104),
 3392: (51, 212),
 3456: (451, 192),
 3520: (257, 220),
 3584: (57, 336),
 3648: (313, 228),
 3712: (271, 232),
 3776: (179, 236),
 3840: (331, 120),
 3904: (363, 244),
 3968: (375, 248),
 4032: (127, 168),
 4096: (31, 64),
 4160: (33, 130),
 4224: (43, 264),
 4288: (33, 134),
 4352: (477, 408),
 4416: (35, 138),
 4480: (233, 280),
 4544: (357, 142),
 4608: (337, 480),
 4672: (37, 146),
 4736: (71, 444),
 4800: (71, 120),
 4864: (37, 152),
 4928: (39, 462),
 4992: (127, 234),
 5056: (39, 158),
 5120: (39, 80),
 5184: (31, 96),
 5248: (113, 902),
 5312: (41, 166),
 5376: (251, 336),
 5440: (43, 170),
 5504: (21, 86),
 5568: (43, 174),
 5632: (45, 176),
 5696: (45, 178),
 5760: (161, 120),
 5824: (89, 182),
 5888: (323, 184),
 5952: (47, 186),
 6016: (23, 94),
 6080: (47, 190),
 6144: (263, 480)}[K]

def turbo_permutation(K):
    f1, f2 = f1f2_table(K)
    i = np.arange(K)
    return (f1 * i + f2 * i**2) % K

def turbo_permutation_inv(K):
    fwd = list(turbo_permutation(K))
    return np.array([fwd.index(i) for i in range(K)])

def maxstar(a, b):
    result = np.empty_like(a)
    ainf = a == -np.inf
    binf = b == -np.inf
    result[ainf] = b[ainf]
    result[binf] = a[binf]
    noninf = (a != -np.inf) & (b != -np.inf)
    an = a[noninf]
    bn = b[noninf]
    result[noninf] = np.maximum(an, bn) + np.log1p(np.exp(-np.abs(an-bn)))
    return result

def BCJR(Ru, R, Ap):
    T = Ru.size # time steps
    nu = 3 # number of states = 2^nu
    Gamma = np.empty((T, 2**nu, 2**nu))
    Gamma[...] = -np.inf
    A = np.empty((T, 2**nu))
    A[...] = -np.inf
    A[0, 0] = 0
    B = np.empty((T, 2**nu))
    B[...] = -np.inf
    B[-1, 0] = 0
    
    # States are encoded as the concatenation of the
    # bits in the shift register, with the oldest bit
    # in the LSB, so that the shift register is shifted
    # left in each epoch.
    for r in range(2**nu):
        for s in range(2**nu):
            # non-termination trellis
            if r >> 1 == s & (2**(nu-1)-1):
                # S_r to S_s is a trellis edge
                Gamma[:-nu, r, s] = 0
                feedback = (r ^ (r >> 1)) & 1
                # The information bit corresponding to the
                # transition from S_r to S_s
                newbit = (s >> (nu - 1)) ^ feedback
                if newbit == 0:
                    Gamma[:-nu, r, s] += Ap - np.log1p(np.exp(Ap))
                else:
                    Gamma[:-nu, r, s] += -Ap - np.log1p(np.exp(-Ap))
                c0 = newbit
                c1 = (r ^ (r >> 2) ^ (s >> (nu - 1))) & 1                
                if c0 == 0:
                    Gamma[:-nu, r, s] += Ru[:-nu] - np.log1p(np.exp(Ru[:-nu]))
                else:
                    Gamma[:-nu, r, s] += -Ru[:-nu] - np.log1p(np.exp(-Ru[:-nu]))
                if c1 == 0:
                    Gamma[:-nu, r, s] += R[:-nu] - np.log1p(np.exp(R[:-nu]))
                else:
                    Gamma[:-nu, r, s] += -R[:-nu] - np.log1p(np.exp(-R[:-nu]))
            # termination trellis
            if r >> 1 == s:
                # S_r to S_s is a trellis edge
                Gamma[-nu:, r, s] = 0
                feedback = (r ^ (r >> 1)) & 1
                c0 = feedback
                c1 = (r ^ (r >> 2)) & 1
                if c0 == 0:
                    Gamma[-nu:, r, s] += Ru[-nu:] - np.log1p(np.exp(Ru[-nu:]))
                else:
                    Gamma[-nu:, r, s] += -Ru[-nu:] - np.log1p(np.exp(-Ru[-nu:]))
                if c1 == 0:
                    Gamma[-nu:, r, s] += R[-nu:] - np.log1p(np.exp(R[-nu:]))
                else:
                    Gamma[-nu:, r, s] += -R[-nu:] - np.log1p(np.exp(-R[-nu:]))

    # Note: For A, t is numbered from 0 to T-1,
    # while for Gamma and B, it is numbered from 1 to T
    for t in range(1, T):
        for r in range(2**nu):
            A[t, :] = maxstar(A[t, :], A[t-1, r] + Gamma[t-1, r, :])

    for t in range(T-2, -1, -1):
        for s in range(2**nu):
            B[t, :] = maxstar(B[t, :], B[t+1, s] + Gamma[t+1, :, s])
    
    M = A[:, :, np.newaxis] + Gamma + B[:, np.newaxis, :]

    Lp = np.empty_like(Ap)
    Lm = np.empty_like(Ap)
    Lp[:] = -np.inf
    Lm[:] = -np.inf
    for r in range(2**nu):
        for s in range(2**nu):
            # always non-termination trellis
            if r >> 1 == s & (2**(nu-1)-1):
                feedback = (r ^ (r >> 1)) & 1
                newbit = (s >> (nu - 1)) ^ feedback
                if newbit == 1:
                    Lp = maxstar(Lp, M[:-nu, r, s])
                else:
                    Lm = maxstar(Lm, M[:-nu, r, s])
    return Lm - Lp

def turbo_decoder(Ru1, R1, Ru2, R2, num_iterations=10, maxA=512, maxR=512, do_plots=False):
    for R in [Ru1, R1, Ru2, R2]:
        R[:] = np.clip(R, -maxR, maxR)
    K = Ru1.size - 3
    E2 = np.zeros(K)
    for iteration in range(num_iterations):
        A1 = E2[turbo_permutation_inv(K)]
        A1 = np.clip(A1, -maxA, maxA)
        L1 = BCJR(Ru1, R1, A1)
        E1 = L1 - Ru1[:-3] - A1        
        A2 = E1[turbo_permutation(K)]
        A2 = np.clip(A2, -maxA, maxA)
        L2 = BCJR(Ru2, R2, A2)
        E2 = L2 - Ru2[:-3] - A2
        if do_plots:
            fig, axs = plt.subplots(2, 1, sharex=True, sharey=True)
            axs[0].plot(L1, '.')
            axs[1].plot(L2, '.', color='C1')
            axs[0].set_ylabel('L1')
            axs[1].set_ylabel('L2')
            fig.suptitle(f'LTE Turbo decoder iteration {iteration}', y=0.93)
            axs[1].set_xlabel('Message bit')
            plt.subplots_adjust(hspace=0)
    return L2[turbo_permutation_inv(K)]

def LTE_turbo_decoder(collected_LLRs, transport_size, plot_channel_LLRs=False, **kwargs):
    LLRs = np.array([[np.sum(collected_LLRs.get((j, k), [0]))
                      for k in range(turbo_len(transport_size))]
                     for j in range(3)])                      
    if plot_channel_LLRs:
        plt.figure()
        plt.plot(LLRs.ravel(), '.')
        plt.title('LTE Turbo decoder channel LLRs')
    # Section 5.1.3.2.2 in TS 36.212 for trellis termination "shuffling"
    K = turbo_len(transport_size) - 4
    # x
    Ru1 = np.concatenate([LLRs[0, :K], [LLRs[0, K], LLRs[2, K], LLRs[1, K+1]]])
    # z
    R1 = np.concatenate([LLRs[1, :K], [LLRs[1, K], LLRs[0, K+1], LLRs[2, K+1]]])
    # x'
    Ru2 = np.concatenate([LLRs[0, :K][turbo_permutation(K)], [LLRs[0, K+2], LLRs[2, K+2], LLRs[1, K+3]]])
    # z'
    R2 = np.concatenate([LLRs[2, :K], [LLRs[1, K+2], LLRs[0, K+3], LLRs[2, K+3]]])
    return turbo_decoder(Ru1, R1, Ru2, R2, **kwargs)

crc24a_table = [
  0x00000000,0x00864cfb,0x008ad50d,0x000c99f6,0x0093e6e1,0x0015aa1a,0x001933ec,0x009f7f17,
  0x00a18139,0x0027cdc2,0x002b5434,0x00ad18cf,0x003267d8,0x00b42b23,0x00b8b2d5,0x003efe2e,
  0x00c54e89,0x00430272,0x004f9b84,0x00c9d77f,0x0056a868,0x00d0e493,0x00dc7d65,0x005a319e,
  0x0064cfb0,0x00e2834b,0x00ee1abd,0x00685646,0x00f72951,0x007165aa,0x007dfc5c,0x00fbb0a7,
  0x000cd1e9,0x008a9d12,0x008604e4,0x0000481f,0x009f3708,0x00197bf3,0x0015e205,0x0093aefe,
  0x00ad50d0,0x002b1c2b,0x002785dd,0x00a1c926,0x003eb631,0x00b8faca,0x00b4633c,0x00322fc7,
  0x00c99f60,0x004fd39b,0x00434a6d,0x00c50696,0x005a7981,0x00dc357a,0x00d0ac8c,0x0056e077,
  0x00681e59,0x00ee52a2,0x00e2cb54,0x006487af,0x00fbf8b8,0x007db443,0x00712db5,0x00f7614e,
  0x0019a3d2,0x009fef29,0x009376df,0x00153a24,0x008a4533,0x000c09c8,0x0000903e,0x0086dcc5,
  0x00b822eb,0x003e6e10,0x0032f7e6,0x00b4bb1d,0x002bc40a,0x00ad88f1,0x00a11107,0x00275dfc,
  0x00dced5b,0x005aa1a0,0x00563856,0x00d074ad,0x004f0bba,0x00c94741,0x00c5deb7,0x0043924c,
  0x007d6c62,0x00fb2099,0x00f7b96f,0x0071f594,0x00ee8a83,0x0068c678,0x00645f8e,0x00e21375,
  0x0015723b,0x00933ec0,0x009fa736,0x0019ebcd,0x008694da,0x0000d821,0x000c41d7,0x008a0d2c,
  0x00b4f302,0x0032bff9,0x003e260f,0x00b86af4,0x002715e3,0x00a15918,0x00adc0ee,0x002b8c15,
  0x00d03cb2,0x00567049,0x005ae9bf,0x00dca544,0x0043da53,0x00c596a8,0x00c90f5e,0x004f43a5,
  0x0071bd8b,0x00f7f170,0x00fb6886,0x007d247d,0x00e25b6a,0x00641791,0x00688e67,0x00eec29c,
  0x003347a4,0x00b50b5f,0x00b992a9,0x003fde52,0x00a0a145,0x0026edbe,0x002a7448,0x00ac38b3,
  0x0092c69d,0x00148a66,0x00181390,0x009e5f6b,0x0001207c,0x00876c87,0x008bf571,0x000db98a,
  0x00f6092d,0x007045d6,0x007cdc20,0x00fa90db,0x0065efcc,0x00e3a337,0x00ef3ac1,0x0069763a,
  0x00578814,0x00d1c4ef,0x00dd5d19,0x005b11e2,0x00c46ef5,0x0042220e,0x004ebbf8,0x00c8f703,
  0x003f964d,0x00b9dab6,0x00b54340,0x00330fbb,0x00ac70ac,0x002a3c57,0x0026a5a1,0x00a0e95a,
  0x009e1774,0x00185b8f,0x0014c279,0x00928e82,0x000df195,0x008bbd6e,0x00872498,0x00016863,
  0x00fad8c4,0x007c943f,0x00700dc9,0x00f64132,0x00693e25,0x00ef72de,0x00e3eb28,0x0065a7d3,
  0x005b59fd,0x00dd1506,0x00d18cf0,0x0057c00b,0x00c8bf1c,0x004ef3e7,0x00426a11,0x00c426ea,
  0x002ae476,0x00aca88d,0x00a0317b,0x00267d80,0x00b90297,0x003f4e6c,0x0033d79a,0x00b59b61,
  0x008b654f,0x000d29b4,0x0001b042,0x0087fcb9,0x001883ae,0x009ecf55,0x009256a3,0x00141a58,
  0x00efaaff,0x0069e604,0x00657ff2,0x00e33309,0x007c4c1e,0x00fa00e5,0x00f69913,0x0070d5e8,
  0x004e2bc6,0x00c8673d,0x00c4fecb,0x0042b230,0x00ddcd27,0x005b81dc,0x0057182a,0x00d154d1,
  0x0026359f,0x00a07964,0x00ace092,0x002aac69,0x00b5d37e,0x00339f85,0x003f0673,0x00b94a88,
  0x0087b4a6,0x0001f85d,0x000d61ab,0x008b2d50,0x00145247,0x00921ebc,0x009e874a,0x0018cbb1,
  0x00e37b16,0x006537ed,0x0069ae1b,0x00efe2e0,0x00709df7,0x00f6d10c,0x00fa48fa,0x007c0401,
  0x0042fa2f,0x00c4b6d4,0x00c82f22,0x004e63d9,0x00d11cce,0x00575035,0x005bc9c3,0x00dd8538]

def crc24a(data):
    crc = 0
    for d in data:
        tbl_idx = ((crc >> 16) ^ d) & 0xff
        crc = (crc24a_table[tbl_idx] ^ (crc << 8)) & 0xffffff
    return crc & 0xffffff

def decode_transport_block(LLRs_and_rv_idxs, transport_size, **kwargs):
    collected = rate_matching_collect_turbo(LLRs_and_rv_idxs, turbo_len(transport_size))
    LLRs = LTE_turbo_decoder(collected, transport_size, **kwargs)
    with_crc24 = bytes(np.packbits(LLRs < 0))
    if crc24a(with_crc24) != 0:
        return None
    return with_crc24[:-3]

def turbo_encode(message):
    message = np.frombuffer(message, 'uint8')
    crc = crc24a(message)
    message = np.concatenate((message, np.array([crc >> 16, (crc >> 8) & 0xff, crc & 0xff], 'uint8')))
    assert crc24a(message) == 0
    message = np.unpackbits(message)
    message_perm = message[turbo_permutation(message.size)]
    reg0 = 0
    reg1 = 0
    d0 = np.empty(message.size + 4, 'uint8')
    d0[:message.size] = message
    d1 = np.empty_like(d0)
    d2 = np.empty_like(d0)
    for j in range(message.size):
        fb0 = (reg0 ^ (reg0 >> 1)) & 1
        fb1 = (reg1 ^ (reg1 >> 1)) & 1
        in0 = fb0 ^ message[j]
        in1 = fb1 ^ message_perm[j]
        d1[j] = (in0 ^ reg0 ^ (reg0 >> 2)) & 1
        d2[j] = (in1 ^ reg1 ^ (reg1 >> 2)) & 1
        reg0 = (in0 << 2) | (reg0 >> 1)
        reg1 = (in1 << 2) | (reg1 >> 1)
    # trellis termination
    x = np.empty(3, 'uint8')
    z = np.empty_like(x)
    xprime = np.empty_like(x)
    zprime = np.empty_like(x)
    for j in range(3):
        fb0 = (reg0 ^ (reg0 >> 1)) & 1
        fb1 = (reg1 ^ (reg1 >> 1)) & 1
        x[j] = fb0
        xprime[j] = fb1
        z[j] = (reg0 ^ (reg0 >> 2)) & 1
        zprime[j] = (reg1 ^ (reg1 >> 2)) & 1
        reg0 >>= 1
        reg1 >>= 1
    d0[message.size] = x[0]
    d1[message.size] = z[0]
    d2[message.size] = x[1]
    d0[message.size + 1] = z[1]
    d1[message.size + 1] = x[2]
    d2[message.size + 1] = z[2]
    d0[message.size + 2] = xprime[0]
    d1[message.size + 2] = zprime[0]
    d2[message.size + 2] = xprime[1]
    d0[message.size + 3] = zprime[1]
    d1[message.size + 3] = xprime[2]
    d2[message.size + 3] = zprime[2]
    return d0, d1, d2


# Constellation decoding

qpsk_constellation = np.array([1 + 1j, 1 - 1j, -1 + 1j, -1 - 1j]) / np.sqrt(2)


qam16_constellation = np.array([1 + 1j, 1 + 3j, 3 + 1j, 3 + 3j,
                                1 - 1j, 1 - 3j, 3 - 1j, 3 - 3j,
                                -1 + 1j, -1 + 3j, -3 + 1j, -3 + 3j,
                                -1 - 1j, -1 - 3j, -3 - 1j, -3 - 3j]) / np.sqrt(10)

qam64_constellation = np.array([
    3 + 1j*3, 3 + 1j*1, 1 + 1j*3, 1 + 1j*1, 3 + 1j*5, 3 + 1j*7, 1 + 1j*5, 1 + 1j*7,
    5 + 1j*3, 5 + 1j*1, 7 + 1j*3, 7 + 1j*1, 5 + 1j*5, 5 + 1j*7, 7 + 1j*5, 7 + 1j*7,
    3 - 1j*3, 3 - 1j*1, 1 - 1j*3, 1 - 1j*1, 3 - 1j*5, 3 - 1j*7, 1 - 1j*5, 1 - 1j*7,
    5 - 1j*3, 5 - 1j*1, 7 - 1j*3, 7 - 1j*1, 5 - 1j*5, 5 - 1j*7, 7 - 1j*5, 7 - 1j*7,
    -3 + 1j*3, -3 + 1j*1, -1 + 1j*3, -1 + 1j*1, -3 + 1j*5, -3 + 1j*7, -1 + 1j*5, -1 + 1j*7,
    -5 + 1j*3, -5 + 1j*1, -7 + 1j*3, -7 + 1j*1, -5 + 1j*5, -5 + 1j*7, -7 + 1j*5, -7 + 1j*7,
    -3 - 1j*3, -3 - 1j*1, -1 - 1j*3, -1 - 1j*1, -3 - 1j*5, -3 - 1j*7, -1 - 1j*5, -1 - 1j*7,
    -5 - 1j*3, -5 - 1j*1, -7 - 1j*3, -7 - 1j*1, -5 - 1j*5, -5 - 1j*7, -7 - 1j*5, -7 - 1j*7]) / np.sqrt(42)


def maxss(a, b):
    d = np.abs(a - b)
    c = np.zeros(a.shape)
    c[d < 37] = np.exp(-d[d < 37])
    c[d < 9] = np.log1p(c[d < 9])
    return np.maximum(a, b) + c


def llr_demod(symbols, noise_sigma, constellation):
    dists = -np.abs(symbols - constellation[:, np.newaxis]) / (2 * noise_sigma**2)
    bits_per_symbol = round(np.log2(len(constellation)))
    llrs = np.empty((symbols.size, bits_per_symbol))
    for j in range(bits_per_symbol):
        is_one = np.where((np.arange(len(constellation)) >> (bits_per_symbol - 1 - j)) & 1)[0]
        llrs[:, j] = (
            functools.reduce(maxss, (dists[k] for k in range(len(constellation)) if (k >> (bits_per_symbol - 1 - j)) & 1 == 0))
            - functools.reduce(maxss, (dists[k] for k in range(len(constellation)) if (k >> (bits_per_symbol - 1 - j)) & 1 == 1)))
    return llrs.ravel()
