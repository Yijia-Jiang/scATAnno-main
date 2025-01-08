# Set output directory
output_dir <- "benchmark_signac"
# Create directory if it doesn't exist
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

library(Signac)
library(Seurat)
library(EnsDb.Hsapiens.v86)
library(BSgenome.Hsapiens.UCSC.hg38)
set.seed(1234)

# Input paths remain the same
mat_dir_input <- "/counts"
reference <- LoadH5Seurat("pbmc_multimodal.h5seurat")
#add drop box link
FragPath <- "fragments.tsv.gz"

# Process scATAC data
PBMC_10x_mat <- ReadMtx(
  file.path(mat_dir_input, "matrix.mtx.gz"),
  cells = file.path(mat_dir_input, "barcodes.tsv.gz"),
  features = file.path(mat_dir_input, "features.tsv.gz"),
  feature.column = 1
)
# Select 1000 cells
#PBMC_10x_mat <- PBMC_10x_mat[,1:1000]




genome = "hg38"

# Get annotations
annotations <- GetGRangesFromEnsDb(ensdb = EnsDb.Hsapiens.v86)
seqlevelsStyle(annotations) <- 'UCSC'
genome(annotations) <- genome


PBMC_10x_frags <- CreateFragmentObject(path = FragPath, cells = colnames(PBMC_10x_mat), max.lines = NULL)
PBMC_10x_assay <- CreateChromatinAssay(PBMC_10x_mat, fragments = PBMC_10x_frags, genome = genome, min.features = 0, sep = c(":", "-"))
pbmc <- CreateSeuratObject(PBMC_10x_assay, assay = "peaks")

# Compute LSI
pbmc <- FindTopFeatures(pbmc, min.cutoff = 10)
pbmc <- RunTFIDF(pbmc)
pbmc <- RunSVD(pbmc)

# Add gene information
Annotation(pbmc) <- annotations
gene.activities <- GeneActivity(pbmc)

# Save intermediate results to output directory
saveRDS(gene.activities, file.path(output_dir, "gene.activity.rds"))
saveRDS(pbmc, file.path(output_dir, "run_pbmc_raw.rds"))

# Annotation
library(SeuratDisk)


pbmc[['RNA']] <- CreateAssayObject(counts = gene.activities)
DefaultAssay(pbmc) <- 'RNA'
pbmc <- pbmc[, unname(which(colSums(GetAssayData(pbmc)) != 0))]
pbmc <- SCTransform(pbmc)
pbmc <- RunPCA(pbmc)

# Save processed object
saveRDS(pbmc, file.path(output_dir, "run_pbmc.rds"))

DefaultAssay(pbmc) <- 'SCT'
transfer_anchors <- FindTransferAnchors(
  reference = reference,
  query = pbmc,
  normalization.method = 'SCT',
  reference.reduction = "spca",
  recompute.residuals = FALSE,
  dims = 1:50
)

l1 <- TransferData(
  anchorset = transfer_anchors,
  refdata = reference$celltype.l1,
  weight.reduction = pbmc[['lsi']],
  dims = 2:30
)

df1 <- l1["predicted.id"]
# Save final predictions
write.csv(df1, file.path(output_dir, "signac_pred.csv"))
