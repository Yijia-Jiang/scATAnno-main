library(tidyverse)
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

### refined label

blueEncode.refine <- SingleR(test=data, assay.type.test=1,
                             ref=blueprintEncode.ref, labels=blueprintEncode.ref$label.fine)
hpca.refine <- SingleR(test=data, assay.type.test=1,
                       ref=hpca.ref, labels=hpca.ref$label.fine)


hpca.refine_anno <- as.data.frame(hpca.refine) %>% select(labels)
colnames(hpca.refine_anno) <- "hpca_label_refine"
df1 <- hpca.main_anno
df1$Barcode <- rownames(df1)
df1 <- df1 %>% select("Barcode", "hpca_label_main")
#write.csv(df1, paste0( "./SingleR_hpca_main.csv"), row.names = F)
write.csv(df1, paste0( "SingleR_hpca_main_refine.csv"), row.names = F)

blueEncode.refine_anno <- as.data.frame(blueEncode.refine) %>% select(labels)
colnames(blueEncode.refine_anno) <- "encode_label_refine"
df1 <- encode_anno %>% select("encode_label")
df1$Barcode <- rownames(df1)
df1 <- df1 %>% select("Barcode", "encode_label")
#(df1, paste0( "./SingleR_encode_main.csv"), row.names = F)
write.csv(df1, paste0( "SingleR_encode_main_refine.csv"), row.names = F)




