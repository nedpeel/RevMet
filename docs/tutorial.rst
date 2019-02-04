.. _tutorial:

Tutorial
========

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
