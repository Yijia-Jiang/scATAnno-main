Prepare Reference Atlas
===========================
How to Build a Reference
---------------------------------
- Code used for reference budiling

prep_data/scATAnno-reference-building-example

- Software needed
# please install https://github.com/AllenWLynch/QuickATAC
# MACS2 if need to call peaks
# gunzip

- input files

# Frag_path path to fragments.tsv.gz
# Barcode_path path to barcodes.tsv
# hg38.chrom.sizes.txt within the reference buidling folder hg38.chrom.sizes.txt

- command to create the reference
::

    bash build_reference.sh

This command will build reference based on the following steps:

# 1. call peaks using MACS2 from fragment file

# 2. prepare peak-cell matrix file

# 3. construct peak-cell matrix for reference atlas using QuickATAC

# 4. prepare reference atlas h5ad file for scATAnno

# 5. (optional) Create reference low-dimensional spectral embedding for futher use 


   


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
