# Processed Data Directory

## Purpose

This directory stores **intermediate processed data objects** generated from raw RNA-seq and clinical inputs. These `.rda` files are structured for downstream analyses such as signature scoring, survival modeling, and meta-analysis.

Each file typically includes:
- Normalized gene expression matrices (e.g., TPM)
- Clinical metadata and sample annotations
- Signature scores and associated metadata
- Combined as a `SummarizedExperiment` or `MultiAssayExperiment` object

---

## How to Generate Processed Data

To prepare the `.rda` files from raw inputs, follow these steps:

### 1. Download Raw Data
Download the raw dataset from ORCESTRA, for example:

➡️ [ICB_Gide Dataset](https://www.orcestra.ca/clinical_icb/62f29e85be1b2e72a9c177f4)

Save the file as:
```bash
data/rawdata/ICB_Gide.rds
```

### 2. Obtain Gene Signature Files

Ensure the following signature metadata files are present in `data/rawdata/`:
- `signature.rda` — curated gene signature matrix
- `sig.info.rda` — metadata for signatures (e.g., method, category)

### 3. Run Processing Script

Use the following command to process the raw data:

```bash
Rscript workflow/scripts/runProcData.R
```

This script:
- Loads the raw `.rds` input
- Builds a `SummarizedExperiment` using `MultiAssayExperiment` (MAE) 
- Attaches signatures and metadata
- Saves the result as a combined `.rda` object
- Precompiled `.RData` file — [Zenodo DOI: 10.5281/zenodo.15832651](https://zenodo.org/records/15832652) 

---

## File Naming Convention

Processed files follow this structure:

```
<study_name>__<cancer_type>__<treatment_type>.rda
```

**Example:**
```
ICB_Gide__Melanoma__PD-(L)1.rda
```

```
## Note on Treatment Harmonization

To ensure consistency across datasets with varying annotation styles:

- Treatments such as `"anti-PD-1"`, `"anti-PD-L1"`, or `"anti-PD-1/anti-PD-L1"` are grouped under:
  ```
  PD-(L)1 or PD-1/PD-L1
  ```

- Combination therapies involving both PD-(L)1 and CTLA4 (typically containing the keyword `"combo"`) are categorized as:
  ```
  IO+combo
  ```

This harmonization supports uniform stratification across cohorts and treatment types in the downstream meta-analysis.

