Prepare Reference Atlas
===========================

Human Atlas
------------------
- Select adult cells
- Down sample cell numbers to ~80K high quality cells
- Select cell-type specific peaks (~ 430K peaks)

   .. figure:: umap_human_reference.png
      :scale: 60 %
      :alt: UMAP of Human scATAC Reference Atlas
      :align: center

      Perform dimensionality reduction using spectral embedding, visualize annotation on UMAP

Mouse Atlas
------------------
- Remove unknown cell types
- Down sample cell numbers to ~35K high quality cells
- Use 430,000 potential regulatory elements

   .. figure:: umap_mouse_reference.png
      :scale: 60 %
      :alt: UMAP of Mouse scATAC Reference Atlas
      :align: center

      Perform dimensionality reduction using spectral embedding, visualize annotation on UMAP


Pipeline Overview
===================

The conceptual idea and schematic of scATAC annotation is illustrated here.

   .. figure:: workflow.png
      :scale: 50 %
      :alt: Workflow of scATAC Annotation
      :align: center



Original Input
------------------

The following files are needed to run *Celltype Annotation* on your own experiment:

- *fragments.tsv.gz* files with fragments for each scATAC sample
- *fragments.tsv.gz.tbi* files with fragments index information for each scATAC sample
- *cell barcodes* files with high quality cells for each scATAC sample
- *cell-type specific peak* file obtained from human reference atlas paper

- Optionally: *UMAP* or *tSNE* projection file from each sample

Currently, this package only supports hg38 and mm10 reference mapping


Intermediate Output
--------------------

The following files are intermediate outputs of *Celltype Annotation* to obtain cell-type specific peak by cell matrix:

- *matrix.mtx* Sparse matrix files with fragment reads
- *peaks.tsv* Cell-type restricted peaks
- *cell.tsv* High quality cells, the same cells as input


Final Output
--------------------
The following files are final outputs of *Celltype Annotation* using the annotation tool:

- *merged.h5ad* anndata of integrated query and reference cells
- *prediction.tsv* Cell-type prediction of query cells
- *uncertainty_score.tsv* Uncertainty score of cel-type prediction
