#!/bin/bash


# Download the files using the following DropBox Link
spikein=spikein_fragment_adult.tsv # https://www.dropbox.com/scl/fi/ibf5zhflpi84j911l0s0i/spikein_fragment_adult.tsv?rlkey=itub8izib74uin4ea9s28wkf1&dl=0
bedfile=adult_specific_peaks.sorted.new.bed # https://www.dropbox.com/scl/fi/3y3p69y30umg8ucxceh4t/adult_specific_peaks.sorted.new.bed?rlkey=90eildgbi5miqb1ajsybi4stm&dl=0
chromsize_file=hg38.chrom.sizes.txt # https://www.dropbox.com/scl/fi/x9i1fpno5n7u9wus92l0t/hg38.chrom.sizes.txt?rlkey=3aldjof2gjp3ahm23rgui70b3&dl=0

# Run QuickATAC
for sample in sample1; do echo "start processing for sample $sample" && quick filter-barcodes input/$sample/*fragments.tsv.gz --barcodes input/$sample/*barcodes.tsv > input/$sample/cell_filtered_fragments.tmp.tsv && cat input/$spikein input/$sample/cell_filtered_fragments.tmp.tsv > input/$sample/concat_fake_true_fragments.tmp.tsv && sort -k 1,1 -k2,2n input/$sample/concat_fake_true_fragments.tmp.tsv > input/$sample/concat_fake_true_fragments.sorted.tsv && echo "finish sorting concated spike-in fragments" && mkdir counts/$sample'_HealthyAult'/ && 
quick agg-countmatrix input/$sample/concat_fake_true_fragments.sorted.tsv -g input/$chromsize_file -p input/$bedfile --max-fragsize 999999999 -o counts/$sample'_HealthyAult'/ && echo "Done!"; done


