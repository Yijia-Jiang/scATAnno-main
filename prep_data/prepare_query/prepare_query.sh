# To run build_reference.sh, you need to change:
# 4 file paths below (reference_peak_bed, frag_path, barcode_path, output_path).

reference_peak_bed=/mnt/cfce-rcsm/projects/nibr_pbmc/scATAC/ref_peak_count_matrix/peaks.bed
frag_path=/mnt/cfce-rcsm/projects/nibr_pbmc/yi-zhang/nibr_multiome/data/sample4/atac_fragments.tsv.gz
barcode_path=/mnt/cfce-rcsm/projects/nibr_pbmc/yi-zhang/nibr_multiome/data/sample4/filtered_feature_bc_matrix/barcodes.tsv
output_path=/home/yj976/scATAnno_benchmark/prepare_query_cells

hg38chromsize=/mnt/cfce-rcsm/projects/nibr_pbmc/scATAC/ref_peak_count_matrix/counts/peak-count-matrix-macs2/hg38.chrom.sizes.txt



# 1. prepare peak-cell matrix file
# inputFile is obtained from Step1 peak calling

cut -f 1-3 $reference_peak_bed > $output_path/peaks.bed

python prepare_files.py --inputFile $output_path/peaks.bed --outputFile $output_path/spikein_fragment.tsv


# 2. construct peak-cell matrix for reference atlas using QuickATAC
gunzip -c $frag_path > $output_path/fragments.unfilter.tsv

quick filter-barcodes $output_path/fragments.unfilter.tsv --barcodes $barcode_path > $output_path/filtered_fragments.tmp.tsv && \
cat $output_path/spikein_fragment.tsv $output_path/filtered_fragments.tmp.tsv > $output_path/concat_spikein_fragments.tmp.tsv && \
mkdir $output_path/tmp/ && sort -T $output_path/tmp/ -k 1,1 -k2,2n $output_path/concat_spikein_fragments.tmp.tsv > $output_path/concat_spikein_fragments.tmp.sort.tsv && \
echo "finish sorting concated spike-in fragments" && \
quick agg-countmatrix $output_path/concat_spikein_fragments.tmp.sort.tsv -g $hg38chromsize -p $output_path/peaks.bed --max-fragsize 999999999 -o $output_path && \
echo "Count matrix done!"


# 3. prepare reference atlas h5ad file for scATAnno
gunzip -k $output_path/barcodes.tsv.gz

gunzip -k $output_path/features.tsv.gz

python generate_atlas.py --countMatrixLocation $output_path

