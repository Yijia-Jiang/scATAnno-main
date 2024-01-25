#!/bin/bash

# Download the files using the following DropBox Link
spikein=spikein_fragment_BCC_narrowPeak.tsv # https://www.dropbox.com/scl/fi/qy6upaefqxv8c97n2x8rw/spikein_fragment_BCC_narrowPeak.tsv?rlkey=dw851ai6xkh7nt2r55bm0oft4&dl=0
bedfile=BCC_Atlas_merged_peak.narrowPeak.filter.sorted.bed # https://www.dropbox.com/scl/fi/pap6zxu5mn5r6oxgqu66w/BCC_Atlas_merged_peak.narrowPeak.filter.sorted.bed?rlkey=ycbsrtd6rn9fzcsljfu2mf626&dl=0

# Run QuickATAC
for sample in B_Cell_Lymphoma; do echo "start processing for sample $sample" && quick filter-barcodes input/$sample/*fragments.tsv.gz --barcodes input/$sample/*barcodes.csv > input/$sample/cell_filtered_fragments.tmp.tsv && cat input/$spikein input/$sample/cell_filtered_fragments.tmp.tsv > input/$sample/concat_fake_true_fragments.tmp.tsv && sort -k 1,1 -k2,2n input/$sample/concat_fake_true_fragments.tmp.tsv > input/$sample/concat_fake_true_fragments.sorted.tsv && echo "finish sorting concated spike-in fragments" && mkdir counts/$sample'_vTIL'/ && 
quick agg-countmatrix input/$sample/concat_fake_true_fragments.sorted.tsv -g input/hg38.chrom.sizes.txt -p input/$bedfile --max-fragsize 999999999 -o counts/$sample'_vTIL'/ && echo "Done!"; done
