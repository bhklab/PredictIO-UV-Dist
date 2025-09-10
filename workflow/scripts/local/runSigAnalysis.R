# Description:
# This script performs signature-based analysis on pre-processed 
# immunotherapy datasets. It calculates gene signature scores and 
# evaluates their associations with clinical outcomes.
#
# Required Inputs:
#   - Processed .rda file (must include):
#       * Normalized gene expression matrix (TPM format, SummarizedExperiment)
#       * Gene signature list (e.g., IO, TME)
#       * Signature metadata (including scoring method)
#
# User-defined parameters (passed as command line arguments):
#   1. study_icb       – Unique study identifier (e.g., ICB_Gide)
#   2. cancer_type     – Cancer type (e.g., Melanoma)
#   3. treatment_type  – Treatment name (e.g., PD-1/PD-L1)
#
# Analyses performed:
#   - Compute gene signature scores using:
#       * GSVA
#       * ssGSEA
#       * Weighted Mean
#       * Other algorithm-specific methods
#   - Correlation analysis between signature scores (Pearson)
#   - Association with:
#       * Overall Survival (OS) – Cox model
#       * Progression-Free Survival (PFS) – Cox model
#       * Binary response – Logistic regression
#
# Output:
#   - Signature scores, correlation matrix, and clinical associations
#     are saved in the /results directory.
#   - Filenames are tagged with the study ID, cancer type, and treatment 
#     to support stratified analyses across subgroups.
#
# Usage:
#   Rscript signature_analysis.R <study_icb> <cancer_type> <treatment_type>
#
# Example:
#   Rscript signature_analysis.R ICB_Gide Melanoma PD-1/PD-L1
#
#   If the study includes multiple treatments (e.g., PD-1/PD-L1 and combo),
#   run the script separately for each:
#
#     Rscript signature_analysis.R ICB_Gide Melanoma PD-1/PD-L1
#     Rscript signature_analysis.R ICB_Gide Melanoma combo
# -----------------------------------------------------------
#############################################################
# Load libraries
#############################################################
library(PredictioR)
library(survival)
library(GSVA)
library(dplyr)
library(data.table)
library(MultiAssayExperiment)
library(Hmisc)

###########################################################
## Set up directory
###########################################################

dir <- "/results"

############################################
## Load data
############################################
data.files <- list.files("/data")

# get command line arguments
args <- commandArgs(trailingOnly = TRUE)

study_icb <- args[1]
load(file.path("/data", grep("\\.rda$", data.files, value = TRUE)))

expr <- dat$ICB
signature <- dat$signature
signature_info <- dat$sig.info
cancer_type <- args[2]
treatment_type <- args[3]

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

save(geneSig.score, file=file.path(dir, paste(study_icb, cancer_type, treatment_type, "sig_score.rda", sep = "_")))

############################################################
## Pearson Correlation analysis
############################################################

fit <- rcorr(t(geneSig.score))
cor.val <- list ("r" = fit$r,
                 "n" = fit$n,
                 "p" = fit$P)

names(cor.val) <- rep(study_icb, 3)
save(cor.val, file = file.path(dir, paste(study_icb, cancer_type, treatment_type, "sig_pcor.rda", sep = "_")))

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

save(res.os, file = file.path(dir, paste(study_icb, cancer_type, treatment_type, "sig_os.rda", sep = "_")))

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

save(res.pfs, file = file.path(dir, paste(study_icb, cancer_type, treatment_type, "sig_pfs.rda", sep = "_")))

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

save(res.logreg, file = file.path(dir, paste(study_icb, cancer_type, treatment_type, "sig_logreg.rda", sep = "_")))
