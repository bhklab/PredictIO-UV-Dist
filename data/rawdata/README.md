# Raw Data Directory

## Purpose

This directory is designated for **immutable raw data files** that serve as the original inputs to pipeline. 

---

## Data Access Instructions

**No raw data files are included in this repository.** To fully reproduce the results, you must download the original raw data manually using the link below.

### Primary Data Source: ORCESTRA

All raw datasets used in this pipeline are hosted on [**ORCESTRA**](https://www.orcestra.ca/clinical_icb), a reproducible biomedical data platform.

Please download the raw data from the following curated dataset:

➡️ **https://www.orcestra.ca/clinical_icb/62f29e85be1b2e72a9c177f4**

The dataset includes:

- Normalized RNA-seq expression profiles (TPM)
- Clinical annotations for immune checkpoint blockade (ICB) studies
- Associated metadata and processing documentation

---

### Signature Sets: Curated Immune/TME Signatures

To perform signature scoring, association and meta-analysis, this project uses a curated collection of ~120 RNA-based gene signatures (e.g., IO-responsive, TME-related, IO-resistant).

These are available from:

➡️ **IO signatures** - Project repository: [bhklab/SignatureSets](https://github.com/bhklab/SignatureSets)  
➡️ **TME signatures** - Project repository: [IOBR — Immune-Oncology Biological Research](https://github.com/IOBR/IOBR)  
or  
➡️ Download precompiled RData file: [link_to_be_provided ---> TO BE ADDED]  
*(update with URL if hosted externally, e.g., Code Ocean or Zenodo)*

Each signature is:

- Documented with its source publication
- Categorized into functional classes (IO-sensitive, IO-resistant, etc.)
- Used for GSVA, weighted mean, specific algorithm, or ssGSEA scoring

---

## Data Access Instructions

Inclusion & Exclusion Criteria
The datasets and signatures included in this pipeline were selected based on predefined inclusion/exclusion criteria, as described in the associated manuscript. Criteria focused on treatment relevance, data completeness, pre-treatment sample availability, and biological relevance of signatures. For details, see the **Materials and Methods** section of the manuscript.