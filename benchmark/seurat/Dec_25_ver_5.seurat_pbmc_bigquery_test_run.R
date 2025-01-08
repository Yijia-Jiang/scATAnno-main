library(Signac)
library(Seurat)
library(EnsDb.Hsapiens.v86)
library(Matrix)
#library(BSgenome.Hsapiens.UCSC.hg38)
set.seed(1234)

# https://satijalab.org/seurat/articles/integration_mapping.html


target_mat <- readRDS("pbmc_bigquery_atac_genescore_perfect.rds")
reference <- LoadH5Seurat("pbmc_multimodal.h5seurat")

############ Annotation ############
library(SeuratDisk)


pbmc <- CreateSeuratObject(
  counts = target_mat,
  project = "GeneActivity",
  min.cells = 3,    # Minimum number of cells expressing a gene
  min.features = 200 # Minimum number of features (genes) expressed per cell
)

DefaultAssay(pbmc) <- 'RNA'
pbmc <- pbmc[,unname(which(colSums(GetAssayData(pbmc))!=0))]
pbmc <- SCTransform(pbmc)
pbmc <- RunPCA(pbmc)




DefaultAssay(pbmc) <- 'SCT'
transfer_anchors <- FindTransferAnchors(
  reference = reference,
  query = pbmc,
  normalization.method = 'SCT',
  reference.reduction = "spca",
  recompute.residuals = FALSE,
  dims = 1:50
)

predictions <- TransferData(
  anchorset = transfer_anchors, 
  refdata = reference$celltype.l1,
  weight.reduction = pbmc[['pca']],
  dims = 1:50
)

df1 <- predictions["predicted.id"]
head(df1)
colnames(df1) <- c("seurat_celltype")

out_dir <- "benchmark_seurat"
write.csv(df1, file.path(out_dir, "seurat_celltype1k.csv"),quote = F)

