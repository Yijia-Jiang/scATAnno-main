from scJoint import process_db
import h5py
import pandas as pd
import numpy as np
from sklearn.manifold import TSNE
import matplotlib.pyplot as plt
import seaborn as sns
import random
random.seed(1)

rna_h5_files = ["scATAnno_benchmark/benchmark_scJoin/8.results_big_pbmc_query1k/1.exprs_4repPBMC_rna.h5"]
rna_label_files = ["scATAnno_benchmark/benchmark_scJoin/8.results_big_pbmc_query1k/1.cellType_PBMC_rna.csv"] # csv file

atac_h5_files = ["scATAnno_benchmark/benchmark_scJoin/8.results_big_pbmc_query1k/1.exprs_PBMC_facs_query.h5"]
atac_label_files = []

process_db.data_parsing(rna_h5_files, atac_h5_files)

rna_label = pd.read_csv(rna_label_files[0], index_col = 0)
rna_label
print(rna_label.value_counts(sort = False))
process_db.label_parsing(rna_label_files, atac_label_files)

