import scanpy as sc
import pandas as pd
from scipy.sparse import csr_matrix
from scipy import sparse
import scipy.io
import os
import sys
import anndata as ad # Anndata version must > 0.8
import harmonypy
from adjustText import adjust_text
import numpy as np
import matplotlib.pyplot as plt
import time
from anndata._core.aligned_mapping import AxisArrays
from anndata.experimental import AnnCollection
import math
from scipy.spatial.distance import pdist, squareform
# KNN CLASSIFIER
from sklearn.neighbors import KNeighborsClassifier
from sklearn.neighbors import NearestNeighbors
from sklearn.preprocessing import LabelEncoder
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--countMatrixLocation', help="peak count matrix location")
parser.add_argument('--celllabel', help="path to cell label file")
args = parser.parse_args()
path = args.countMatrixLocation
cell_label_path = args.celllabel

def convert_mtx2anndata_quickATAC(path, mtx_file, cells_file, features_file, variable_prefix, major_col=True, minor_col=True, sep=(":", "-"), add_metrics=True, cell_label_path=None):
    # feature peak must be sep by (":","-")
    data = sc.read_mtx(os.path.join(path, mtx_file))
    data = data.T
    features = pd.read_csv(os.path.join(path, features_file), header=None, sep='\t')
    barcodes = pd.read_csv(os.path.join(path, cells_file), header=None)

    # Split feature matrix and set peak separated by (:, -) to match reference peaks
    data.var_names = features[0]
    data.obs_names = barcodes[0]

    if major_col == True:
        data.obs[major_col] = variable_prefix
    if minor_col == True:
        data.obs[minor_col] = variable_prefix
    if (major_col == False) and (minor_col == False):
        data.obs["cell type"] = variable_prefix

    data.obs['tissue'] = variable_prefix
    data.obs['dataset'] = variable_prefix

    # remove spike-in cell
    data = data[data.obs.index != "spike-in"]
    
    # add cell labels if provided
    if cell_label_path is not None:
        cell_labels = pd.read_csv(cell_label_path, index_col=0)
        data.obs = pd.merge(data.obs, cell_labels[['true_lable']], left_index=True, right_index=True, how='left')
    
    # add qc filtering metrics from quickATAC if add_metrics set to true
    if add_metrics == True:
        import glob
        try:
            metrics_filepath = glob.glob(os.path.join(path, "*meta*"))[0]
            metrics = pd.read_csv(metrics_filepath, sep='\t', index_col=0)
            metrics = metrics[metrics.index != "spike-in"]
            data.obs = pd.merge(data.obs, metrics, right_index=True, left_index=True)
        except OSError as error:
            import warnings
            warnings.warn('Metrics file not found, anndata returned with no meta metrics')
            return data
    return data


reference_atlas = convert_mtx2anndata_quickATAC(path, mtx_file="matrix.mtx.gz",
                              cells_file="barcodes.tsv", features_file="features.tsv", 
                              variable_prefix="Atlas", major_col=False, minor_col=False,
                              cell_label_path=cell_label_path)

reference_atlas.write(os.path.join(path, "Reference_Built.h5ad"))
