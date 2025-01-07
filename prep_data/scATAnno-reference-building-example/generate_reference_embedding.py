import sys
#sys.path.append('/home/yj976/scATAnno_benchmark/jan7_scATAnno_todelet/scATAnno-main')
import argparse
import snapatac2 as snap
import numpy as np
import polars as pl
import pandas as pd
import os
import snapatac2 as snap
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
sns.set_theme(style='white')

import scATAnno
from scATAnno.SnapATAC2_spectral import *
from scATAnno.SnapATAC2_tools import *
from scATAnno.SnapATAC2_utils import *
from scATAnno import scATAnno_preprocess
from scATAnno import scATAnno_assignment
from scATAnno import scATAnno_integration
from scATAnno import scATAnno_plotting

import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)
warnings.simplefilter(action='ignore', category=DeprecationWarning)



default_28 = scATAnno_plotting.get_palettes("default28")
default_102 = scATAnno_plotting.get_palettes("default102")



parser = argparse.ArgumentParser()
parser.add_argument('--countMatrixLocation', help="path location")
args = parser.parse_args()
path = args.countMatrixLocation

reference_data_path = path + "/Reference_Built.h5ad"
reference_data = scATAnno_preprocess.load_reference_data(reference_data_path)

feature_file = path + "/reference_features.csv"
model_file = path + "/reference_embedding_spectral_model.model"

scATAnno_assignment.scATAnno_integrate_reference_embedding(reference_data=reference_data,  
    feature_file=feature_file, 
    model_file=model_file, 
    variable_prefix="query", 
    feature_threshold=1.65)
