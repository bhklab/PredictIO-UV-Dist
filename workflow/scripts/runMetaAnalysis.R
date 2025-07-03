# libraries
library(PredictioR)
library(circlize)
library(ComplexHeatmap)
library(meta)
library(dplyr)
library(data.table)
library(forestplot)
library(MultiAssayExperiment)
library(Hmisc)
###########################################################
## set up directory
###########################################################

dir.out <- "/results"
dir.in <- "/data"

############################################
## load data
############################################
data.files <- list.files(dir.in)

## extract correlation data
cor_files <- data.files[grep("_pcor", data.files)]
dir <- file.path(dir.in, cor_files)

cor.files <- lapply(1:length(dir), function(k){
  
  load(file.path(dir[k]))
  cor.val
  
})

study.icb <- substr(cor_files, 1, nchar(cor_files) - 13)
names(cor.files) <- study.icb
save(cor.files, file = file.path(dir.out, "pCor_result.RData"))

## extract signature score data
score_files <- data.files[grep("_score", data.files)]
dir <- file.path(dir.in, score_files)

score.files <- lapply(1:length(dir), function(k){
  
  load(file.path(dir[k]))
  geneSig.score
  
})

study.icb <- substr(score_files, 1, nchar(score_files) - 14)
names(score.files) <- study.icb
save(score.files, file = file.path(dir.out, "sigScore_result.RData"))


## extract signature score association (OS) data
sig_files <- data.files[grep("_os", data.files)]
dir <- file.path(dir.in, sig_files)

res.os <- lapply(1:length(dir), function(k){
  
  load(file.path(dir[k]))
  res.os
  
})

res.os <- do.call(rbind, res.os)
res.os <- res.os[!is.na(res.os$Coef), ]
rownames(res.os) <- NULL
save(res.os, file = file.path(dir.out, "res.os.RData"))
write.csv(res.os, file = file.path(dir.out, "res.os.csv"), row.names=FALSE)

## extract signature score association (PFS) data
sig_files <- data.files[grep("_pfs", data.files)]
dir <- file.path(dir.in, sig_files)

res.pfs <- lapply(1:length(dir), function(k){
  
  load(file.path(dir[k]))
  res.pfs
  
})

res.pfs <- do.call(rbind, res.pfs)
res.pfs <- res.pfs[!is.na(res.pfs$Coef), ]
rownames(res.pfs) <- NULL
save(res.pfs, file = file.path(dir.out, "res.pfs.RData"))
write.csv(res.pfs, file = file.path(dir.out, "res.pfs.csv"), row.names = FALSE)

## extract signature score association (response) data
sig_files <- data.files[grep("_logreg", data.files)]
dir <- file.path(dir.in, sig_files)

res.logreg <- lapply(1:length(dir), function(k){
  
  load(file.path(dir[k]))
  res.logreg
  
})

res.logreg <- do.call(rbind, res.logreg)
res.logreg <- res.logreg[!is.na(res.logreg$Coef), ]
rownames(res.logreg) <- NULL
save(res.logreg, file = file.path(dir.out, "res.logreg.RData"))
write.csv(res.logreg, file = file.path(dir.out, "res.logreg.csv"), row.names = FALSE)

####################################################################
####################################################################
## Meta correlation
####################################################################
####################################################################
load(file.path(dir.out, "pCor_result.RData"))

cor <- lapply(1:length(cor.files), function(i){
  
  print(i)
  cor.val <- cor.files[[i]]
  study <- names(cor.val)[1]
  r <- cor.val[[1]]
  n <- cor.val[[2]]
  p <- cor.val[[3]]
  
  cor.res <- lapply(1:nrow(r), function(k){
    
    print(k)
    data.frame(study = study,
               geneSig1 = rownames(r)[k],
               geneSig2 = colnames(r),
               r = r[k, ],
               n = n[k, ],
               p = p[k, ])
    
  })
  
  cor.res <- do.call(rbind, cor.res)
  rownames(cor.res) <- NULL
  cor.res
  
})

pcor <- do.call(rbind, cor)
geneSig1 <- unique(pcor$geneSig1)

