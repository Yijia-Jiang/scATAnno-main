Prepare Reference Atlas
===========================
How to Build a Reference
---------------------------------
- Code used for reference budiling

prep_data/scATAnno-reference-building-example

- input files

build_reference.sh

generate_atlas.py  

prepare_files.py

- command to create the reference
::

    bash build_reference.sh

This command will build reference based on the following steps:
# 1. call peaks using MACS2 from fragment file

# 2. prepare peak-cell matrix file

# 3. construct peak-cell matrix for reference atlas using QuickATAC

# 4. prepare reference atlas h5ad file for scATAnno

# 5. (optional) Create reference low-dimensional spectral embedding for futher use 


- following is a succssful message
::
    INFO  @ Sun, 05 Jan 2025 02:47:40: 
    # Command line: callpeak -f BEDPE -g hs --nomodel --extsize 50 --keep-dup all -q 0.1 -t /mnt/atac_fragments.tsv.gz -n macs2
    # ARGUMENTS LIST:
    # name = macs2
    # format = BEDPE
    # ChIP-seq file = ['/mnt/atac_fragments.tsv.gz']
    # control file = None
    # effective genome size = 2.70e+09
    # band width = 300
    # model fold = [5, 50]
    # qvalue cutoff = 1.00e-01
    # Larger dataset will be scaled towards smaller dataset.
    # Range for calculating regional lambda is: 10000 bps
    # Broad region calling is off
    # Paired-End mode is on
    INFO  @ Sun, 05 Jan 2025 02:47:40: #1 read fragment files... 
    INFO  @ Sun, 05 Jan 2025 02:47:40: #1 read treatment fragments... 
    INFO  @ Sun, 05 Jan 2025 02:47:42:  1000000 
    INFO  @ Sun, 05 Jan 2025 02:47:43:  2000000 
    INFO  @ Sun, 05 Jan 2025 02:47:44:  3000000 
    INFO  @ Sun, 05 Jan 2025 02:47:46:  4000000 
    INFO  @ Sun, 05 Jan 2025 02:47:47:  5000000 
    INFO  @ Sun, 05 Jan 2025 02:47:48:  6000000 
    INFO  @ Sun, 05 Jan 2025 02:47:50:  7000000 
    INFO  @ Sun, 05 Jan 2025 02:47:51:  8000000 
    INFO  @ Sun, 05 Jan 2025 02:47:52:  9000000 
    INFO  @ Sun, 05 Jan 2025 02:47:54:  10000000 
    INFO  @ Sun, 05 Jan 2025 02:47:55:  11000000 
    INFO  @ Sun, 05 Jan 2025 02:47:56:  12000000 
    INFO  @ Sun, 05 Jan 2025 02:47:58:  13000000 
    INFO  @ Sun, 05 Jan 2025 02:47:59:  14000000 
    INFO  @ Sun, 05 Jan 2025 02:48:00:  15000000 
    INFO  @ Sun, 05 Jan 2025 02:48:02:  16000000 
    INFO  @ Sun, 05 Jan 2025 02:48:03:  17000000 
    INFO  @ Sun, 05 Jan 2025 02:48:04:  18000000 
    INFO  @ Sun, 05 Jan 2025 02:48:05:  19000000 
    INFO  @ Sun, 05 Jan 2025 02:48:07:  20000000 
    INFO  @ Sun, 05 Jan 2025 02:48:08:  21000000 
    INFO  @ Sun, 05 Jan 2025 02:48:09:  22000000 
    INFO  @ Sun, 05 Jan 2025 02:48:12:  23000000 
    INFO  @ Sun, 05 Jan 2025 02:48:13:  24000000 
    INFO  @ Sun, 05 Jan 2025 02:48:15:  25000000 
    INFO  @ Sun, 05 Jan 2025 02:48:16:  26000000 
    INFO  @ Sun, 05 Jan 2025 02:48:19:  27000000 
    INFO  @ Sun, 05 Jan 2025 02:48:21:  28000000 
    INFO  @ Sun, 05 Jan 2025 02:48:23:  29000000 
    INFO  @ Sun, 05 Jan 2025 02:48:24:  30000000 
    INFO  @ Sun, 05 Jan 2025 02:48:26:  31000000 
    INFO  @ Sun, 05 Jan 2025 02:48:27:  32000000 
    INFO  @ Sun, 05 Jan 2025 02:48:29:  33000000 
    INFO  @ Sun, 05 Jan 2025 02:48:31:  34000000 
    INFO  @ Sun, 05 Jan 2025 02:48:33:  35000000 
    INFO  @ Sun, 05 Jan 2025 02:48:36:  36000000 
    INFO  @ Sun, 05 Jan 2025 02:48:39:  37000000 
    INFO  @ Sun, 05 Jan 2025 02:48:40:  38000000 
    INFO  @ Sun, 05 Jan 2025 02:48:42:  39000000 
    INFO  @ Sun, 05 Jan 2025 02:48:43:  40000000 
    INFO  @ Sun, 05 Jan 2025 02:48:44:  41000000 
    INFO  @ Sun, 05 Jan 2025 02:48:46:  42000000 
    INFO  @ Sun, 05 Jan 2025 02:48:47:  43000000 
    INFO  @ Sun, 05 Jan 2025 02:48:48:  44000000 
    INFO  @ Sun, 05 Jan 2025 02:48:50:  45000000 
    INFO  @ Sun, 05 Jan 2025 02:48:51:  46000000 
    INFO  @ Sun, 05 Jan 2025 02:48:53:  47000000 
    INFO  @ Sun, 05 Jan 2025 02:48:54:  48000000 
    INFO  @ Sun, 05 Jan 2025 02:48:55:  49000000 
    INFO  @ Sun, 05 Jan 2025 02:48:56:  50000000 
    INFO  @ Sun, 05 Jan 2025 02:48:58:  51000000 
    INFO  @ Sun, 05 Jan 2025 02:48:59:  52000000 
    INFO  @ Sun, 05 Jan 2025 02:49:01:  53000000 
    INFO  @ Sun, 05 Jan 2025 02:49:02:  54000000 
    INFO  @ Sun, 05 Jan 2025 02:49:03:  55000000 
    INFO  @ Sun, 05 Jan 2025 02:49:04:  56000000 
    INFO  @ Sun, 05 Jan 2025 02:49:06:  57000000 
    INFO  @ Sun, 05 Jan 2025 02:49:07:  58000000 
    INFO  @ Sun, 05 Jan 2025 02:49:08:  59000000 
    INFO  @ Sun, 05 Jan 2025 02:49:09:  60000000 
    INFO  @ Sun, 05 Jan 2025 02:49:10:  61000000 
    INFO  @ Sun, 05 Jan 2025 02:49:12:  62000000 
    INFO  @ Sun, 05 Jan 2025 02:49:13:  63000000 
    INFO  @ Sun, 05 Jan 2025 02:49:14:  64000000 
    INFO  @ Sun, 05 Jan 2025 02:49:15:  65000000 
    INFO  @ Sun, 05 Jan 2025 02:49:16:  66000000 
    INFO  @ Sun, 05 Jan 2025 02:49:18:  67000000 
    INFO  @ Sun, 05 Jan 2025 02:49:19:  68000000 
    INFO  @ Sun, 05 Jan 2025 02:49:20:  69000000 
    INFO  @ Sun, 05 Jan 2025 02:49:21:  70000000 
    INFO  @ Sun, 05 Jan 2025 02:49:22:  71000000 
    INFO  @ Sun, 05 Jan 2025 02:49:24:  72000000 
    INFO  @ Sun, 05 Jan 2025 02:49:25:  73000000 
    INFO  @ Sun, 05 Jan 2025 02:49:26:  74000000 
    INFO  @ Sun, 05 Jan 2025 02:49:27:  75000000 
    INFO  @ Sun, 05 Jan 2025 02:49:29:  76000000 
    INFO  @ Sun, 05 Jan 2025 02:49:30:  77000000 
    INFO  @ Sun, 05 Jan 2025 02:49:31:  78000000 
    INFO  @ Sun, 05 Jan 2025 02:49:32:  79000000 
    INFO  @ Sun, 05 Jan 2025 02:49:58: #1 mean fragment size is determined as 111 bp from treatment 
    INFO  @ Sun, 05 Jan 2025 02:49:58: #1 fragment size = 111 
    INFO  @ Sun, 05 Jan 2025 02:49:58: #1  total fragments in treatment: 79005263 
    INFO  @ Sun, 05 Jan 2025 02:49:58: #1 finished! 
    INFO  @ Sun, 05 Jan 2025 02:49:58: #2 Build Peak Model... 
    INFO  @ Sun, 05 Jan 2025 02:49:58: #2 Skipped... 
    INFO  @ Sun, 05 Jan 2025 02:49:58: #2 Use 111 as fragment length 
    INFO  @ Sun, 05 Jan 2025 02:49:58: #3 Call peaks... 
    INFO  @ Sun, 05 Jan 2025 02:49:58: #3 Pre-compute pvalue-qvalue table... 
    INFO  @ Sun, 05 Jan 2025 02:52:19: #3 Call peaks for each chromosome... 
    INFO  @ Sun, 05 Jan 2025 02:53:18: #4 Write output xls file... macs2_peaks.xls 
    INFO  @ Sun, 05 Jan 2025 02:53:19: #4 Write peak in narrowPeak format file... macs2_peaks.narrowPeak 
    INFO  @ Sun, 05 Jan 2025 02:53:19: #4 Write summits bed file... macs2_summits.bed 
    INFO  @ Sun, 05 Jan 2025 02:53:19: Done! 
    finish sorting concated spike-in fragments
    Aggregating fragments:   0%|                                                                 | 68.2k/2.48G [00:00<3:08:41, 235kB/s]***** WARNING: File /home/yj976/scATAnno_benchmark/reference_build/peaks.bed has inconsistent naming convention for record:
    GL000194.1         55958    56319
     
    Aggregating fragments: 100%|██████████████████████████████████████████████████████████████████| 2.48G/2.48G [01:05<00:00, 40.5MB/s]
    ***** WARNING: File /home/yj976/scATAnno_benchmark/reference_build/peaks.bed has inconsistent naming convention for record:
    GL000194.1         55958    56319
     
    Count matrix done!
    

