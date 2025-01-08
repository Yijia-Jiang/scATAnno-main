library(Seurat)
library(tidyverse)
library(rhdf5)
library(HDF5Array)


outputpath <- "benchmark_scJoin"

genes_atac <- readRDS("pbmc_bigquery_atac_genescore_perfect.rds")

#' This function will generate h5 files for a list expression matrices as input of process_db.py file
#'
#' @param exprs_list a list of expression matrices
#' @param h5file_list a vector indictates the the h5 file names to output, corresponding to the expression matrix

write_h5_scJoint <- function(exprs_list, h5file_list) {

  if (length(unique(lapply(exprs_list, rownames))) != 1) {
    stop("rownames of exprs_list are not identical.")
  }

  for (i in seq_along(exprs_list)) {
    if (file.exists(h5file_list[i])) {
      warning("h5file exists! will rewrite it.")
      system(paste("rm", h5file_list[i]))
    }

    h5createFile(h5file_list[i])
    h5createGroup(h5file_list[i], "matrix")
    writeHDF5Array(t((exprs_list[[i]])), h5file_list[i], name = "matrix/data")
    h5write(rownames(exprs_list[[i]]), h5file_list[i], name = "matrix/features")
    h5write(colnames(exprs_list[[i]]), h5file_list[i], name = "matrix/barcodes")
    print(h5ls(h5file_list[i]))

  }


}

#' This function will generate csv files for a list of cell types as input of process_db.py file
#'
#' @param cellType_list a list of cell types
#' @param csv_list a vector indictates the the csv file names to output, corresponding to the cell type list

write_csv_scJoint <- function(cellType_list, csv_list) {

  for (i in seq_along(cellType_list)) {

    if (file.exists(csv_list[i])) {
      warning("csv_list exists! will rewrite it.")
      system(paste("rm", csv_list[i]))
    }

    names(cellType_list[[i]]) <- NULL
    write.csv(cellType_list[[i]], file = csv_list[i])

  }
}




#Following is reference never need to change!

target_mat <- ReadMtx(file.path("gene_activity_score_ArchR/ArchR_genescore.mtx.gz"),
                      cells = file.path("gene_activity_score_ArchR/ArchR_genescore_barcodes.tsv"),
                      features = file.path("gene_activity_score_ArchR/ArchR_genescore_genes.tsv"), feature.column =1)

df <- read.csv(file.path(rna_dir,"ref_meta_major.csv"))
rownames(df) <- df$X
unique(df$celltype)
df <- df %>% filter(celltype != "nan")
unique(df$celltype)

target_mat_clean <- target_mat[, rownames(df)]
head(target_mat_clean)
genesrna <- rownames(target_mat_clean)



print("reference genes")
length(genesrna)

genesatac <- rownames(genes_atac)
print("query genes")
length(genesatac)

common <- Reduce(intersect,list(genesrna,genesatac))
print("common genes")
length(common)

##### write files


setwd(outputpath)


##### write files
target_mat_clean2 <- target_mat_clean[common, ]
print("reference cells")
ncol(target_mat_clean2)
#pbmc_rna <- CreateSeuratObject(counts = target_mat_clean2, project = "pbmc", min.cells = 0, min.features = 0)
#pbmc_rna <- AddMetaData(pbmc_rna, df)


target_mat_atac <- genes_atac[common, ]
print("query cells")
ncol(target_mat_atac)
#pbmc_atac <- CreateSeuratObject(counts = target_mat_atac, project = "pbmc", min.cells = 0, min.features = 0)
#pbmc_atac
#saveRDS(pbmc_atac, file.path(atac_dir, "1.pbmc_atac_genescore.rds"))

write_h5_scJoint(exprs_list = list(rna = target_mat_clean2), 
                 h5file_list = c("1.exprs_4repPBMC_rna.h5"
                 ))

write_csv_scJoint(cellType_list =  list(rna = df$celltype),
                  csv_list = "1.cellType_PBMC_rna.csv")

write_h5_scJoint(exprs_list = list(atac = target_mat_atac), 
                 h5file_list = c("1.exprs_PBMC_facs_query.h5"
                 ))










