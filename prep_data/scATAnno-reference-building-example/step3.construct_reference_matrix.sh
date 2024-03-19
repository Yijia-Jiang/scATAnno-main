
# 3. construct peak-cell matrix for reference atlas using QuickATAC
output_path=/home/path/
frag_path=/home/path/PBMC_atlas.fragments.tsv.gz
barcode_path=/home/path/PBMC_barcodes.csv
spikein_file=/home/path/spikein_fragment_reference_atlas.tsv # obtained from step 2
bedfile=/home/path/PBMC_Peaks.narrowPeak.bed # obtained from step1 peak calling

quick filter-barcodes $frag_path --barcodes $barcode_path > $output_path/cell_filtered_fragments.tmp.tsv && \
cat $spikein_file $output_path/cell_filtered_fragments.tmp.tsv > $output_path/concat_fake_true_fragments.tmp.tsv && \
mkdir $output_path/tmp/ && sort -T $output_path/tmp/ -k 1,1 -k2,2n $output_path/concat_fake_true_fragments.tmp.tsv > $output_path/concat_fake_true_fragments.sorted.tsv && \
echo "finish sorting concated spike-in fragments" && \
mkdir counts/reference_atlas/ && \
quick agg-countmatrix $output_path/concat_fake_true_fragments.sorted.tsv -g hg38.chrom.sizes.txt -p $bedfile --max-fragsize 999999999 -o counts/reference_atlas/ && \
echo "Done!"

