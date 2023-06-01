Prepare Reference Atlas
===========================

Healthy Adult Reference Atlas
---------------------------------
- Select deep-sequenced 100K adult cells
- Select adult specific peaks (~ 890K peaks)

   .. figure:: _static/img/2.workflow_details-HealthyAdult.png
      :scale: 80 %
      :alt: UMAP of Human scATAC Reference Atlas
      :align: center

      Perform dimensionality reduction using spectral embedding, visualize annotation on UMAP

PBMC Reference Atlas
----------------------
- Select 39441 PBMC cells
- Generate 196K peaks by MACS2 Peak-Calling

   .. figure:: _static/img/2.workflow_details-PBMC.png
      :scale: 80 %
      :alt: UMAP of PBMC scATAC Reference Atlas
      :align: center

      Perform dimensionality reduction using spectral embedding, visualize annotation on UMAP


BCC TIL Reference Atlas
--------------------------
- Select 22008 TIL cells
- Generate 340K peaks by MACS2 Peak-Calling

   .. figure:: _static/img/2.workflow_details-TIL.png
      :scale: 80 %
      :alt: UMAP of Mouse scATAC Reference Atlas
      :align: center

      Perform dimensionality reduction using spectral embedding, visualize annotation on UMAP
