#!/usr/bin/env python2
# -*- coding: utf-8 -*-
##################################################
# GNU Radio Python Flow Graph
# Title: Convert Metadata File
# Generated: Mon Jun 11 21:43:14 2018
##################################################

from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import gr
from gnuradio import gr, blocks
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from optparse import OptionParser


class convert_metadata_file(gr.top_block):

    def __init__(self, infile='0', outfile='0'):
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
    parser = OptionParser(usage="%prog: [options]", option_class=eng_option)
    parser.add_option(
        "", "--infile", dest="infile", type="string", default='0',
        help="Set infile [default=%default]")
    parser.add_option(
        "", "--outfile", dest="outfile", type="string", default='0',
        help="Set outfile [default=%default]")
    return parser


def main(top_block_cls=convert_metadata_file, options=None):
    if options is None:
        options, _ = argument_parser().parse_args()

    tb = top_block_cls(infile=options.infile, outfile=options.outfile)
    tb.start()
    tb.wait()


if __name__ == '__main__':
    main()
