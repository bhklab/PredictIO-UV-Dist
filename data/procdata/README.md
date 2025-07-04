## Processed Data Preparation

This directory contains processed data objects used in downstream analyses. These are typically `.rda` files that include:

- Normalized gene expression matrices (TPM)
- Clinical meta-data and gene annotations
- Gene signature scores and metadata

---

### How to Generate Processed Data

To prepare the required `.rda` files from raw input:

1. **Download the raw dataset**  
   - For example, download the ICB Gide dataset from:  
     https://www.orcestra.ca/clinical_icb/62f29e85be1b2e72a9c177f4  
   - Save the file as `ICB_Gide.rds` in the `data/rawdata/` directory.

2. **Obtain the gene signature files**  
   Ensure the following files are present in `data/rawdata/`:  
   - `signature.rda` (curated gene signature matrix)  
   - `sig.info.rda` (metadata for signatures)

3. **Run the processing script**  
   To generate the processed data object, run the R script:
   ```bash
   Rscript workflow/scripts/runProcData.R

This script loads raw inputs, processes the MultiAssayExperiment (MAE) object into a SummarizedExperiment format, attaches relevant signatures, and outputs a combined R list object.

---

### File naming convention
All .rda files follow the naming structure:

<study_name>__<cancer_type>__<treatment>.rda 
