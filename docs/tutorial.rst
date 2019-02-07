.. _tutorial:

Tutorial
========

This tutorial will run the RevMet method on a set of 600 nanopore reads using Illumina genome skims for 7 species at around 0.2x coverage. The coverage level has been reduced in order to make the tutorial run quicker - for real data, we recommend higher coverage.

The example below has been designed to run on a laptop/desktop computer, with alignments running in series. Much greater performance can be achieved by running in parallel on High Performance Computing (HPC).

On a 2017 2.9Ghz i7 quad core MacBook Pro, this example takes around 8 minutes to run.

A number of dependencies should be installed prior to this tutorial -
|python_link|, |minimap_link|, and |samtools_link|.

#. Download the example RevMet dataset from |download_link| and uncompress::

     tar -xvf revmet_example.tar.gz

#. Change into the directory::

     cd revmet_example

#. Run the revmet example bash script::

     sh revmet_example.sh

#. To view the read counts for each of the constituent species::

     cat output/mock_mix_1_1_bin_counts.txt

#. To view the species composition of the sample as percentages::

     cat output/mock_mix_1_1_bin_percentges.txt

.. |download_link| raw:: html

  <a href="https://nbicloud-my.sharepoint.com/:u:/g/personal/peeln_nbi_ac_uk/EUbhyIrU-P1EhTv1dsNExZQBQ60hI00joX6ecbajJJRF3w?e=eImjAo" target="_blank">here</a>

.. |python_link| raw:: html

  <a href="https://www.python.org/downloads/" target="_blank">python</a>

.. |minimap_link| raw:: html

  <a href="https://github.com/lh3/minimap2" target="_blank">minimap2</a>

.. |samtools_link| raw:: html

  <a href="http://www.htslib.org/download/" target="_blank">samtools</a>
