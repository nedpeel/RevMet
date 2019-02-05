.. _tutorial:

Tutorial
========

This tutorial will run the RevMet method on a set of X nanopore reads using Illumina genome skims for 7 species at around 0.2x coverage. The coverage level has been reduced in order to make the tutorial run quicker - for real data, we recommend higher coverage.

The example below has been designed to run on a laptop/desktop computer, with alignments running in series. Much greater performance can be achieved by running in parallel on High Performance Computing (HPC).

On a 2017 2.9Ghz i7 quad core MacBook Pro, this example takes around 1 hour to run.

A number of dependencies should be installed prior to this tutorial -
`Python <https://www.python.org/downloads/>`__, `minimap2 <https://github.com/lh3/minimap2>`__,
and `samtools <http://www.htslib.org/download/>`__.

#. Download the `example RevMet
   dataset <http://link.com/revmet_example.tar.gz>`__
   from http://link.com/ and uncompress::

     tar -xvf revmet_example.tar.gz

#. Change into the directory::

     cd revmet_example

#. Run the revmet example bash script::

     sh revmet_example_script.sh

#. View the read counts for each of species within the sample::

     cat mock_mix_1_1_read_bin_counts_15_99_9.txt

How the example script works
============================

Go through commands that will be run.
