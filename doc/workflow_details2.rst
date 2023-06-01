Pipeline Overview
===========================

The conceptual idea and schematic of scATAnno is illustrated here.


.. image:: _static/img/2.workflow_details-MainFigure1.png
   :align: center
   :width: 600
   :alt: Workflow of scATAC Annotation


Original Input
------------------

The following files are needed to run *Celltype Annotation* on your own experiment:

- *fragments.tsv.gz* fragment file for each scATAC data
- *fragments.tsv.gz.tbi* fragment index file for each scATAC data
- *cell barcodes* cell barcodes for each scATAC data
- *reference bed file* reference peaks with chromosome regions for a selected reference atlas

- Optionally: *UMAP* or *tSNE* projection coordinates and *Cluster* cluster numbers of cells can be provided by users

Currently, this package only supports hg38 reference mapping


Intermediate Output
--------------------

The following files are intermediate outputs of *Celltype Annotation* in order to generate a peak-by-cell matrix for query data:

- *matrix.mtx* Sparse matrix files with fragment reads
- *peaks.tsv* Reference peaks/cis-Regulatory Elements
- *cell.tsv* Cell barcodes of high quality cells


Final Output
--------------------
The following files are final outputs of *Celltype Annotation* using the annotation tool:

- *merged.h5ad* Anndata of integrated query and reference cells
- *queryOnly.h5ad* Anndata of query cells which store annotation results
- *prediction.tsv* CSV file of cell-type prediction of query cells
- *uncertainty_score.tsv* CSV file of Uncertainty score of cell-type prediction
