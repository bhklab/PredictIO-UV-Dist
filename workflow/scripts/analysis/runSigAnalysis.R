# load libraries
library(PredictioR)
library(survival)
library(GSVA)
library(dplyr)
library(data.table)
library(Hmisc)
library(MultiAssayExperiment)

###########################################################
## Set up working directory and study configuration
###########################################################

dir <- "/results"

############################################
## load data
############################################
data.files <- list.files("/data")

study.icb <- "ICB_Gide"
load(file.path("/data/ICB_Gide", list.files("/data/ICB_Gide")))

expr <- dat$ICB
signature <- dat$signature
signature_info <- dat$sig.info
cancer_type <- "Melanoma"
treatment_type <- "PD-1/PD-L1"

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
                           study = study.icb)
    
    
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
                           study = study.icb)
    
  }
  
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "ssGSEA"){
    
    geneSig <- geneSigssGSEA(dat.icb = expr,
                             sig = signature[[i]],
                             sig.name = sig_name,
                             missing.perc = 0.5,
                             const.int = 0.001,
                             n.cutoff = 15,
                             sig.perc = 0.8,
                             study = paste(strsplit(study.icb, "__")[[1]][1],
                                           strsplit(study.icb, "__")[[1]][2],
                                           sep="__"))
    
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
                             study = paste(strsplit(study.icb, "__")[[1]][1],
                                           strsplit(study.icb, "__")[[1]][2],
                                           sep="__"))
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "IPS_Charoentong"){
    
    geneSig <- geneSigIPS(dat.icb = expr,
                          sig = signature[[i]],
                          sig.name = sig_name,
                          missing.perc = 0.5,
                          const.int = 0.001,
                          n.cutoff = 15,
                          study = paste(strsplit(study.icb, "__")[[1]][1],
                                        strsplit(study.icb, "__")[[1]][2],
                                        sep="__"))
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "PredictIO_Bareche"){
    
    geneSig <- geneSigPredictIO(dat.icb = expr,
                                sig = signature[[i]],
                                sig.name = sig_name,
                                missing.perc = 0.5,
                                const.int = 0.001,
                                n.cutoff = 15,
                                sig.perc = 0.8,
                                study = paste(strsplit(study.icb, "__")[[1]][1],
                                              strsplit(study.icb, "__")[[1]][2],
                                              sep="__"))
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "IPRES_Hugo"){
    
    geneSig <- geneSigIPRES(dat.icb = expr,
                            sig = signature[[i]],
                            sig.name = sig_name,
                            missing.perc = 0.5,
                            const.int = 0.001,
                            n.cutoff = 15,
                            sig.perc = 0.8,
                            study = paste(strsplit(study.icb, "__")[[1]][1],
                                          strsplit(study.icb, "__")[[1]][2],
                                          sep="__"))
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "PassON_Du"){
    
    geneSig <- geneSigPassON(dat.icb = expr,
                             sig = signature[[i]],
                             sig.name = sig_name,
                             missing.perc = 0.5,
                             const.int = 0.001,
                             n.cutoff = 15,
                             sig.perc = 0.8,
                             study = paste(strsplit(study.icb, "__")[[1]][1],
                                           strsplit(study.icb, "__")[[1]][2],
                                           sep="__"))
    
  }
  
  if(signature_info[signature_info$signature == sig_name, "method"] == "Specific Algorithm" & sig_name == "IPSOV_Shen"){
    
    geneSig <- geneSigIPSOV(dat.icb = expr,
                            sig = signature[[i]],
                            sig.name = sig_name,
                            missing.perc = 0.5,
                            const.int = 0.001,
                            n.cutoff = 15,
                            sig.perc = 0.8,
                            study = paste(strsplit(study.icb, "__")[[1]][1],
                                          strsplit(study.icb, "__")[[1]][2],
                                          sep="__"))
    
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

save(geneSig.score, file=file.path("/results", paste(study.icb , "sig_score.rda", sep = "_")))

############################################################
## Pearson Correlation analysis
############################################################

fit <- rcorr(t(geneSig.score))
cor.val <- list ("r" = fit$r,
                 "n" = fit$n,
                 "p" = fit$P)

names(cor.val) <- rep(study.icb, 3)
save(cor.val, file = file.path("/results", paste(study.icb , "sig_pcor.rda", sep = "_")))

#########################################################
## Association with OS
#########################################################

res.os <- lapply(1:nrow(geneSig.score), function(k){
  
  res <- geneSigSurvCont(dat.icb = expr,
                         geneSig = geneSig.score[k,],
                         time.censor = 36,
                         n.cutoff = 15,
                         study =  paste(study.icb, cancer_type, treatment_type, sep="__"),
                         surv.outcome = "OS",
                         sig.name = rownames(geneSig.score)[k],
                         cancer.type = cancer_type,
                         treatment = treatment_type)
  
  res
  
})

res.os <- do.call(rbind, res.os)
res.os$FDR <- p.adjust(res.os$Pval, method="BH")

save(res.os, file = file.path("/results", paste(study.icb , "sig_os.rda", sep = "_")))

#########################################################
## Association with PFS
#########################################################

res.pfs <- lapply(1:nrow(geneSig.score), function(k){
  
  res <- geneSigSurvCont(dat.icb = expr,
                         geneSig = geneSig.score[k,],
                         time.censor = 24,
                         n.cutoff = 15,
                         study =  paste(study.icb, cancer_type, treatment_type, sep="__"),
                         surv.outcome = "PFS",
                         sig.name = rownames(geneSig.score)[k],
                         cancer.type = cancer_type,
                         treatment = treatment_type)
  
  res
  
})

res.pfs <- do.call(rbind, res.pfs)
res.pfs$FDR <- p.adjust(res.pfs$Pval, method="BH")

save(res.pfs, file = file.path("/results", paste(study.icb , "sig_pfs.rda", sep = "_")))

#########################################################
## Association with response
#########################################################

res.logreg <- lapply(1:nrow(geneSig.score), function(k){
  
  res <- geneSigLogReg(dat.icb = expr,
                       geneSig = geneSig.score[k,],
                       n.cutoff = 15,
                       study =  paste(study.icb, cancer_type, treatment_type, sep="__"),
                       sig.name = rownames(geneSig.score)[k],
                       n0.cutoff = 3, 
                       n1.cutoff = 3,
                       cancer.type = cancer_type,
                       treatment = treatment_type)
  
  res
  
})

res.logreg <- do.call(rbind, res.logreg)
res.logreg$FDR <- p.adjust(res.logreg$Pval, method="BH")

save(res.logreg, file = file.path("/results", paste(study.icb , "sig_logreg.rda", sep = "_")))

