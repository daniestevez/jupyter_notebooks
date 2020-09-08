#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#
# SPDX-License-Identifier: GPL-3.0
#
# GNU Radio Python Flow Graph
# Title: Convert Metadata File
# GNU Radio version: 3.8.1.0

from gnuradio import blocks
from gnuradio import gr
from gnuradio.filter import firdes
import sys
import signal
from argparse import ArgumentParser
from gnuradio.eng_arg import eng_float, intx
from gnuradio import eng_notation
from gnuradio import gr, blocks


class convert_metadata_file(gr.top_block):

    def __init__(self, infile='', outfile=''):
        gr.top_block.__init__(self, "Convert Metadata File")

        ##################################################
        # Parameters
        ##################################################
        self.infile = infile
        self.outfile = outfile

        ##################################################
        # Variables
        ##################################################
        self.samp_rate = samp_rate = 40000

        ##################################################
        # Blocks
        ##################################################
        self.blocks_file_sink_1 = blocks.file_sink(gr.sizeof_gr_complex*1, outfile, False)
        self.blocks_file_sink_1.set_unbuffered(False)
        self.blocks_file_meta_source_0 = blocks.file_meta_source(infile, False, False, '')



        ##################################################
        # Connections
        ##################################################
        self.connect((self.blocks_file_meta_source_0, 0), (self.blocks_file_sink_1, 0))


    def get_infile(self):
        return self.infile

    def set_infile(self, infile):
        self.infile = infile
        self.blocks_file_meta_source_0.open(self.infile, False)

    def get_outfile(self):
        return self.outfile

    def set_outfile(self, outfile):
        self.outfile = outfile
        self.blocks_file_sink_1.open(self.outfile)

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate




def argument_parser():
    parser = ArgumentParser()
    parser.add_argument(
        "--infile", dest="infile", type=str, default='',
        help="Set infile [default=%(default)r]")
    parser.add_argument(
        "--outfile", dest="outfile", type=str, default='',
        help="Set outfile [default=%(default)r]")
    return parser


def main(top_block_cls=convert_metadata_file, options=None):
    if options is None:
        options = argument_parser().parse_args()
    tb = top_block_cls(infile=options.infile, outfile=options.outfile)

    def sig_handler(sig=None, frame=None):
        tb.stop()
        tb.wait()

        sys.exit(0)

    signal.signal(signal.SIGINT, sig_handler)
    signal.signal(signal.SIGTERM, sig_handler)

    tb.start()

    tb.wait()


if __name__ == '__main__':
    main()
