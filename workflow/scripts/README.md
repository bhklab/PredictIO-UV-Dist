# Scripts Directory

## Purpose

This directory contains **modular R scripts** used across the distributed univariable modeling pipeline for Immuno-Oncology (IO) therapy outcomes. These scripts enable:

- Local univariable signature association with IO outcomes at each data-contributing center
- Summary statistic extraction and export
- Meta-analysis integration at a central node
- Visualization of distributed analysis outputs

## Key Scripts (Refer to `workflow/scripts`)

### Analysis Scripts (`/scripts/analysis/`)
- `local_analysis.R`: Performs univariable analysis per center using site-specific config
- `aggregate_results.R`: Merges and meta-analyzes results from all centers
- `meta_utils.R`: Helper functions for statistical aggregation (fixed/random effects)
- `validate_inputs.R`: Harmonization and QC of center-provided data (optional)
- `nextflow_pipeline.nf`: Optional orchestration script for distributed execution using Nextflow

### Visualization Scripts (`/scripts/visualization/`)
- `visualization.Rmd`: Generates plots such as forest plots, volcano plots, and heatmaps based on integrated results


## Folder Structure (if extended)

```console
/scripts/analysis/
/scripts/visualization/
```

## Data References

When scripts access data:

- Use command-line arguments or configuration files for file paths
- Document in `docs/data_sources.md` which scripts use which data sources
- Consider using symbolic links for consistent references across environments
