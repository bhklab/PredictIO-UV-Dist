# Data Sources

## Overview

This document describes all **Immuno-Oncology (IO)** and **RNA-based signature** datasets used throughout the distributed univariable analysis pipeline. Complete documentation ensures **reproducibility**, proper attribution, and transparency across all collaborating centers.

---

## Immuno-Oncology Data Sources

### RNA-Seq and Clinical Data

- **Name**: Immune Checkpoint Blockade - RNA-Seq, and Clinical data
- **URL**: [https://www.orcestra.ca/clinical_icb](https://www.orcestra.ca/clinical_icb)
- **Access Method**: Direct download or programmatic retrieval via API (if applicable)
- **Data Format**: MultiAssayExperiment and SummarizedExperiment in R (Bioconductor)
- **Citation**: [Bareche, Y., Kelly, D., Abbas-Aghababazadeh, F. et al., Annals of Oncology 2022](https://pubmed.ncbi.nlm.nih.gov/36055464/)

### Signatures Platform

- **Name**: SignatureSets: An R Package for RNA-Based Immuno-Oncology Signatures
- **Version**: v1.0
- **URL**: [bhklab/SignatureSets](https://github.com/bhklab/SignatureSets)
- **Access Method**: Direct download or programmatic retrieval via API (if applicable)
- **Data Format**: rda, CSV (signatures, metadata)
- **Citation**: [Bareche, Y., Kelly, D., Abbas-Aghababazadeh, F. et al., Annals of Oncology 2022](https://pubmed.ncbi.nlm.nih.gov/36055464/)

---


---

## 👥 Patient Summary Table

| Variable         | Description                            | Format      | Example        |
|------------------|----------------------------------------|-------------|----------------|
| patient_id       | Unique TCGA barcode                    | string      | TCGA-2H-A9GF   |
| age              | Age at diagnosis                       | integer     | 63             |
| sex              | Biological sex                         | factor      | M/F    |
| cancer_type      | Primary cancer type                    | string      | Melanoma       |
| treatment_type   | IO therapy category                    | string      | PD-1           |
| os_time_months   | Overall survival time (months)         | numeric     | 21.3           |
| os_status        | Overall survival event (1 = death)     | binary      | 1              |

---
