# Usage Guide

This section provides step-by-step instructions to configure, run, and manage your analysis using the distributed biomarker discovery pipeline.

---

## Project Configuration

### 1. Customize Configuration Files

Edit the YAML files in the `config/` directory to reflect your study parameters:
- `config_proc.yaml`: For processing raw input into analysis-ready format.
- `config_local.yaml`: For local signature scoring and modeling.

Each center should create a center-specific config file using the template:

```bash
config/<center_or_study_name>.yaml
# Example:
config/ICB_Gide.yaml
```

Use `config/config_local.yaml` as a reference.

---

### 2. Add Input Data

Place your raw input datasets (e.g., `.rds` files) in the `data/rawdata/` directory:

```bash
data/rawdata/ICB_Gide.rds
```

Also include gene signature metadata files:

- `signature.rda`
- `sig.info.rda`
- Precompiled `.RData` file — [Zenodo DOI: 10.5281/zenodo.15832651](https://zenodo.org/records/15832652)

---

## Running Your Analysis

### 1. Install Dependencies

If using [`pixi`](https://prefix.dev/docs/pixi/overview):

```bash
pixi install
```

This sets up your environment with R, Bioconductor, and required packages.

---

### 2. Run Local Processing

Prepare analysis-ready `.rda` files from raw data:

```bash
Rscript workflow/scripts/runProcData.R
```

---

### 3. Run Signature Scoring & Univariable Analysis

```bash
Rscript workflow/scripts/runSigAnalysis.R
```

---

### 4. Run Meta-analysis (central node only)

```bash
Rscript workflow/scripts/runMetaAnalysis.R
```

---

### 5. Generate Visualizations

```bash
Rscript workflow/scripts/visualization.R
```

This script generates forest plots, volcano plots, and heatmaps.

---

## Tips for Managing Your Data

- Use meaningful filenames (e.g., `ICB_Gide__Melanoma__PD-(L)1.rda`)