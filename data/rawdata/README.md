# Raw Data Directory

## Purpose

This directory is reserved for **immutable raw data files** that serve as the original input to the analysis pipeline. These files are not tracked by Git and must be obtained separately to ensure full reproducibility.

---

## Data Access Instructions

**No raw data files are included in this repository.**  
To reproduce the results, you must manually download the original data using the links below.

### Primary Dataset: ORCESTRA Platform

All raw datasets used in this pipeline are hosted on [**ORCESTRA**](https://www.orcestra.ca/clinical_icb), a reproducible biomedical data platform.

Please download the dataset using the following curated release:

➡️ **https://www.orcestra.ca/clinical_icb/62f29e85be1b2e72a9c177f4**

This dataset includes:
- Normalized RNA-seq expression data (TPM)
- Clinical annotations for immune checkpoint blockade (ICB) studies
- Associated metadata and processing documentation

---

### Signature Sets: Curated Immune/TME Gene Signatures

This pipeline utilizes a curated collection of 120 RNA-based gene expression signatures related to the tumor microenvironment (TME) and immunotherapy response.

You can access these signatures via:

- **IO Signatures** — [bhklab/SignatureSets](https://github.com/bhklab/SignatureSets)  
- **TME Signatures** — [IOBR Project](https://github.com/IOBR/IOBR)  
- **Precompiled `.RData` file** — [Zenodo DOI: 10.5281/zenodo.15832651](https://zenodo.org/records/15832652)

Each signature is:
- Annotated with source publication
- Categorized (e.g., IO-sensitive, IO-resistant)
- Used for GSVA, weighted mean, or ssGSEA scoring

---

## Inclusion & Exclusion Criteria

Raw datasets and gene signatures were selected based on:

- Availability of pre-treatment RNA-seq data
- Adequate clinical annotation (e.g., treatment label, survival)
- Sufficient sample size per cohort
- Relevance to immune checkpoint blockade (ICB) therapy

Refer to the **Materials and Methods** section of the manuscript for detailed criteria.

---

## Additional Notes

- Only a subset of ORCESTRA datasets was selected based on treatment relevance and data quality.
- Analyses are stratified by **cancer type** and **treatment type** to ensure consistency across studies.
- This directory is **read-only** during pipeline execution. All transformations are done downstream in `data/procdata/`.
