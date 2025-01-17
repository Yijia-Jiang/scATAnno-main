Process Query Datasets
===================

---------------------------------
- Code used for process query datasets

prep_data/prepare_query

- Software needed

   - please install https://github.com/AllenWLynch/QuickATAC

   - gunzip

- load input files in prepare_query.sh

   - reference peak file peaks.bed

   - Frag_path path to fragments.tsv.gz

   - Barcode_path path to barcodes.tsv

   - hg38.chrom.sizes.txt within the reference buidling folder hg38.chrom.sizes.txt


- command to process query data
::

    bash prepare_query.sh

This command will prepare the query data based on the following steps:


   - 1. prepare peak-cell matrix file

   - 2. construct peak-cell matrix for reference atlas using QuickATAC

   - 3. prepare reference atlas h5ad file for scATAnno



