.. scATAnno documentation master file, created by
   sphinx-quickstart on Fri Apr 21 10:57:55 2023.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

scATAnno: An Automated Cell Type annotation Pipeline for scATAC-seq
=========================================================================

scATAnno is a Python-based workflow that automates the annotation of single-cell ATAC-seq (scATAC-seq) data using reference atlases. It directly uses chromatin accessibility peaks as input features. scATAnno utilizes large-scale reference atlases constructed from publicly available datasets and various scATAC-seq technologies to annotate cell types in an unsupervised manner. It incorporates uncertainty score metrics to assess the confidence of cell-type assignments. The workflow has been demonstrated to accurately annotate cell types in different case studies, including PBMC, TNBC, and BCC, and can identify unknown cell populations. Overall, scATAnno expedites our understanding of cellular heterogeneity based on chromatin accessibility profiles in complex biological systems.

- Integration of newly generated scATAC-seq data with reference atlases
- Celltype annotation of single-cell chromatin accessibility profile
- Uncertainty score distribution to assess cell-type assignment

.. image:: _static/img/2.workflow_details-MainFigure1.png
   :align: center
   :width: 600
   :alt: Workflow of scATAC Annotation

=================================================================================

.. _citation:


If you use this pipeline, please cite the following reference:

Jiang et al., scATAnno: Automated Cell Type Annotation for single-cell ATAC-seq Data

BioRxiv Preprint (https://www.biorxiv.org/content/10.1101/2023.06.01.543296v2)

The documentation is organized into the following sections:

.. toctree::
   :maxdepth: 2
   :caption: Overview

   overview.rst
   install.rst

.. toctree::
   :maxdepth: 2
   :caption: Reference Atlases

   reference_details.rst

.. toctree::
   :maxdepth: 2
   :caption: Workflow Details

   workflow_details.rst

   workflow_details2.rst

   process_query.rst

.. toctree::
   :maxdepth: 2
   :caption: Algorithms

   algorithm.rst

.. toctree::
  :maxdepth: 2
  :caption: Tutorials

  tutorials.rst
  tutorials/index