Healthy Adult Reference Atlas
---------------------------------
- Select deep-sequenced 100K adult cells
- Select adult specific peaks (~ 890K peaks)
- `Downloaded Healthy Adult Reference atlas <https://www.dropbox.com/s/3ezp2t6gw6hw21v/Healthy_Adult_reference_atlas.h5ad?dl=0>`_

   .. figure:: _static/img/2.workflow_details-HealthyAdult.png
      :scale: 80 %
      :alt: UMAP of Human scATAC Reference Atlas
      :align: center

      Perform dimensionality reduction using spectral embedding, visualize annotation on UMAP

PBMC Reference Atlas
----------------------
- Select 39441 PBMC cells
- Generate 196K peaks by MACS2 Peak-Calling
- `Downloaded PBMC atlas <https://www.dropbox.com/s/y9wc6h5mmydj7gf/PBMC_reference_atlas_final.h5ad?dl=0>`_

   .. figure:: _static/img/2.workflow_details-PBMC.png
      :scale: 80 %
      :alt: UMAP of PBMC scATAC Reference Atlas
      :align: center

      Perform dimensionality reduction using spectral embedding, visualize annotation on UMAP


BCC TIL Reference Atlas
--------------------------
- Select 22008 TIL cells
- Generate 340K peaks by MACS2 Peak-Calling
- `Downloaded TIL atlas <https://www.dropbox.com/s/ky4jezsj3pf2qwi/BCC_TIL_reference_atlas_final.h5ad?dl=0>`_

   .. figure:: _static/img/2.workflow_details-TIL.png
      :scale: 80 %
      :alt: UMAP of Mouse scATAC Reference Atlas
      :align: center

      Perform dimensionality reduction using spectral embedding, visualize annotation on UMAP
