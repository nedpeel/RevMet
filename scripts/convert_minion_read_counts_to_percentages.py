#!/usr/bin/env python
import argparse
import sys

# ----- command line parsing -----
parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,
                                 description='Removes bins that contain fewer than X % of assigned reads and converts counts to percentages.')
parser.add_argument('read_count_file', type=str, help='Read count file.')
parser.add_argument('-t', type=float, dest='bin_threshold', default=1,
                    help='Bin threshold percentage. Species with fewer than this percentage of the total assigned reads will be set to 0.')
args = parser.parse_args()
# ----- end command line parsing -----


threshold = args.bin_threshold

assigned_sum = 0
unassigned = 0
new_sum = 0
id_count_dict = {}

with open(args.read_count_file) as open_read_count_file:
    for line in open_read_count_file:
        col1_ref_id, col2_read_count = line.split(' ')
        col2_read_count = int(col2_read_count)
        if col1_ref_id != "unassigned":
            assigned_sum += col2_read_count
        else:
            unassigned += col2_read_count
        id_count_dict[col1_ref_id] = col2_read_count

threshold_count = (float(assigned_sum) / 100) * threshold

for id in id_count_dict:
    if id_count_dict[id] < threshold_count or id == "unassigned":
        unassigned += id_count_dict[id]
        id_count_dict[id] = 0
    else:
        new_sum += id_count_dict[id]

with open(args.read_count_file) as open_read_count_file:
    for line in open_read_count_file:
        col1_ref_id, col2_read_count = line.split(' ')
        if col1_ref_id != "unassigned":
            bin_percentage = (float(id_count_dict[col1_ref_id]) / new_sum) * 100
            sys.stdout.write("{} {:.1f}\n".format(col1_ref_id, bin_percentage))