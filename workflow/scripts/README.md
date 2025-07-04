# Scripts Directory

## Purpose

This directory contains modular, reusable R scripts designed for a distributed, privacy-preserving analysis pipeline to evaluate univariable associations between molecular signatures and Immuno-Oncology (IO) therapy outcomes across multiple centers.

These scripts support:

- Local univariable modeling at each participating center
- Extraction of summary statistics (no raw or sensitive patient data sharing)
- Central meta-analysis across all centers at a central integration node
- Visualization of integrated findings for reporting and interpretation

## Key Scripts (Refer to `workflow/scripts`)

- `runSigAnalysis.R`: Executes local univariable analysis per center. Computes signature scores (e.g., GSVA, weighted mean, IPS) and tests associations with outcomes such as OS, PFS, and response.
- `runMetaAnalysis.R`: Aggregates outputs from all centers and performs meta-analysis (fixed/random effects), multiple testing correction, and harmonization.
- `visualization.R`: Generates forest plots, volcano plots, and heatmaps from the integrated results to highlight reproducible and center-specific associations.
- `main.nf`: Nextflow orchestration pipeline for distributed, parallel execution of local analyses and aggregation workflows.

## Data Inputs and Signature Library

The pipeline is designed to support multiple data modalities across centers:

- **Gene expression matrix**: Typically log2(TPM) RNA-seq or normalized microarray data.
- **Clinical variables**: OS (overall survival), PFS (progression-free survival), binary response.
- **Signatures**: A curated library of immune-relevant gene signatures (e.g., IFN-γ, TIS, IPS) loaded from TBD

Each center should:

1. Place data in /data/<CENTER_NAME>/
2. Provide center-specific configuration in config/<center_config>.yaml, specifying:

- Study name (e.g., ICB_Gide)
- Cancer type (e.g., Melanoma)
- Treatment class (e.g., CTLA4)
- Input paths and signature set

