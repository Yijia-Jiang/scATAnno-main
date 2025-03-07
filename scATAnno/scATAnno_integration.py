from scATAnno.SnapATAC2_spectral import *
from scATAnno.SnapATAC2_tools import *
from anndata._core.aligned_mapping import AxisArrays
from anndata.experimental import AnnCollection
import harmonypy
import scanpy as sc
import pandas as pd
import numpy as np
import os
import anndata as ad
import pickle
def scATAnno_query_projection(reference_data, query_data, feature_file, model_file):

    if not all(reference_data.var_names == query_data.var_names):
        raise ValueError("Reference and query data must have identical feature names in the same order")
    

    datasets={}
    datasets["Atlas"] = reference_data
    datasets["query"] = query_data
    # Lazily concatenate AnnData objects along the obs axis
    data_c = AnnCollection(datasets,join_obs="inner", index_unique="_", label="dataset")
    data_c.var = pd.DataFrame()
    data_c._obsm = AxisArrays(data_c, axis=0)
    data_c._view_attrs_keys.pop("obsm", None)
    data_c.uns = {}
    X = data_c[:].X

    #features = np.loadtxt(f'/home/yj976/scATAnno_benchmark/benchmark_scATAnno/model/selected_features_full_{ablate_type}.csv', delimiter=',').astype(bool)
    features = np.loadtxt(feature_file, delimiter=',').astype(bool)
    #with open(f'/home/yj976/scATAnno_benchmark/benchmark_scATAnno/model/model_test_full_{ablate_type}', 'rb') as f:
    with open(model_file , 'rb') as f:
        model = pickle.load(f)

    # Process X
    S = data_c[:].X[:, features]
    S = S[data_c.obs['dataset'] != 'Atlas']
    S.data = np.ones(S.indices.shape, dtype=np.float64)

    # Get spectral result
    print("Perform Nystrom extension on the query data")
    model.extend(S)
    result = model.transform()

    # Store results in data_c
    data_c.uns['spectral_eigenvalue'] = result[0]
    data_c.obsm['X_spectral'] = result[1]
    data_c.var.index = datasets["Atlas"].var.index.values
    #data_c = data_c.to_adata()

    data_c = data_c.to_adata()
    data_c.X = X

    return data_c

def scATAnno_integrate_reference_embedding(reference_data, feature_file, model_file, variable_prefix, dim = 30, sample_size = 10000, distance_metric = "jaccard",feature_threshold = 1.65,ablate_type = 'none'):
    #print (f"critical_value in scATAnno_integrate{feature_threshold}")
    """
    Integrate a reference atlas and a query AnnData 
    
    Parameters
    ----------
    reference_data
        Reference AnnData
    query_data
        Query AnnData
    variable_prefix
        Prefix of query data
    batch_correction
        Whether to apply harmony or not: "harmony" or None
    dim
        Number of dimensionality for downstream analysis
    sample_size
        Number of "landmark" reference cells for projection
    distance_metric
        Methods of constructing cell-cell similarity matrix: "jaccard" or "cosine"    
    Returns integrated AnnData
    -------
    """
    if isinstance(reference_data, ad.AnnData): #& isinstance(query_data, ad.AnnData):
        reference_size = reference_data.shape[0]
        #select_features(query_data, critical_value = critical_value) 
        #print(f"critical value in integrate is{critical_value}")
        select_features_reference_only(feature_file, reference_data, feature_threshold= feature_threshold , ablate_type = ablate_type)
        datasets={}
        datasets["Atlas"] = reference_data
        #datasets[variable_prefix] = query_data
        #datasets["Atlas"] = reference_data
        # Lazily concatenate AnnData objects along the obs axis
        data_c = AnnCollection(datasets,join_obs="inner", index_unique="_", label="dataset") # concatenate two adata by intersection of var 
        data_c.var = pd.DataFrame()
        data_c._obsm = AxisArrays(data_c, axis=0) 
        data_c._view_attrs_keys.pop("obsm", None)
        data_c.uns = {}
        # add peak matrix to data_c
        X = data_c[:].X 
        #select_features(data_c,critical_value = critical_value)
        data_c.var["selected"] = reference_data.var["selected"] 
        if isinstance(sample_size, int):
            spectral_reference_embedding(model_file, data_c, sample_size = sample_size, distance_metric = distance_metric,ablate_type=ablate_type,reference_size=reference_size) # default spectral component = 50
        else:
            spectral_reference_embedding(model_file, data_c, distance_metric = distance_metric,ablate_type=ablate_type,reference_size=reference_size)

    else: raise ValueError("Integration inputs are not anndata")


def scATAnno_integrate(reference_data, query_data, variable_prefix, dim = 30, sample_size = 10000, distance_metric = "jaccard", feature_threshold = 1.65):
    """
    Integrate a reference atlas and a query AnnData 
    
    Parameters
    ----------
    reference_data
        Reference AnnData
    query_data
        Query AnnData
    variable_prefix
        Prefix of query data
    batch_correction
        Whether to apply harmony or not: "harmony" or None
    dim
        Number of dimensionality for downstream analysis
    sample_size
        Number of "landmark" reference cells for projection
    distance_metric
        Methods of constructing cell-cell similarity matrix: "jaccard" or "cosine"    
    Returns integrated AnnData
    -------
    """
    if isinstance(reference_data, ad.AnnData) & isinstance(query_data, ad.AnnData):
        select_features(query_data, feature_threshold= feature_threshold) 
        select_features(reference_data, feature_threshold = feature_threshold)
        datasets={}
        datasets[variable_prefix] = query_data
        datasets["Atlas"] = reference_data
        # Lazily concatenate AnnData objects along the obs axis
        data_c = AnnCollection(datasets,join_obs="inner", index_unique="_", label="dataset") # concatenate two adata by intersection of var 
        data_c.var = pd.DataFrame()
        data_c._obsm = AxisArrays(data_c, axis=0) 
        data_c._view_attrs_keys.pop("obsm", None)
        data_c.uns = {}
        # add peak matrix to data_c
        X = data_c[:].X 
        select_features(data_c, feature_threshold = feature_threshold)
        if isinstance(sample_size, int):
            spectral(data_c, sample_size = sample_size, distance_metric = distance_metric) # default spectral component = 50
        else:
            spectral(data_c, distance_metric = distance_metric)
        data_c.var.index = reference_data.var.index.values
        data_c = data_c.to_adata()
        data_c.X = X
        return(data_c)
    else: raise ValueError("Integration inputs are not anndata")

