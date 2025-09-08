# Scripts Directory

## Purpose

This directory provides **modular R scripts** that implement a **federated, privacy-preserving pipeline** for univariable analysis of immunotherapy outcomes.  
The workflow evaluates associations between transcriptomic signatures and clinical endpoints across multiple centers while keeping patient-level data local.

Scripts are organized into two parts:
- **Local (per-center) analysis** — runs at each site to generate summary statistics
- **Central (aggregator) analysis** — combines results from all sites into a meta-analysis

The entire workflow is orchestrated by **Nextflow** (`main.nf`), ensuring scalability, reproducibility, and compatibility across computing environments. Execution has been validated on **Code Ocean**.

### Key Capabilities
- Run analyses independently at each center without sharing raw data
- Extract only **de-identified summary statistics** (e.g., logHR, logOR, correlations)
- Perform **centralized meta-analysis** across centers
- Generate publication-ready outputs (e.g., heatmaps, forest plots)

---

## Local Scripts (`workflow/scripts/local/`)

- `runSigAnalysis.R`  
  Executes local univariable signature analysis at each center. Computes signature scores using GSVA, weighted mean, or IPS, and assesses associations with:
  - Overall Survival (OS)
  - Progression-Free Survival (PFS)
  - Binary response (e.g., clinical benefit)

- `runProcData.R`  
  Prepares input data for local analysis.  
  - Normalizes expression matrices  
  - Formats clinical variables  
  - Ensures consistent input for `runSigAnalysis.R`

---

## Central Scripts (`workflow/scripts/central/`)

- `runMetaAnalysis.R`  
  Integrates summary statistics across centers using fixed/random effects meta-analysis. Outputs include pooled effect sizes, confidence intervals, p-values, heterogenity, and FDR-adjusted p-values.

- `visualization.R`  
  Generates figures (e.g., forest plots, volcano plots, heatmaps) from aggregated results, highlighting reproducible and center-specific associations.

---

## Pipeline Orchestration (`main.nf`)

- `main.nf`  
  A Nextflow pipeline that orchestrates local analyses and central aggregation, enabling scalable, parallel, and reproducible execution across diverse computing environments. The pipeline was executed using the Code Ocean platform to ensure portability and reproducibility. 

---

## Input Requirements

Each center is expected to provide:

- A **normalized gene expression matrix** (e.g., log2(TPM + 0.001))
- Relevant **clinical variables**:
  - `OS`, `PFS`, and `status`
  - Binary response (e.g., complete/partial vs. stable/progressive)
- A **curated signature collection** (e.g., TIS, IFN-γ, IPS, TME)

Signatures are typically loaded from a curated `.rda` file or fetched from:

➡️ **Precompiled `.RData` file** — [Zenodo DOI: 10.5281/zenodo.15832651](https://zenodo.org/records/15832652)

---

## Local Configuration and Directory Structure

Each center should:

1. Place input files under:  
   ```
   data/<CENTER_NAME>/
   ```

2. Provide a center-specific configuration file that matches the center/study name exactly.  
   The filename **must correspond** to the directory name used for local analysis:
   ```
   config/<center_name or study_name>.yaml
   ```

   For example, for `data/ICB_Gide/`, the matching configuration file should be named `config/ICB_Gide.yaml`. You can use `config/config_local.yaml` as a template to create this center-specific config.

This YAML config should specify:

- `study` – dataset name (e.g., `ICB_Gide`)
- `cancer_type` – e.g., `Melanoma`
- `treatment` – e.g., `PD-(L)1`, `CTLA4`, or `IO+combo`
- File paths to expression and clinical data
- Path to the signature library

---

## Notes

- All scripts avoid using patient-level identifiers.
- Results are generated locally and shared as **summary-level statistics only**.
- Compatible with the [PredictIO-UV-Dist](https://github.com/bhklab/PredictIO-UV-Dist) framework.
