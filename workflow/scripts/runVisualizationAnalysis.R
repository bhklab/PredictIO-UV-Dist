# -----------------------------------------------------------
# Visualization Script
#
# Description:
# This script performs some visualization functions.
#
# -----------------------------------------------------------
#############################################################
# Load libraries
#############################################################
library(PredictioR)
library(circlize)
library(ComplexHeatmap)
library(dplyr)
library(data.table)
library(forestplot)
library(Hmisc)

###########################################################
## Set up working directory and study configuration
###########################################################

dir <- "/data/results/central"

################################################################
## Heatmap: pan-cancer analysis
################################################################ 

load(file.path(getwd(), dir, "meta_pan_os.RData"))
os <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]
genes <- unique(os$Gene)
os <- os[os$FDR < 0.05 | os$Pval < 0.05, ]

load(file.path(getwd(), dir_out, "meta_pan_pfs.RData"))
pfs <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]
genes <- unique(pfs$Gene)
pfs <- pfs[pfs$FDR < 0.05 | pfs$Pval < 0.05, ]

load(file.path(getwd(), dir_out, "meta_pan_logreg.RData"))
logreg <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]
genes <- unique(logreg$Gene)
logreg <- logreg[logreg$FDR < 0.05 | logreg$Pval < 0.05, ]

int <- union(union(pfs$Gene, logreg$Gene), os$Gene)

os_mod <- lapply(1:length(int), function(k){
  
  if( sum(os$Gene %in% int[k])>0 ){  res <- os[os$Gene %in% int[k],] }else{
    
    res <-data.frame(Gene = int[k],
                     Coef = NA,
                     SE =NA,
                     CI_lower = NA,
                     CI_upper = NA,
                     Pval = NA,
                     I2 = NA,
                     Q_Pval = NA,
                     FDR = NA)
  }
  
  res
})

os <- do.call(rbind, os_mod)
os <- os[order(os$Gene), ]

pfs_mod <- lapply(1:length(int), function(k){
  
  if( sum(pfs$Gene %in% int[k])>0 ){  res <- pfs[pfs$Gene %in% int[k], ] }else{
    
    res <-data.frame(Gene = int[k],
                     Coef = NA,
                     SE =NA,
                     CI_lower = NA,
                     CI_upper = NA,
                     Pval = NA,
                     I2 = NA,
                     Q_Pval = NA,
                     FDR = NA)
  }
  
  res
})

pfs <- do.call(rbind, pfs_mod)
pfs <- pfs[order(pfs$Gene), ]

logreg_mod <- lapply(1:length(int), function(k){
  
  if( sum(logreg$Gene %in% int[k])>0 ){  res <- logreg[logreg$Gene %in% int[k],] }else{
    
    res <-data.frame(Gene = int[k],
                     Coef = NA,
                     SE =NA,
                     CI_lower = NA,
                     CI_upper = NA,
                     Pval = NA,
                     I2 = NA,
                     Q_Pval = NA,
                     FDR = NA)
  }
  
  res
})

logreg <- do.call(rbind, logreg_mod)
logreg <- logreg[order(logreg$Gene), ]

data = cbind( logreg$Coef, pfs$Coef, os$Coef)
rownames(data) = logreg$Gene
colnames(data) = c( "Response" , "PFS", "OS" )

pval = cbind( logreg$Pval , pfs$Pval, os$Pval )
rownames(pval) = logreg$Gene
colnames(pval) = c( "Response" , "PFS", "OS" )
pval[ is.na(pval) ] = 1

padj = cbind( logreg$FDR , pfs$FDR, os$FDR )
rownames(padj) = logreg$Gene
colnames(padj) = c( "Response" , "PFS", "OS" )
padj[ is.na(padj) ] = 1