def scATAnno_integrate_multiple(datasets, batch_correction = "harmony", dim = 30, sample_size = 10000, distance_metric = "jaccard"):
    """
    Integrate a reference atlas with multiple query AnnDatas
    
    Parameters
    ----------
    datasets
        Dictionary object of reference and query datasets
    batch_correction
        Whether to apply harmony or not: "harmony" or None
    dim
        Number of dimensionality for downstream analysis
    sample_size
        Number of "landmark" reference cells for projection
    distance_metric
        Methods of constructing cell-cell similarity matrix: "jaccard" or "cosine"    
    Returns integrated AnnData
    -------
    """
    if isinstance(datasets, dict):
        # Lazily concatenate AnnData objects along the obs axis
        data_c = AnnCollection(datasets,join_obs="inner", index_unique="_", label="dataset") # concatenate two adata by intersection of var 
        data_c.var = pd.DataFrame()
        data_c._obsm = AxisArrays(data_c, axis=0) 
        data_c._view_attrs_keys.pop("obsm", None)
        data_c.uns = {}
        X = data_c[:].X # add peak matrix to data_c
        select_features(data_c)
        if isinstance(sample_size, int):
            spectral(data_c, sample_size = sample_size, distance_metric = distance_metric) # default spectral component = 50
        else:
            spectral(data_c, distance_metric = distance_metric)
        data_c.var.index = datasets["Atlas"].var.index.values
        data_c = data_c.to_adata()
        data_c.X = X

        # if batch_correction == "harmony":
        #     print("Batch correction using harmony")
        #     harmony(data_c, "dataset",use_dims = dim, max_iter_harmony = 20)
        return(data_c)
    else: raise ValueError("Integration input is not dictionary of datasets")

def scATAnno_harmony(adata, batch_col = "dataset", use_dims = 30, max_iter_harmony = 20):
    """
    Remove Batch effects
    """
    adata = adata.copy()
    harmony(adata, batch=batch_col,use_dims = use_dims, max_iter_harmony = max_iter_harmony)
    return adata

def umap(
    adata: AnnData,
    n_comps: int = 2,
    use_dims: Optional[Union[int, List[int]]] = None,
    use_rep: Optional[str] = None,
    key_added: str = 'umap',
    random_state: int = 0,
    inplace: bool = True,
) -> Optional[np.ndarray]:
    """
    Parameters
    ----------
    data
        AnnData.
    n_comps
        The number of dimensions of the embedding.
    use_dims
        Use these dimensions in `use_rep`.
    use_rep
        Use the indicated representation in `.obsm`.
    key_added
        `adata.obs` key under which to add the cluster labels.
    random_state
        Random seed.
    inplace
        Whether to store the result in the anndata object.

    Returns
    -------
    None
    """
    from umap import UMAP

    if use_rep is None: use_rep = "X_spectral"
    if use_dims is None:
        data = adata.obsm[use_rep]
    elif isinstance(use_dims, int):
        data = adata.obsm[use_rep][:, :use_dims]
    else:
        data = adata.obsm[use_rep][:, use_dims]
    # newly added
    data = np.asarray(data)
    umap = UMAP(
        random_state=random_state, n_components=n_comps
        ).fit_transform(data)
    if inplace:
        adata.obsm["X_" + key_added] = umap
    else:
        return umap


def scATAnno_umap(integrated_adata, out_dir, use_rep = "X_spectral_harmony", save = True, filename='1.Merged_query_reference.h5ad'):
    """
    Plot UMAP for integrated scATAC-seq data
    Parameters
    ----------
    integrated_adata
        AnnData.
    out_dir
        Directory to save adata
    use_rep
        Use the indicated representation in `.obsm`.
    save
        Whether to save the anndata object and spectral embeddings
    filename: the filename of stored anndata object and spectral embeddings

    Returns
    -------
    None
    """
    if use_rep in integrated_adata.obsm:
        umap(integrated_adata, use_rep=use_rep)
    else: raise ValueError("Missing low dimensionality")
    # Save AnnData object
    if save == True:
        tmp_adata = integrated_adata.copy()
        if 'X_spectral' in tmp_adata.obsm: 
            tmp = pd.DataFrame(tmp_adata.obsm['X_spectral'])
            tmp.index= tmp_adata.obs.index
            tmp.to_csv(os.path.join(out_dir,'X_spectral.csv'))
            del tmp_adata.obsm['X_spectral']
        if 'X_spectral_harmony' in tmp_adata.obsm: 
            tmp = pd.DataFrame(tmp_adata.obsm['X_spectral_harmony'])
            tmp.index= tmp_adata.obs.index
            tmp.to_csv(os.path.join(out_dir,'X_spectral_harmony.csv'))
            del tmp_adata.obsm['X_spectral_harmony']
        tmp_adata.write(os.path.join(out_dir,filename))
    return(integrated_adata)



