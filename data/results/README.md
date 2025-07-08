# Results Directory

## Purpose

This directory contains the **output files** from all stages of the distributed analysis pipeline, including:

- Signature scoring results (e.g., GSVA, ssGSEA)
- Clinical association outputs (e.g., Cox models, logistic regression)
- Meta-analysis results (e.g., pooled hazard ratios, odds ratios)
- Summary tables and visualizations (e.g., heatmaps, forest plots)

The folder structure reflects a **federated analysis design**, where local results are computed independently at each center and aggregated centrally via meta-analysis.

---

## Directory Structure

```console
/results/
├── local/           # Results from individual centers
│   ├── ICB_Gide/
│   ├── ICB_VanAllen/
│   └── ICB_Miao1/
│
└── central/         # Aggregated meta-analysis results across all centers

---
## Notes

- Local directories contain only **de-identified, derived results** (e.g., gene signature scores and summary statistics).
- **No raw data or patient-level clinical data is stored or shared** in the `/results/local/` directories.
- Each center performs local computation independently to preserve **data privacy and compliance** with institutional and ethical regulations.
- The `central/` directory includes only aggregated results (e.g., effect sizes) suitable for meta-analysis.
- File names are standardized for reproducibility and traceability.
