# Scripts

**percent_coverage_from_depth_file.py**
Calculates "percent coverage", defined as the fraction of nucleotide positions that were mapped to by one or more reference-skim Illumina reads, for each long read in a SAMtools depth file.

**minion_read_bin_from_perc_cov.py**
Takes a concatenated percent coverage file and uniquely assigns each long read to the species that mapped with the highest percent coverage.

**minion_read_bin_counts_from_perc_cov_binned_with_threshold.py**
Counts the number of long reads binned to each species and can filter reads into "unassigned" based on percent coverage thresholds. By default, if the highest percent coverage for a read is <15% its identity is judged to be ambiguous and it's left unassigned.

**convert_minion_read_counts_to_percentages.py**
By default this script implements a 1% minimum-abundance filter, which sets plant species represented by fewer than 1% of the total assigned long reads to zero before converting the read counts to percentages. The minimum-abundance filter threshold can be altered with the "-t" flag.

To learn more about RevMet and how to implement the method, see the [RevMet Documentation](https://revmet.readthedocs.io/en/latest/index.html).
