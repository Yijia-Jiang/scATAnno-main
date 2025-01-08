Prepare Reference Atlas
===========================
How to Build a Reference
---------------------------------
- dirctory of the code
- input files
- command to create the reference
::

    pip install scATAnno
::
    # Command line: callpeak -f BEDPE -g hs --nomodel --extsize 50 --keep-dup all -q 0.1 -t /mnt/cfce-rcsm/projects/nibr_pbmc/yi-zhang/nibr_multiome/data/sample4/atac_fragments.tsv.gz -n macs2

- succssful message (copy)

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
