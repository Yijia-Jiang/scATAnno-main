import gc
import sys
import importlib
import random
import scanpy as sc
import pandas as pd
from scipy.sparse import csr_matrix
from scipy import sparse
import scipy.io
import os
import anndata as ad # Anndata version must > 0.8
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import warnings
import scipy.sparse as sp
warnings.simplefilter(action='ignore', category=FutureWarning)
warnings.simplefilter(action='ignore', category=DeprecationWarning)
import argparse

import scanorama
# Set up argument parser
parser = argparse.ArgumentParser(description='Generate batch-corrected reference data')
parser.add_argument('--countMatrixLocation1', help="Path to first count matrix file (h5ad)")
parser.add_argument('--countMatrixLocation2', help="Path to second count matrix file (h5ad)")
parser.add_argument('--outputreference', help="Path to save the batch-corrected output file (h5ad)")
args = parser.parse_args()

# Set theme for plotting
sns.set_theme(style='white')

# Add necessary paths

import scATAnno
from scATAnno.SnapATAC2_spectral import *
from scATAnno.SnapATAC2_tools import *
from scATAnno.SnapATAC2_utils import *
from scATAnno import scATAnno_preprocess
from scATAnno import scATAnno_assignment
from scATAnno import scATAnno_integration
from scATAnno import scATAnno_plotting

# Get color palettes
default_28 = scATAnno_plotting.get_palettes("default28")
default_102 = scATAnno_plotting.get_palettes("default102")

# Import scanorama for batch correction
import scanorama

# Load the first count matrix
input1 = scATAnno_preprocess.load_reference_data(args.countMatrixLocation1)

# Load the second count matrix
input2 = scATAnno_preprocess.load_reference_data(args.countMatrixLocation2)

# Create copies for processing
input1_new = input1.copy()
input2_new = input2.copy()

# Combine datasets
adatas = [input1_new, input2_new]

# Perform batch correction with scanorama
corrected = scanorama.correct_scanpy(adatas)

# Combine the corrected matrices
combined_X = sparse.vstack([adata.X for adata in corrected])

# Combine metadata
combined_obs = pd.concat([adata.obs for adata in corrected], axis=0)

# Create a new combined AnnData object
combined_adata = ad.AnnData(X=combined_X, 
                           obs=combined_obs,
                           var=corrected[0].var.copy())

# Copy the unstructured data
combined_adata.uns = corrected[0].uns.copy()

# Save the combined data to output file
combined_adata.write_h5ad(args.outputreference)
