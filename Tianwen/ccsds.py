#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Copyright 2018-2019 Daniel Estevez <daniel@destevez.net>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

from construct import *

import warnings

AOSPrimaryHeader = BitStruct(
    'transfer_frame_version_number' / BitsInteger(2),
    'spacecraft_id' / BitsInteger(8),
    'virtual_channel_id' / BitsInteger(6),
    'virtual_channel_frame_count' / BitsInteger(24),
    'replay_flag' / Flag,
    'vc_frame_count_usage_flag' / Flag,
    'rsvd_spare' / BitsInteger(2),
    'vc_framecount_cycle' / BitsInteger(4)
)

AOSInsertZone = Struct(
    'timestamp' / BytesInteger(6), # in units of 100us
    'unknown' / Hex(Int16ub)
)

M_PDU_Header = BitStruct(
    'rsv_spare' / BitsInteger(5),
    'first_header_pointer' / BitsInteger(11)
)

AOSFrame = Struct(
    'primary_header' / AOSPrimaryHeader,
    'insert_zone' / AOSInsertZone,
    'm_pdu_header' / M_PDU_Header,
    'm_pdu_packet_zone' / GreedyBytes
)

SpacePacketPrimaryHeader = BitStruct(
    'ccsds_version' / BitsInteger(3),
    'packet_type' / BitsInteger(1),
    'secondary_header_flag' / Flag,
    'APID' / BitsInteger(11),
    'sequence_flags' / BitsInteger(2),
    'packet_sequence_count_or_name' / BitsInteger(14),
    'data_length' / BitsInteger(16)
)

def check_space_packet_header(packet):
    return SpacePacketPrimaryHeader.parse(packet).ccsds_version == 0

def check_space_packet_length(packet):
    header = SpacePacketPrimaryHeader.parse(packet)
    expected = header.data_length + SpacePacketPrimaryHeader.sizeof() + 1
    if len(packet) != expected:
        warnings.warn(f'Space Packet has incorrect size. Expected {expected} has {len(packet)}')
        return False
    return True        

def check_space_packet(packet):
    if len(packet) < SpacePacketPrimaryHeader.sizeof():
        return False
    return check_space_packet_header(packet) and check_space_packet_length(packet)

def extract_space_packets(aos_frames, sc_id, virtual_channel, get_timestamps = False):
    packet = bytearray()
    frame_count = None
    for frame in aos_frames:
        version = frame.primary_header.transfer_frame_version_number

        if frame.primary_header.spacecraft_id != sc_id \
          or (version == 1 and frame.m_pdu_header.rsv_spare != 0) \
          or frame.primary_header.virtual_channel_id != virtual_channel:
            continue

        if version == 1:
            # AOS
            frame_count_len = 24
            first = frame.m_pdu_header.first_header_pointer
        elif version == 0:
            # TM
            frame_count_len = 8
            first = frame.primary_header.first_header_pointer
        else:
            warnings.warn(f'[Space Packet extractor Spacecraft {sc_id} VC {virtual_channel}] Unknown transfer frame version number {version}')
            continue
        
        frame_count_new = frame.primary_header.virtual_channel_frame_count
        if frame_count is not None \
          and frame_count_new != ((frame_count + 1) % 2**frame_count_len):
            warnings.warn(f'[Space Packet extractor Spacecraft {sc_id} VC {virtual_channel}] Broken stream. Last frame count {frame_count}, current frame count {frame_count_new}')
            packet = bytearray()
        frame_count = frame_count_new

        if first == 0x7fe:
            # only idle
            continue
        elif first == 0x7ff:
            # no packet starts
            if packet:
                packet.extend(frame.m_pdu_packet_zone)
            continue
        
        if packet:
            packet.extend(frame.m_pdu_packet_zone[:first])
            packet = bytes(packet)
            if check_space_packet(packet):
                if get_timestamps:
                    yield packet, timestamp
                else:
                    yield packet

        while True:
            packet = bytearray(frame.m_pdu_packet_zone[first:][:SpacePacketPrimaryHeader.sizeof()])
            if get_timestamps:
                timestamp = frame.insert_zone.timestamp
            if len(packet) >= SpacePacketPrimaryHeader.sizeof() and not check_space_packet_header(packet):
                # not a space packet
                # cannot follow in this frame
                packet = bytearray()
                break
            elif len(packet) < SpacePacketPrimaryHeader.sizeof():
                # not full header inside frame
                break
            first += SpacePacketPrimaryHeader.sizeof()
            packet_header = SpacePacketPrimaryHeader.parse(packet)
            packet.extend(frame.m_pdu_packet_zone[first:][:packet_header.data_length + 1])
            first += packet_header.data_length + 1
            if first > len(frame.m_pdu_packet_zone):
                # packet does not end in this frame
                break
            packet = bytes(packet)
            if check_space_packet(packet):
                if get_timestamps:
                    yield packet, timestamp
                else:
                    yield packet
            packet = bytearray()
            if first == len(frame.m_pdu_packet_zone):
                # packet just ends in this frame
                break
