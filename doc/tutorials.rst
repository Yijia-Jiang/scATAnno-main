Case Study Datasets
===================


Three case studies below gives you a taste of different capabilities of our Annotation workflow. The datasets you will be exploring are:

1) PBMC 10K Multiome from 10X

   - Raw data can be directly downloaded from 10X webpage: https://support.10xgenomics.com/single-cell-multiome-atac-gex/datasets/1.0.0/pbmc_granulocyte_sorted_10k
   - `Processed PBMC data download <https://www.dropbox.com/sh/spffa139jqfg3n4/AABzG0UDuWF9jWDL-lH8KFWBa?dl=0>`_

2) scATAC of Triple Negative Breast Cancer (TNBC)

   Citation: Zhang, Yuanyuan, Hongyan Chen, Hongnan Mo, Xueda Hu, Ranran Gao, Yahui Zhao, Baolin Liu, et al. 2021. “Single-Cell Analyses Reveal Key Immune Cell Subsets Associated with Response to PD-L1 Blockade in Triple-Negative Breast Cancer.” Cancer Cell 39 (12): 1578–93.e8.

   - We selected one scATAC sample (9,935 cells) collected from TNBC patients and applied the TIL reference atlas to annotate TIL cells from the TNBC query data
   - `Processed TNBC data download <https://www.dropbox.com/sh/gbsbnnfdiz2figa/AADmAJvg2i6nz6sINF0RXThqa?dl=0>`_

   .. figure:: _static/img/3.Tutorials-TNBC.png
      :scale: 60 %
      :alt: UMAP of TNBC cells
      :align: center

3) scATAC of two hold-out Basal cell carcinoma samples

   Citation: Satpathy, Ansuman T et al. “Massively parallel single-cell chromatin landscapes of human immune cell development and intratumoral T cell exhaustion.” Nature biotechnology (2019)

   - We selected two BCC samples held out from the BCC TIL reference building as query data. One sample is pre-treatment and the other is post-treatment by immunotherapy. The original information of BCC cells is shown below:
   - `Processed BCC data download <https://www.dropbox.com/sh/dwn0ynon4bzzj4t/AAB8ei6223oIWC14ry_lNdSma?dl=0>`_

   .. figure:: _static/img/Study2.png
      :scale: 60 %
      :alt: UMAP of BCC cells
      :align: center
