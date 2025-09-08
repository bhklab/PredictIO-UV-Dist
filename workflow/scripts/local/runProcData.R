# -----------------------------------------------------------
# Processed Data Creation Script
# This script reads input and output directory paths and study metadata
# from `config_proc.yaml`, and performs the following:
#
#   - Loads raw MultiAssayExperiment (MAE) object from `data/rawdata`
#   - Converts MAE to SummarizedExperiment (SE)
#   - Loads gene signature data and metadata
#   - Saves a combined processed data object to `data/procdata`
#
# Config file: config/config_proc.yaml
# -----------------------------------------------------------
########################################################
## Load Libraries
########################################################
library(MultiAssayExperiment)
library(data.table)
library(PredictioR)
library(yaml)

###########################################################
## Set up working directory and study configuration
###########################################################
# Load configuration file
config <- yaml::read_yaml("config/config_proc.yaml")

dir_in <- config$dir_in # "data/rawdata"
dir_out <- config$dir_out # "data/procdata"

study_icb <- config$study_icb # "ICB_Gide"
cancer_type <- config$cancer_type # "Melanoma"
treatment_type <- config$treatment_type # "PD-(L)1"  (Other options include: CTLA-4, IO+combo, etc.)

########################################################
## Load Raw ICB Dataset
########################################################
# Ensure the following file is downloaded from:
# https://www.orcestra.ca/clinical_icb/62f29e85be1b2e72a9c177f4
# and placed in `data/rawdata/ICB_Gide.rds`

mae_obj <- readRDS(file.path(dir_in, "ICB_Gide.rds"))  # MultiAssayExperiment
se_obj  <- PredictioR::createSE(mae_obj)  # Extract SummarizedExperiment (TPM + clinical)

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