annot_col = data.frame(
  OS_Sig = factor( ifelse( round( padj[ , 'OS' ] , 2 ) <= .05 , 'FDR' , ifelse( round( pval[ , "OS" ] , 2 ) <= 0.05 , "Pvalue" ,  'NS' ) ) ) ,  
  PFS_Sig = factor( ifelse( round( padj[ , 'PFS' ] , 2 ) <= .05 , 'FDR' , ifelse( round( pval[ , "PFS" ] , 2 ) <= 0.05 , "Pvalue" , 'NS' ) ) ) ,
  Response_Sig = factor( ifelse( round( padj[ , 'Response' ] , 2 ) <= .05 , 'FDR' , ifelse( round( pval[ , "Response" ] , 2 ) <= 0.05 , "Pvalue" , 'NS' ) ) )
)

rownames(annot_col) = rownames(data)
new_order <- c("FDR", "Pvalue", "NS")
annot_col$OS_Sig <- factor(annot_col$OS_Sig, levels = new_order)
annot_col$PFS_Sig <- factor(annot_col$PFS_Sig, levels = new_order)
annot_col$Response_Sig <- factor(annot_col$Response_Sig, levels = new_order)

ann_colors = list(
  Response_Sig = c( FDR = "#4A7169FF", Pvalue = "#9AA582FF", NS = "#d9d9d9" ) , 
  PFS_Sig = c( FDR = "#4A7169FF", Pvalue = "#9AA582FF", NS = "#d9d9d9" ),
  OS_Sig = c( FDR = "#4A7169FF", Pvalue = "#9AA582FF", NS = "#d9d9d9" ) )

neg = seq( round( min( data , na.rm=TRUE ) , 1 ) , 0 , by=.05 )
neg = neg[ -length(neg)]
pos = seq( 0 , round( max( data , na.rm=TRUE ) , 1 ) , by=.05 )

col = c( colorRampPalette( c("#2166AC", "#4393C3", "#92C5DE", "#D1E5F0") )( length(neg) ) ,
         colorRampPalette( c("#F7F7F7","#FDDBC7", "#F4A582","#D6604D", "#B2182B") )( length(pos) ))

colnames(annot_col) <- c("OS sig", "PFS sig", "Response sig")
names(ann_colors) <- c("Response sig", "PFS sig", "OS sig")  

jpeg(file = file.path(getwd(), dir_out, "Heatmap_pan.jpeg"), width = 1500, height = 550, res = 150)

df <- t( data[ order( rowSums(data)) , ] )
hmap <- pheatmap( df, cluster_rows=FALSE , cluster_cols=FALSE , 
                  scale="none" , annotation_col = annot_col, annotation_colors = ann_colors, 
                  col = col , breaks = c( neg, pos ) , name= "Coef",
                  na_col="#d9d9d9" , border_color="#424242",
                  number_color="black" , show_colnames = T, show_rownames = T,
                  fontsize_col = 6, fontsize_row = 5, fontsize = 5, 
                  fontsize_number = 5, cellwidth = 6, cellheight = 8, 
                  legend = TRUE, annotation_legend = TRUE )

draw(hmap, heatmap_legend_side = "right", annotation_legend_side = "right" )

dev.off()

################################################################
## forestplot plot: IRG_Ayres pan-cancer (OS) 
################################################################

load(file.path(getwd(), dir_out, "res.os.RData"))
df <- res.os[res.os$Gene == "IRG_Ayers", ]
study <- sapply(1:nrow(df), function(k){
  
  substr(df$Study[k], 5, nchar(df$Study[k]))
  
})
  
jpeg(file=file.path(getwd(), dir_out, "IRG_Ayers_os_pan.jpeg"), width = 1200, height = 900, res = 150)

forestPlot(coef = df$Coef,
           se = df$SE,
           study  = study,
           pval = df$Pval,
           n = df$N,
           cancer.type = do.call(rbind, strsplit(df$Study, split='__', fixed=TRUE))[, 2],
           treatment = do.call(rbind, strsplit(df$Study, split='__', fixed=TRUE))[, 3],
           feature = unique(df$Gene),
           xlab = "logHR estimate",
           label = "logHR")

dev.off()


