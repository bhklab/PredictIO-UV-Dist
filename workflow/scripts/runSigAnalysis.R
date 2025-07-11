# -----------------------------------------------------------
# Signature Analysis Script
#
# Description:
# This script loads configuration parameters from `config_local.yaml`
# and performs signature-based analyses on a processed dataset.
#
# Specifically, it:
#   - Computes gene signature scores (GSVA, ssGSEA, Weighted Mean, etc.)
#   - Calculates pairwise correlations among signatures
#   - Assesses association of signature scores with clinical outcomes:
#       * Overall Survival (OS, Cox)
#       * Progression-Free Survival (PFS, Cox)
#       * Binary response (via logistic regression)
#
# Requirements:
#   - Processed data (.rda) containing:
#       * Normalized expression matrix (TPM and SummarizedExperiment)
#       * Gene signatures list (IO and TME)
#       * Signature metadata (method, etc.)
#
# Intended use:
#   - To be executed independently by individual centers/nodes 
#     on their local processed data
#
# Config file: config/config_local.yaml
# -----------------------------------------------------------
#############################################################
# Load libraries
#############################################################
library(PredictioR)
library(survival)
library(GSVA)
library(dplyr)
library(data.table)
library(Hmisc)
library(yaml)
library(MultiAssayExperiment)

###########################################################
## Set up working directory and study configuration
###########################################################
# Load configuration file
config <- yaml::read_yaml("config/config_local.yaml")

dir_in <- config$dir_in # "data/procdata"

# create output directory for each dataset or node
dir_out <- file.path(config$dir_out, config$study_icb) # "data/results/local/<study_icb>"
if (!dir.exists(dir_out)) {
dir.create(dir_out, recursive = TRUE, showWarnings = FALSE)
}

study_icb <- config$study_icb # "ICB_Gide"
cancer_type <- config$cancer_type # "Melanoma"
treatment_type <- config$treatment_type # "PD-(L)1"  (Other options include: CTLA-4, IO+combo, etc.)

############################################
## Load data
############################################
input_file <- file.path(dir_in, paste0(study_icb, "__", cancer_type, "__", treatment_type, ".rda"))
load(input_file)

expr <- dat$ICB
signature <- dat$signature
signature_info <- dat$sig.info

##################################################################
## Compute signature score
##################################################################

geneSig.score <- lapply(1:length(signature), function(i){ 
  
  print(paste(i , names(signature)[i], sep="/"))
  sig_name <- names(signature)[i]
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "GSVA"){
    
    geneSig <- geneSigGSVA(dat.icb = expr,
                           sig = signature[[i]],
                           sig.name = sig_name,
                           missing.perc = 0.5,
                           const.int = 0.001,
                           n.cutoff = 15,
                           sig.perc = 0.8,
                           study = study_icb)
    
    
    if(sum(!is.na(geneSig)) > 0){
      geneSig <- geneSig[1,]
    }     
    
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Weighted Mean"){
    
    geneSig <- geneSigMean(dat.icb = expr,
                           sig = signature[[i]],
                           sig.name = sig_name,
                           missing.perc = 0.5,
                           const.int = 0.001,
                           n.cutoff = 15,
                           sig.perc = 0.8,
                           study = study_icb)
    
  }
  
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "ssGSEA"){
    
    geneSig <- geneSigssGSEA(dat.icb = expr,
                             sig = signature[[i]],
                             sig.name = sig_name,
                             missing.perc = 0.5,
                             const.int = 0.001,
                             n.cutoff = 15,
                             sig.perc = 0.8,
                             study = study_icb)
    
    if(sum(!is.na(geneSig)) > 0){
      geneSig <- geneSig[1,]
    }     
    
    
  }
  
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "COX-IS_Bonavita"){
    
    geneSig <- geneSigCOX_IS(dat.icb = expr,
                             sig = signature[[i]],
                             sig.name = sig_name,
                             missing.perc = 0.5,
                             const.int = 0.001,
                             n.cutoff = 15,
                             sig.perc = 0.8,
                             study = study_icb)
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "IPS_Charoentong"){
    
    geneSig <- geneSigIPS(dat.icb = expr,
                          sig = signature[[i]],
                          sig.name = sig_name,
                          missing.perc = 0.5,
                          const.int = 0.001,
                          n.cutoff = 15,
                          study = study_icb)
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "PredictIO_Bareche"){
    
    geneSig <- geneSigPredictIO(dat.icb = expr,
                                sig = signature[[i]],
                                sig.name = sig_name,
                                missing.perc = 0.5,
                                const.int = 0.001,
                                n.cutoff = 15,
                                sig.perc = 0.8,
                                study = study_icb)
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "IPRES_Hugo"){
    
    geneSig <- geneSigIPRES(dat.icb = expr,
                            sig = signature[[i]],
                            sig.name = sig_name,
                            missing.perc = 0.5,
                            const.int = 0.001,
                            n.cutoff = 15,
                            sig.perc = 0.8,
                            study = study_icb)
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "PassON_Du"){
    
    geneSig <- geneSigPassON(dat.icb = expr,
                             sig = signature[[i]],
                             sig.name = sig_name,
                             missing.perc = 0.5,
                             const.int = 0.001,
                             n.cutoff = 15,
                             sig.perc = 0.8,
                             study = study_icb)
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "IPSOV_Shen"){
    
    geneSig <- geneSigIPSOV(dat.icb = expr,
                            sig = signature[[i]],
                            sig.name = sig_name,
                            missing.perc = 0.5,
                            const.int = 0.001,
                            n.cutoff = 15,
                            sig.perc = 0.8,
                            study = study_icb)
    
  }
  
  
  if(sum(!is.na(geneSig)) > 0){
    
    geneSig <- geneSig
    
  }     
  
  if(sum(!is.na(geneSig)) == 0){
    
    geneSig <- rep(NA, ncol(expr))
    
  }
  
  geneSig
  
})

