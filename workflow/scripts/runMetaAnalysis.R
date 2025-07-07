# -----------------------------------------------------------
# Meta-analysis Script
#
# Description:
# This script performs integration analysis using signature-based associations.
#
# Specifically, it:
#   - Computes signature–outcome associations locally at each center
#   - Shares local results (e.g., log hazard ratios, odds ratios, correlations)
#     with a central node to enable downstream meta-analysis across
#     multiple centers in a federated setting
#   - Aggregates effect sizes at the central node using fixed- or random-effects
#     models to obtain pooled estimates
#   - Supports integration analyses in pan-cancer, cancer-specific, and
#     treatment-specific settings
# -----------------------------------------------------------
#############################################################
# Load libraries
#############################################################
library(PredictioR)
library(meta)
library(dplyr)
library(data.table)
library(Hmisc)

###########################################################
## Set up working directory 
###########################################################
dir_in <- "/data/results/local"
dir_out <- "/data/results/central"

# create output directory as central node
if (!dir.exists(dir_out)) {
dir.create(dir_out, recursive = TRUE, showWarnings = FALSE)
}

############################################
## load data
############################################
data.files <- list.files(file.path(getwd(), dir_in))

## extract correlation data
cor.files <- lapply(1:length(data.files), function(k){
  
  local.files <- list.files(file.path(getwd(), dir_in, data.files[k]))
  cor_files <- local.files[grep("_pcor", local.files)]
  dir <- file.path(getwd(), dir_in, data.files[k], cor_files)
  load(file.path(dir))
  cor.val
  
})

study_icb <- c(data.files)
names(cor.files) <- study_icb
save(cor.files, file = here(getwd(), dir_out, "pCor_result.RData"))

## extract signature score data
score.files <- lapply(1:length(data.files), function(k){
  
  local.files <- list.files(file.path(getwd(), dir_in, data.files[k]))
  sig_files <- local.files[grep("_score", local.files)]
  dir <- file.path(getwd(), dir_in, data.files[k], sig_files)
  load(file.path(dir))
  geneSig.score
  
})

study_icb <- c(data.files)
names(score.files) <- study_icb
save(score.files, file = file.path(getwd(), dir_out, "sigScore_result.RData"))

## extract signature score association (OS) data
res.os <- lapply(1:length(data.files), function(k){
  
  local.files <- list.files(file.path(getwd(), dir_in, data.files[k]))
  os_files <- local.files[grep("_os", local.files)]
  dir <- file.path(getwd(), dir_in, data.files[k], os_files)
  load(file.path(dir))
  res.os
  
})

res.os <- do.call(rbind, res.os)
res.os <- res.os[!is.na(res.os$Coef), ]
rownames(res.os) <- NULL
save(res.os, file = file.path(getwd(), dir_out, "res.os.RData"))
write.csv(res.os, file = file.path(getwd(), dir_out, "res.os.csv"), row.names=FALSE)

## extract signature score association (PFS) data
res.pfs <- lapply(1:length(data.files), function(k){
  
  local.files <- list.files(file.path(getwd(), dir_in, data.files[k]))
  pfs_files <- local.files[grep("_pfs", local.files)]
  dir <- file.path(getwd(), dir_in, data.files[k], pfs_files)
  load(file.path(dir))
  res.pfs
  
})

res.pfs <- do.call(rbind, res.pfs)
res.pfs <- res.pfs[!is.na(res.pfs$Coef), ]
rownames(res.pfs) <- NULL
save(res.pfs, file = file.path(getwd(), dir_out, "res.pfs.RData"))
write.csv(res.pfs, file = file.path(getwd(), dir_out, "res.pfs.csv"), row.names=FALSE)

## extract signature score association (response) data
res.logreg <- lapply(1:length(data.files), function(k){
  
  local.files <- list.files(file.path(getwd(), dir_in, data.files[k]))
  logreg_files <- local.files[grep("_logreg", local.files)]
  dir <- file.path(getwd(), dir_in, data.files[k], logreg_files)
  load(file.path(dir))
  res.logreg
  
})

res.logreg <- do.call(rbind, res.logreg)
res.logreg <- res.logreg[!is.na(res.logreg$Coef), ]
rownames(res.logreg) <- NULL
save(res.logreg, file = file.path(getwd(), dir_out, "res.logreg.RData"))
write.csv(res.logreg, file = file.path(getwd(), dir_out, "res.logreg.csv"), row.names=FALSE)

####################################################################
####################################################################
## Meta correlation
####################################################################
####################################################################
load(file.path(getwd(), dir_out, "pCor_result.RData"))

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
      
      fit <- metacor(sub.df$r, sub.df$n, sm = "cor",
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
     # if(r > 1){ r <- 1 }
     # if(r < (-1)){ r <- (-1)}
    }else{ r <- NA }
    
    r
    
  })
  
  cor.res
  
})

metaCor <- do.call(cbind, metaCor)
rownames(metaCor) <- geneSig1
colnames(metaCor) <- geneSig2

save(metaCor, file=file.path(getwd(), dir_out, "metaCor_matrix.RData"))

################################################################################
################################################################################
## Association meta-analysis: pan-cancer and response
################################################################################
################################################################################
load(file.path(getwd(), dir_out, "res.logreg.RData"))
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

write.csv(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_pan_logreg.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_pan_logreg.RData"))

################################################################################
################################################################################
## Association meta-analysis: pan-cancer and OS
################################################################################
################################################################################
load(file.path(getwd(), dir_out, "res.os.RData"))
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

write.csv(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_pan_os.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_pan_os.RData"))

################################################################################
################################################################################
## Association meta-analysis: pan-cancer and PFS
################################################################################
################################################################################
load(file.path(getwd(), dir_out, "res.pfs.RData"))
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

write.csv(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_pan_pfs.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_pan_pfs.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-cancer and response
################################################################################
################################################################################
load(file.path(getwd(), dir_out, "res.logreg.RData"))
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

write.csv(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perCan_logreg.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perCan_logreg.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-cancer and OS
################################################################################
################################################################################
load(file.path(getwd(), dir_out, "res.os.RData"))
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

write.csv(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perCan_os.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perCan_os.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-cancer and PFS
################################################################################
################################################################################
load(file.path(getwd(), dir_out, "res.pfs.RData"))
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

write.csv(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perCan_pfs.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perCan_pfs.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-treatment and response
################################################################################
################################################################################
load(file.path(getwd(), dir_out, "res.logreg.RData"))
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

write.csv(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perTreatment_logreg.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perTreatment_logreg.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-treatment and OS
################################################################################
################################################################################
load(file.path(getwd(), dir_out, "res.os.RData"))
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

write.csv(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perTreatment_os.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perTreatment_os.RData"))

################################################################################
################################################################################
## Association meta-analysis: per-treatment and PFS
################################################################################
################################################################################
load(file.path(getwd(), dir_out, "res.pfs.RData"))
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

write.csv(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perTreatment_pfs.csv"), row.names = FALSE)
save(AllGeneSig_meta, file=file.path(getwd(), dir_out, "meta_perTreatment_pfs.RData"))

