#!/usr/bin/env python
import argparse
import sys
import os

# ----- command line parsing -----
parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description='Count occurrences of each skim reference in binned percent coverage files')
parser.add_argument('binned_pc_file', type=str, help='Binned percentage coverage file.')
parser.add_argument('illumina_reference_list', type=str, help='List of Illumina reference IDs including "unassigned".')
parser.add_argument('min_pc', type=float, default=15, help='Minimum percent coverage.')
parser.add_argument('max_pc', type=float, default=100, help='Maximum percent coverage.')
args = parser.parse_args()
# ----- end command line parsing -----

binned_pc_file = open(args.binned_pc_file)
illumina_reference_list = open(args.illumina_reference_list)

min_pc = args.min_pc
max_pc = args.max_pc

dict = {}

for id in illumina_reference_list:
    id = id.strip()
    dict[id] = 0

for line in binned_pc_file:
    line = line.strip()
    minion_read_id, illumina_ref, pc = line.split(' ')
    if float(pc) < min_pc or float(pc) > max_pc:
        dict["unassigned"] += 1
    else:
        if illumina_ref in dict:
            dict[illumina_ref] += 1

        else:
            dict[illumina_ref] = 1


for key in dict:
    illumina_ref_out = key
    count_out = int(dict[key])
    sys.stdout.write("{0} {1}\n".format(illumina_ref_out, count_out))