#knitr::opts_chunk$set(echo = TRUE)
library(Signac)
library(Seurat)
library(EnsDb.Hsapiens.v86)
set.seed(1234)
# add the gene activity matrix to the Seurat object as a new assay and normalize it

library(SingleR)
blueprintEncode.ref <- BlueprintEncodeData()
#get reference atlas
hpca.ref <- HumanPrimaryCellAtlasData()

data <- readRDS("pbmc_bigquery_atac_genescore_perfect.rds")

data <- as(data, Class = "dgCMatrix")


blueEncode.pred <- SingleR(test=data, assay.type.test=1,
                           ref=blueprintEncode.ref, labels=blueprintEncode.ref$label.main)
hpca.main <- SingleR(test=data, assay.type.test=1,
                     ref=hpca.ref, labels=hpca.ref$label.main)

library(tidyverse)
hpca.main_anno <- as.data.frame(hpca.main) %>% select(labels)
colnames(hpca.main_anno) <- "hpca_label_main"
df1 <- hpca.main_anno
df1$Barcode <- rownames(df1)
df1 <- df1 %>% select("Barcode", "hpca_label_main")
write.csv(df1, paste0( "/home/yj976/scATAnno_benchmark/benchmark_singleR/6.singleR_pbmc_big_query_result1k/SingleR_hpca_main1k.csv"), row.names = F)


encode_anno <- as.data.frame(blueEncode.pred) %>% select(labels)
colnames(encode_anno) <- "encode_label"
df1 <- encode_anno %>% select("encode_label")
df1$Barcode <- rownames(df1)
df1 <- df1 %>% select("Barcode", "encode_label")
write.csv(df1, paste0( "/home/yj976/scATAnno_benchmark/benchmark_singleR/6.singleR_pbmc_big_query_result1k/SingleR_encode_main1k.csv"), row.names = F)


### refined label

blueEncode.refine <- SingleR(test=data, assay.type.test=1,
                             ref=blueprintEncode.ref, labels=blueprintEncode.ref$label.fine)
hpca.refine <- SingleR(test=data, assay.type.test=1,
                       ref=hpca.ref, labels=hpca.ref$label.fine)

library(tidyverse)
hpca.refine_anno <- as.data.frame(hpca.refine) %>% select(labels)
colnames(hpca.refine_anno) <- "hpca_label_refine"
df1 <- hpca.main_anno
df1$Barcode <- rownames(df1)
df1 <- df1 %>% select("Barcode", "hpca_label_main")
#write.csv(df1, paste0( "./SingleR_hpca_main.csv"), row.names = F)
write.csv(df1, paste0( "/home/yj976/scATAnno_benchmark/benchmark_singleR/6.singleR_pbmc_big_query_result1k/SingleR_hpca_main_refine1k.csv"), row.names = F)

blueEncode.refine_anno <- as.data.frame(blueEncode.refine) %>% select(labels)
colnames(blueEncode.refine_anno) <- "encode_label_refine"
df1 <- encode_anno %>% select("encode_label")
df1$Barcode <- rownames(df1)
df1 <- df1 %>% select("Barcode", "encode_label")
#(df1, paste0( "./SingleR_encode_main.csv"), row.names = F)
write.csv(df1, paste0( "/home/yj976/scATAnno_benchmark/benchmark_singleR/6.singleR_pbmc_big_query_result1k/SingleR_encode_main_refine1k.csv"), row.names = F)




