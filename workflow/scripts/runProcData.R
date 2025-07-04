# load library

library(MultiAssayExperiment)
library(data.table)
library(PredictioR)

####################################################
# set up directory
####################################################
dir.in <- 'data/rawdata'
dir.out <- 'data/procdata'

study.icb <- "ICB_Gide"
cancer_type <- "Melanoma"
treatment <- "PD-(L)1"

###################################################
# load ICB data
###################################################
# download ICB Gide  dataset from 'https://www.orcestra.ca/clinical_icb/62f29e85be1b2e72a9c177f4'
# locate at data/rawdata folder

dat <- readRDS(file = file.path(dir.in, 'ICB_Gide.rds')) # MAE object
dat_icb <- createSE(dat) # create SE object: TPM expression matrix, clinical, and gene annotation data

###########################################################
## load signature data and signature meta-data information
###########################################################

load(file.path(dir.in, 'signature.rda'))
load(file.path(dir.in, 'sig.info.rda'))

dat <- list('ICB' = dat_icb,
            'signature' = signature,
            'sig.info' = sig.info)

save(dat, file = file.path(dir.out, 
                           paste(paste(study.icb, 
                                       cancer_type, 
                                       treatment, 
                                       sep='__'), 
                                       '.rda', sep="") ))_