geneSig.score <- do.call(rbind, geneSig.score)
rownames(geneSig.score) <- names(signature)
remove <- which(is.na(rowSums(geneSig.score)))
if(length(remove) > 0){
  
  geneSig.score <- geneSig.score[-remove, ]
  
}

save(geneSig.score, file=file.path(dir_out, paste(study_icb , "sig_score.rda", sep = "_")))

############################################################
## Pearson Correlation analysis
############################################################

fit <- rcorr(t(geneSig.score))
cor.val <- list ("r" = fit$r,
                 "n" = fit$n,
                 "p" = fit$P)

names(cor.val) <- rep(study_icb, 3)
save(cor.val, file = file.path(dir_out, paste(study_icb , "sig_pcor.rda", sep = "_")))

#########################################################
## Association with OS
#########################################################

res.os <- lapply(1:nrow(geneSig.score), function(k){
  
  res <- geneSigSurvCont(dat.icb = expr,
                         geneSig = geneSig.score[k,],
                         time.censor = 36,
                         n.cutoff = 15,
                         study =  paste(study_icb, cancer_type, treatment_type, sep="__"),
                         surv.outcome = "OS",
                         sig.name = rownames(geneSig.score)[k],
                         cancer.type = cancer_type,
                         treatment = treatment_type)
  
  res
  
})

res.os <- do.call(rbind, res.os)
res.os$FDR <- p.adjust(res.os$Pval, method="BH")

save(res.os, file = file.path(dir_out, paste(study_icb , "sig_os.rda", sep = "_")))

#########################################################
## Association with PFS
#########################################################

res.pfs <- lapply(1:nrow(geneSig.score), function(k){
  
  res <- geneSigSurvCont(dat.icb = expr,
                         geneSig = geneSig.score[k,],
                         time.censor = 24,
                         n.cutoff = 15,
                         study =  paste(study_icb, cancer_type, treatment_type, sep="__"),
                         surv.outcome = "PFS",
                         sig.name = rownames(geneSig.score)[k],
                         cancer.type = cancer_type,
                         treatment = treatment_type)
  
  res
  
})

res.pfs <- do.call(rbind, res.pfs)
res.pfs$FDR <- p.adjust(res.pfs$Pval, method="BH")

save(res.pfs, file = file.path(dir_out, paste(study_icb , "sig_pfs.rda", sep = "_")))

#########################################################
## Association with response
#########################################################

res.logreg <- lapply(1:nrow(geneSig.score), function(k){
  
  res <- geneSigLogReg(dat.icb = expr,
                       geneSig = geneSig.score[k,],
                       n.cutoff = 15,
                       study =  paste(study_icb, cancer_type, treatment_type, sep="__"),
                       sig.name = rownames(geneSig.score)[k],
                       n0.cutoff = 3, 
                       n1.cutoff = 3,
                       cancer.type = cancer_type,
                       treatment = treatment_type)
  
  res
  
})

res.logreg <- do.call(rbind, res.logreg)
res.logreg$FDR <- p.adjust(res.logreg$Pval, method="BH")

save(res.logreg, file = file.path(dir_out, paste(study_icb , "sig_logreg.rda", sep = "_")))


