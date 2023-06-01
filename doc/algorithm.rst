Dimension reduction
=========================================================
Cited from https://kzhang.org/SnapATAC2/algorithms/dimension_reduction.html#spectral-embedding

[Fang_2021]: Fang, R., Preissl, S., Li, Y. et al. Comprehensive analysis of single cell ATAC-seq data with SnapATAC. Nat Commun 12, 1337 (2021). https://doi.org/10.1038/s41467-021-21583-9

The dimension reduction method is a pairwise-similarity based method, which requires defining and computing
similarity between each pair of cells in the data.

In order to address the issue of high dimensionality in scATAC-seq data, we integrated SnapATAC2 into our workflow. SnapATAC2 utilizes spectral embedding techniques based on the work of Zhang et al. (2021) and Fang et al. (2021). We combined the reference and query data, creating a unified peak-by-cell matrix. SnapATAC2 transformed the count matrix into a cell-cell similarity matrix using the Jaccard Similarity Score, which measures the similarity between cells based on the ratio of their intersection and union. To mitigate sequencing depth bias, the Jaccard similarity matrix was normalized. The normalized matrix was then subjected to eigenvector decomposition to obtain low-dimensional components. To handle the computational complexity of high-dimensional data, SnapATAC2 first sampled "landmark" cells that capture the overall data distribution, and obtained the low-dimensional components for these informative cells. Finally, the remaining cells were projected into the same low-dimensional space, allowing us to obtain low-dimensional components for all cells in the dataset.


Cell-type Assignment
=====================

K-Nearest Neighorbors
---------------------
In the initial cell-type assignment, each query cell is assigned a cell label using its closest K-nearest neighbors (KNN) in the reference atlas, based on the low dimensional embeddings.

To evaluate the confidence of the KNN assignment, we employ two distinct uncertainty score metrics. The first metric is the KNN-based uncertainty score. This score is calculated by considering the closest neighbors of a query cell in the reference atlas. Query cells that have predominantly nearest neighbors belonging to a single cell type are assigned low uncertainty scores, while those with neighbors consisting of a mixture of cell types receive higher uncertainty scores.

The second metric is a novel computation of a weighted distance-based uncertainty score. This approach is based on the concept that query cells located far from the centroid of their assigned cell type represent an unknown population. The computation involves three steps. First, we identify centroids of reference cell types based on low-dimensional components. Second, we assign different weights to the components for each cell type, considering the closeness of reference cells to their respective cell type's centroid along each dimension.