meta.cor <- lapply(1:length(geneSig1), function(i){
  
  print(i)
  df <- pcor[pcor$geneSig1 == geneSig1[i], ]
  geneSig2 <- unique(df$geneSig2)
  
  res <- lapply(1:length(geneSig2), function(j){
    
    print(j)
    sub.df <- df[df$geneSig2 == geneSig2[j], ]
    
    if(geneSig2[j] == geneSig1[i]){
      
      meta.res <- data.frame(geneSig1 = geneSig1[i],
                             geneSig2 = geneSig2[j],
                             r = 1,
                             se = NA,
                             pval = NA,
                             I2 = NA)
    }
    
    if(sum(!is.na(sub.df$p)) > 0 & nrow(sub.df) >= 3){
      
      fit <- metacor(sub.df$r, sub.df$n, sm = "zcor",
                     control=list(stepadj=0.5, maxiter=1000))
      meta.res <- data.frame(geneSig1 = geneSig1[i],
                             geneSig2 = geneSig2[j],
                             r = fit$TE.random,
                             se = fit$seTE.random,
                             pval = fit$pval.random,
                             I2 = fit$I2)
    }
    
    if(nrow(sub.df) < 3){
      
      meta.res <- data.frame(geneSig1 = geneSig1[i],
                             geneSig2 = geneSig2[j],
                             r = NA,
                             se = NA,
                             pval = NA,
                             I2 = NA)
      
      
    }
    
    meta.res
    
  })
  
  do.call(rbind, res)
})

meta.cor <- do.call(rbind, meta.cor)

## build meta-correlation matrix

meta.cor <- meta.cor[!is.na(meta.cor$r), ]
geneSig1 <- unique(meta.cor$geneSig1)
geneSig2 <- unique(meta.cor$geneSig1)

metaCor <- lapply(1:length(geneSig1), function(i){
  
  print(i)
  df <- meta.cor[meta.cor$geneSig1 == geneSig1[i], ]
  
  cor.res <- sapply(1:length(geneSig2), function(j){
    
    print(j)
    
    if(sum(df$geneSig2 == geneSig2[j]) > 0){
      r <- unique(df[df$geneSig2 == geneSig2[j], "r"])
      if(r > 1){ r <- 1 }
      if(r < (-1)){ r <- (-1)}
    }else{ r <- NA }
    
    r
    
  })
  
  cor.res
  
})

metaCor <- do.call(cbind, metaCor)
rownames(metaCor) <- geneSig1
colnames(metaCor) <- geneSig2

save(metaCor, file=file.path(dir.out, "metaCor_matrix.RData"))

################################################################################
################################################################################
## Association meta-analysis: pan-cancer and response
################################################################################
################################################################################
load(file.path(dir.out, "res.logreg.RData"))
df <- res.logreg
signature <- unique(df$Gene)

