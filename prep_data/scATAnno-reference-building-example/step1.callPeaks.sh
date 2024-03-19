
# call peaks using MACS2 for fragment file

/home/path/macs2 callpeak \
    -f BEDPE \
    -g hs \
    --nomodel \
    --extsize 50 \
    --keep-dup all \
    -q 0.1 \
    -t PBMC_atlas.fragments.tsv.gz \
    -n PBMC_atlas

