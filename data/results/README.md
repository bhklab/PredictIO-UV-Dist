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
│   ├── ICB_Hugo/
│   ├── ICB_Liu/
|   ├── ICB_Miao1/
│   ├── ICB_Riaz/
│   └── ICB_VanAllen/
│
└── central/         # Aggregated meta-analysis results across all centers
```

---

## Data Privacy and Governance Notes

- Local result folders contain only **derived, de-identified outputs** such as gene signature scores and summary statistics.
- **No raw expression data or patient-level clinical variables** are stored or shared in the `/results/local/` directory.
- This structure supports a **privacy-preserving, federated analysis framework** aligned with ethical, institutional, and data governance requirements.
- The `/results/central/` directory includes only aggregated results (e.g., logHR, logOR) from multiple centers and is suitable for downstream meta-analysis.
- All result files are version-controlled and named consistently to support traceability and reproducibility.