AllGeneSig_meta <- lapply(1:length(signature), function(j){
  
  print(j)
  res <- metafun(coef = df[df$Gene == signature[j], "Coef"],
                 se = df[df$Gene == signature[j], "SE"],
                 study  = df[df$Gene == signature[j], "Study"],
                 pval = df[df$Gene == signature[j], "Pval"],
                 n = df[df$Gene == signature[j], "N"],
                 cancer.type = df[df$Gene == signature[j], "Cancer_type"],
                 treatment = df[df$Gene == signature[j], "Treatment"],
                 cancer.spec = FALSE,
                 treatment.spec = FALSE,
                 feature = unique(df[df$Gene == signature[j], "Gene"]))
  
  res$meta_summery
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]
AllGeneSig_meta$FDR <- p.adjust(AllGeneSig_meta$Pval, method = "BH")
AllGeneSig_meta <- AllGeneSig_meta[order(AllGeneSig_meta$FDR), ]

write.csv(AllGeneSig_meta, file=file.path(dir.out, "meta_pan_logreg.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(dir.out, "meta_pan_logreg.RData"))

################################################################################
################################################################################
## Association meta-analysis: pan-cancer and OS
################################################################################
################################################################################
load(file.path(dir.out, "res.os.RData"))
df <- res.os
signature <- unique(df$Gene)

AllGeneSig_meta <- lapply(1:length(signature), function(j){
  
  print(j)
  res <- metafun(coef = df[df$Gene == signature[j], "Coef"],
                 se = df[df$Gene == signature[j], "SE"],
                 study  = df[df$Gene == signature[j], "Study"],
                 pval = df[df$Gene == signature[j], "Pval"],
                 n = df[df$Gene == signature[j], "N"],
                 cancer.type = df[df$Gene == signature[j], "Cancer_type"],
                 treatment = df[df$Gene == signature[j], "Treatment"],
                 cancer.spec = FALSE,
                 treatment.spec = FALSE,
                 feature = unique(df[df$Gene == signature[j], "Gene"]))
  
  res$meta_summery
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]
AllGeneSig_meta$FDR <- p.adjust(AllGeneSig_meta$Pval, method = "BH")
AllGeneSig_meta <- AllGeneSig_meta[order(AllGeneSig_meta$FDR), ]

write.csv(AllGeneSig_meta, file=file.path(dir.out, "meta_pan_os.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(dir.out, "meta_pan_os.RData"))

################################################################################
################################################################################
## Association meta-analysis: pan-cancer and PFS
################################################################################
################################################################################
load(file.path(dir.out, "res.pfs.RData"))
df <- res.pfs
signature <- unique(df$Gene)

AllGeneSig_meta <- lapply(1:length(signature), function(j){
  
  print(j)
  res <- metafun(coef = df[df$Gene == signature[j], "Coef"],
                 se = df[df$Gene == signature[j], "SE"],
                 study  = df[df$Gene == signature[j], "Study"],
                 pval = df[df$Gene == signature[j], "Pval"],
                 n = df[df$Gene == signature[j], "N"],
                 cancer.type = df[df$Gene == signature[j], "Cancer_type"],
                 treatment = df[df$Gene == signature[j], "Treatment"],
                 cancer.spec = FALSE,
                 treatment.spec = FALSE,
                 feature = unique(df[df$Gene == signature[j], "Gene"]))
  
  res$meta_summery
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]
AllGeneSig_meta$FDR <- p.adjust(AllGeneSig_meta$Pval, method = "BH")
AllGeneSig_meta <- AllGeneSig_meta[order(AllGeneSig_meta$FDR), ]

write.csv(AllGeneSig_meta, file=file.path(dir.out, "meta_pan_pfs.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(dir.out, "meta_pan_pfs.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-cancer and response
################################################################################
################################################################################
load(file.path(dir.out, "res.logreg.RData"))
df <- res.logreg
signature <- unique(df$Gene)

AllGeneSig_meta <- lapply(1:length(signature), function(j){
  
  print(j)
  
  sub_df <- df[df$Gene == signature[j], ]
  if( nrow(sub_df) >= 3){
    
    
    res <- metaPerCanfun(coef = df[df$Gene == signature[j], "Coef"],
                         se = df[df$Gene == signature[j], "SE"],
                         study  = df[df$Gene == signature[j], "Study"],
                         pval = df[df$Gene == signature[j], "Pval"],
                         n = df[df$Gene == signature[j], "N"],
                         cancer.type = df[df$Gene == signature[j], "Cancer_type"],
                         treatment = df[df$Gene == signature[j], "Treatment"],
                         cancer.spec = TRUE,
                         feature = unique(df[df$Gene == signature[j], "Gene"]))
    
    
    
    percan_res <- lapply(1:length(res), function(i){
      
      res[[i]]$meta_summery
      
    })
    
    percan_res <- do.call(rbind, percan_res)
    
    
  }else{
    
    percan_res <- data.frame(Cancer_type = "Not Applicable",
                             Gene = signature[j],
                             Coef = NA,
                             SE = NA,
                             CI_lower = NA,
                             CI_upper = NA,
                             Pval =  NA,
                             I2 = NA,
                             Q_Pval = NA)
    
  }
  
  percan_res
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]

# FDR adjustment

group <- unique(AllGeneSig_meta$Cancer_type)
AllGeneSig_meta <- lapply(1:length(group), function(k){
  
  sub_df <- AllGeneSig_meta[AllGeneSig_meta$Cancer_type == group[k], ]
  sub_df$FDR <- p.adjust(sub_df[sub_df$Cancer_type == group[k], "Pval"], method = "BH")
  sub_df
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[order(AllGeneSig_meta$FDR), ]

write.csv(AllGeneSig_meta, file=file.path(dir.out, "meta_perCan_logreg.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(dir.out, "meta_perCan_logreg.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-cancer and OS
################################################################################
################################################################################
load(file.path(dir.out, "res.os.RData"))
df <- res.os
signature <- unique(df$Gene)

AllGeneSig_meta <- lapply(1:length(signature), function(j){
  
  print(j)
  
  sub_df <- df[df$Gene == signature[j], ]
  if( nrow(sub_df) >= 3){
    
    
    res <- metaPerCanfun(coef = df[df$Gene == signature[j], "Coef"],
                         se = df[df$Gene == signature[j], "SE"],
                         study  = df[df$Gene == signature[j], "Study"],
                         pval = df[df$Gene == signature[j], "Pval"],
                         n = df[df$Gene == signature[j], "N"],
                         cancer.type = df[df$Gene == signature[j], "Cancer_type"],
                         treatment = df[df$Gene == signature[j], "Treatment"],
                         cancer.spec = TRUE,
                         feature = unique(df[df$Gene == signature[j], "Gene"]))
    
    
    
    percan_res <- lapply(1:length(res), function(i){
      
      res[[i]]$meta_summery
      
    })
    
    percan_res <- do.call(rbind, percan_res)
    
    
  }else{
    
    percan_res <- data.frame(Cancer_type = "Not Applicable",
                             Gene = signature[j],
                             Coef = NA,
                             SE = NA,
                             CI_lower = NA,
                             CI_upper = NA,
                             Pval =  NA,
                             I2 = NA,
                             Q_Pval = NA)
    
  }
  
  percan_res
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]

# FDR adjustment

group <- unique(AllGeneSig_meta$Cancer_type)
AllGeneSig_meta <- lapply(1:length(group), function(k){
  
  sub_df <- AllGeneSig_meta[AllGeneSig_meta$Cancer_type == group[k], ]
  sub_df$FDR <- p.adjust(sub_df[sub_df$Cancer_type == group[k], "Pval"], method = "BH")
  sub_df
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[order(AllGeneSig_meta$FDR), ]

write.csv(AllGeneSig_meta, file=file.path(dir.out, "meta_perCan_os.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(dir.out, "meta_perCan_os.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-cancer and PFS
################################################################################
################################################################################
load(file.path(dir.out, "res.pfs.RData"))
df <- res.pfs
signature <- unique(df$Gene)

AllGeneSig_meta <- lapply(1:length(signature), function(j){
  
  print(j)
  
  sub_df <- df[df$Gene == signature[j], ]
  if( nrow(sub_df) >= 3){
    
    
    res <- metaPerCanfun(coef = df[df$Gene == signature[j], "Coef"],
                         se = df[df$Gene == signature[j], "SE"],
                         study  = df[df$Gene == signature[j], "Study"],
                         pval = df[df$Gene == signature[j], "Pval"],
                         n = df[df$Gene == signature[j], "N"],
                         cancer.type = df[df$Gene == signature[j], "Cancer_type"],
                         treatment = df[df$Gene == signature[j], "Treatment"],
                         cancer.spec = TRUE,
                         feature = unique(df[df$Gene == signature[j], "Gene"]))
    
    
    
    percan_res <- lapply(1:length(res), function(i){
      
      res[[i]]$meta_summery
      
    })
    
    percan_res <- do.call(rbind, percan_res)
    
    
  }else{
    
    percan_res <- data.frame(Cancer_type = "Not Applicable",
                             Gene = signature[j],
                             Coef = NA,
                             SE = NA,
                             CI_lower = NA,
                             CI_upper = NA,
                             Pval =  NA,
                             I2 = NA,
                             Q_Pval = NA)
    
  }
  
  percan_res
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]

# FDR adjustment

group <- unique(AllGeneSig_meta$Cancer_type)
AllGeneSig_meta <- lapply(1:length(group), function(k){
  
  sub_df <- AllGeneSig_meta[AllGeneSig_meta$Cancer_type == group[k], ]
  sub_df$FDR <- p.adjust(sub_df[sub_df$Cancer_type == group[k], "Pval"], method = "BH")
  sub_df
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[order(AllGeneSig_meta$FDR), ]

write.csv(AllGeneSig_meta, file=file.path(dir.out, "meta_perCan_pfs.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(dir.out, "meta_perCan_pfs.RData"))


################################################################################
################################################################################
## Association meta-analysis: per-treatment and response
################################################################################
################################################################################
load(file.path(dir.out, "res.logreg.RData"))
df <- res.logreg
signature <- unique(df$Gene)

AllGeneSig_meta <- lapply(1:length(signature), function(j){
  
  print(j)
  
  sub_df <- df[df$Gene == signature[j], ]
  if( nrow(sub_df) >= 3){
    
    
res <- metaPerTreatmentfun(coef = df[df$Gene == signature[j], "Coef"],
                         se = df[df$Gene == signature[j], "SE"],
                         study  = df[df$Gene == signature[j], "Study"],
                         pval = df[df$Gene == signature[j], "Pval"],
                         n = df[df$Gene == signature[j], "N"],
                         cancer.type = df[df$Gene == signature[j], "Cancer_type"],
                         treatment = df[df$Gene == signature[j], "Treatment"],
                         treatment.spec = TRUE,
                         feature = unique(df[df$Gene == signature[j], "Gene"]))
    
    
    
    percan_res <- lapply(1:length(res), function(i){
      
      res[[i]]$meta_summery
      
    })
    
    percan_res <- do.call(rbind, percan_res)
    
    
  }else{
    
    percan_res <- data.frame(Treatment = "Not Applicable",
                             Gene = signature[j],
                             Coef = NA,
                             SE = NA,
                             CI_lower = NA,
                             CI_upper = NA,
                             Pval =  NA,
                             I2 = NA,
                             Q_Pval = NA)
    
  }
  
  percan_res
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]

# FDR adjustment

group <- unique(AllGeneSig_meta$Treatment)
AllGeneSig_meta <- lapply(1:length(group), function(k){
  
  sub_df <- AllGeneSig_meta[AllGeneSig_meta$Treatment == group[k], ]
  sub_df$FDR <- p.adjust(sub_df[sub_df$Treatment == group[k], "Pval"], method = "BH")
  sub_df
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[order(AllGeneSig_meta$FDR), ]

write.csv(AllGeneSig_meta, file=file.path(dir.out, "meta_perTreatment_logreg.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(dir.out, "meta_perTreatment_logreg.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-treatment and OS
################################################################################
################################################################################
load(file.path(dir.out, "res.os.RData"))
df <- res.os
signature <- unique(df$Gene)

AllGeneSig_meta <- lapply(1:length(signature), function(j){
  
  print(j)
  
  sub_df <- df[df$Gene == signature[j], ]
  if( nrow(sub_df) >= 3){
    
    
    res <- metaPerTreatmentfun(coef = df[df$Gene == signature[j], "Coef"],
                               se = df[df$Gene == signature[j], "SE"],
                               study  = df[df$Gene == signature[j], "Study"],
                               pval = df[df$Gene == signature[j], "Pval"],
                               n = df[df$Gene == signature[j], "N"],
                               cancer.type = df[df$Gene == signature[j], "Cancer_type"],
                               treatment = df[df$Gene == signature[j], "Treatment"],
                               treatment.spec = TRUE,
                               feature = unique(df[df$Gene == signature[j], "Gene"]))
    
    
    
    percan_res <- lapply(1:length(res), function(i){
      
      res[[i]]$meta_summery
      
    })
    
    percan_res <- do.call(rbind, percan_res)
    
    
  }else{
    
    percan_res <- data.frame(Treatment = "Not Applicable",
                             Gene = signature[j],
                             Coef = NA,
                             SE = NA,
                             CI_lower = NA,
                             CI_upper = NA,
                             Pval =  NA,
                             I2 = NA,
                             Q_Pval = NA)
    
  }
  
  percan_res
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]

# FDR adjustment

group <- unique(AllGeneSig_meta$Treatment)
AllGeneSig_meta <- lapply(1:length(group), function(k){
  
  sub_df <- AllGeneSig_meta[AllGeneSig_meta$Treatment == group[k], ]
  sub_df$FDR <- p.adjust(sub_df[sub_df$Treatment == group[k], "Pval"], method = "BH")
  sub_df
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[order(AllGeneSig_meta$FDR), ]

write.csv(AllGeneSig_meta, file=file.path(dir.out, "meta_perTreatment_os.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(dir.out, "meta_perTreatment_os.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-treatment and PFS
################################################################################
################################################################################
load(file.path(dir.out, "res.pfs.RData"))
df <- res.pfs
signature <- unique(df$Gene)

AllGeneSig_meta <- lapply(1:length(signature), function(j){
  
  print(j)
  
  sub_df <- df[df$Gene == signature[j], ]
  if( nrow(sub_df) >= 3){
    
    
    res <- metaPerTreatmentfun(coef = df[df$Gene == signature[j], "Coef"],
                               se = df[df$Gene == signature[j], "SE"],
                               study  = df[df$Gene == signature[j], "Study"],
                               pval = df[df$Gene == signature[j], "Pval"],
                               n = df[df$Gene == signature[j], "N"],
                               cancer.type = df[df$Gene == signature[j], "Cancer_type"],
                               treatment = df[df$Gene == signature[j], "Treatment"],
                               treatment.spec = TRUE,
                               feature = unique(df[df$Gene == signature[j], "Gene"]))
    
    
    
    percan_res <- lapply(1:length(res), function(i){
      
      res[[i]]$meta_summery
      
    })
    
    percan_res <- do.call(rbind, percan_res)
    
    
  }else{
    
    percan_res <- data.frame(Treatment = "Not Applicable",
                             Gene = signature[j],
                             Coef = NA,
                             SE = NA,
                             CI_lower = NA,
                             CI_upper = NA,
                             Pval =  NA,
                             I2 = NA,
                             Q_Pval = NA)
    
  }
  
  percan_res
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]

# FDR adjustment

group <- unique(AllGeneSig_meta$Treatment)
AllGeneSig_meta <- lapply(1:length(group), function(k){
  
  sub_df <- AllGeneSig_meta[AllGeneSig_meta$Treatment == group[k], ]
  sub_df$FDR <- p.adjust(sub_df[sub_df$Treatment == group[k], "Pval"], method = "BH")
  sub_df
  
})

AllGeneSig_meta <- do.call(rbind, AllGeneSig_meta)
AllGeneSig_meta <- AllGeneSig_meta[order(AllGeneSig_meta$FDR), ]

write.csv(AllGeneSig_meta, file=file.path(dir.out, "meta_perTreatment_pfs.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(dir.out, "meta_perTreatment_pfs.RData"))


################################################################
## Heatmap: pan-cancer analysis
################################################################ 

load(file.path(dir.out, "meta_pan_os.RData"))
os <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]
genes <- unique(os$Gene)
os <- os[os$FDR < 0.05 | os$Pval < 0.05, ]

load(file.path(dir.out, "meta_pan_pfs.RData"))
pfs <- AllGeneSig_meta[!is.na(AllGeneSig_meta$Coef), ]
genes <- unique(pfs$Gene)
pfs <- pfs[pfs$FDR < 0.05 | pfs$Pval < 0.05, ]

load(file.path(dir.out, "meta_pan_logreg.RData"))
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

jpeg(file = file.path(dir.out, "Heatmap_pan.jpeg"), width = 1500, height = 550, res = 150)

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

load(file.path(dir.out, "res.os.RData"))
df <- res.os[res.os$Gene == "IRG_Ayers", ]
study <- sapply(1:nrow(df), function(k){
  
  substr(df$Study[k], 5, nchar(df$Study[k]))
  
})
  
jpeg(file=file.path(dir.out, "IRG_Ayers_os_pan.jpeg"), width = 1200, height = 900, res = 150)

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


