# Scripts Directory

## Purpose

This directory contains **modular R scripts** used across the distributed univariable modeling pipeline for Immuno-Oncology (IO) therapy outcomes. These scripts enable:

- Local univariable signature association with IO outcomes at each data-contributing center
- Summary statistic extraction and export
- Meta-analysis integration at a central node
- Visualization of distributed analysis outputs

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
