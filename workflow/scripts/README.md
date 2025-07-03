# Scripts Directory

## Purpose

This directory contains modular, reusable R scripts that support the distributed univariable analysis framework for Immuno-Oncology (IO) outcome modeling. These scripts are designed to be executed locally at each participating center and centrally during meta-analysis.

They cover:

- Computing univariable associations between gene expression signatures and IO outcomes at each site
- Exporting summary statistics in a privacy-preserving format
- Aggregating and meta-analyzing results at a central integration node
- Visualizing integrated findings to support biomarker discovery

## Key Scripts (Refer to `workflow/scripts`)

- `runSigAnalysis.R`: Performs univariable analysis per center using site-specific config
- `runMetaAnalysis.R`: Merges and meta-analyzes results from all centers
- `visualization.R`: Generates plots such as forest plots, volcano plots, and heatmaps based on integrated results
- `main.nf`: Orchestration script for distributed execution using Nextflow

## Data References

When scripts access data:

- Use command-line arguments or configuration files for file paths
- Document in `docs/data_sources.md` which scripts use which data sources
- Consider using symbolic links for consistent references across environments
