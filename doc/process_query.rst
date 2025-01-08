Process Query Datasets
===================


Example of generating BCC query count matrix

Input file requires:
- "bedfile" reference peaks bed file (dropbox link) \n
- "spikein" a spikein file to retain all reference peaks as features in the final matrix (dropbox)
- chrom_size_file hg38 chromsome size file, provided by QuickATAC
- sample_directory: directory where sample fragment file and cell barcodes are stored


Three steps:
1. quick filter-barcodes function filters fragment file by barcodes
2. concatenate fragment file with spike-in pseudo-fragment file, and sort the concatenated cell_filtered_fragments. This step retains all reference peaks as features in the final output
3. agg-countmatrix function creates matrix.mtx, features.tsv and barcodes.tsc files for the query sample

Output file includes:
- matrix.mtx stores matrix
- features.tsv stores reference peaks
- barcodes.tsv stores cell barcodes

```

#!/bin/bash

bedfile=BCC_Atlas_merged_peak.narrowPeak.filter.sorted.bed
spikein=spikein_fragment_BCC_narrowPeak.tsv
chrom_size_file=hg38.chrom.sizes.txt
sample_directory=BCC_samples

quick filter-barcodes input/$sample_directory/*fragments.tsv.gz --barcodes input/$sample_directory/*barcodes.tsv > input/$sample_directory/cell_filtered_fragments.tmp.tsv &&
cat input/$spikein input/$sample_directory/cell_filtered_fragments.tmp.tsv > input/$sample_directory/concat_fake_true_fragments.tmp.tsv &&
sort -k 1,1 -k2,2n input/$sample_directory/concat_fake_true_fragments.tmp.tsv > input/$sample_directory/concat_fake_true_fragments.sorted.tsv &&
echo "finish sorting concated spike-in fragments" && mkdir counts/$sample_directory/ &&
quick agg-countmatrix input/$sample_directory/concat_fake_true_fragments.sorted.tsv -g input/$chrom_size_file -p input/$bedfile --max-fragsize 999999999 -o counts/$sample_directory/ &&
echo "Done!"

```
