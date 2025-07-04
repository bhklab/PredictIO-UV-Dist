########################################################
## Load Libraries
########################################################
library(MultiAssayExperiment)
library(data.table)
library(PredictioR)

########################################################
## Set Up Directories and Study Metadata
########################################################
dir_in <- "data/rawdata"
dir_out <- "data/procdata"

study_icb <- "ICB_Gide"
cancer_type <- "Melanoma"
treatment_type <- "PD-(L)1"

########################################################
## Load Raw ICB Dataset
########################################################
# Ensure the following file is downloaded from:
# https://www.orcestra.ca/clinical_icb/62f29e85be1b2e72a9c177f4
# and placed in `data/rawdata/ICB_Gide.rds`

mae_obj <- readRDS(file.path(dir_in, "ICB_Gide.rds"))  # MultiAssayExperiment
se_obj  <- createSE(mae_obj)  # Extract SummarizedExperiment (TPM + clinical)

########################################################
## Load Gene Signature Data
########################################################
# Signature objects should be pre-curated and saved as .rda files
load(file.path(dir_in, "signature.rda"))   # signature matrix
load(file.path(dir_in, "sig.info.rda"))    # metadata for signatures

dat <- list('ICB' = dat_icb,
            'signature' = signature,
            'sig.info' = sig.info)

########################################################
## Combine Data into a Named List and Save
########################################################
dat <- list(
  ICB       = se_obj,
  signature = signature,
  sig.info  = sig.info
)

save(
  dat, 
  file = file.path(dir_out, paste0(paste(study_icb, cancer_type, treatment_type, sep = "__"), ".rda"))
)