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


## Key Clinical Variables

| Variable          | Description                            | Format      | Example        |
|------------------ |----------------------------------------|-------------|----------------|
| patientid         | Unique TCGA barcode                    | string      | TCGA-2H-A9GF   |
| age               | Age at diagnosis                       | integer     | 63             |
| sex               | Biological sex                         | factor      | M/F    |
| cancer_type       | Primary cancer type                    | string      | Melanoma       |
| histo             | IO therapy category                    | string      | PD-1           |
| treatment_type    | IO therapy category                    | string      | PD-1/PD-L1     |
| stage             | Overall survival event (1 = death)     | binary      | 1              |
| recist            | Overall survival event (1 = death)     | binary      | 1              |
| response          | IO therapy category                    | string      | PD-1           |
| survival_time_os  | Overall survival time (months)         | numeric     | 21.3           |
| event_occurred_os | Overall survival event (1 = death)     | binary      | 1              |
| survival_time_pfs | Overall survival time (months)         | numeric     | 21.3           |
| event_occurred_pfs| Overall survival event (1 = death)     | binary      | 1              |
| survival_unit     | Overall survival event (1 = death)     | binary      | 1              |

---
