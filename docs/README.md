# Distributed univariable predictive modelling for Immuno-Oncology response

**Authors:** [Farnoosh Abbas Aghababazadeh](https://github.com/RibaA), [Nasim Bondar Sahebi](https://github.com/sogolsahebi)

**Contact:** [farnoosh.abbasaghababazadeh@uhn.ca](mailto:farnoosh.abbasaghababazadeh@uhn.ca),  [nasim.bondarsahebi@uhn.ca](mailto:nasim.bondarsahebi@uhn.ca)

**Description:** A distributed framework for univariable predictive modeling of Immuno-Oncology (IO) response, enabling analysis across multiple centers without sharing patient-level data.

--------------------------------------

[![pixi-badge](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/prefix-dev/pixi/main/assets/badge/v0.json&style=flat-square)](https://github.com/prefix-dev/pixi)
[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json&style=flat-square)](https://github.com/astral-sh/ruff)
[![Built with Material for MkDocs](https://img.shields.io/badge/mkdocs--material-gray?logo=materialformkdocs&style=flat-square)](https://github.com/squidfunk/mkdocs-material)

![GitHub last commit](https://img.shields.io/github/last-commit/bhklab/predictio-uv-dist?style=flat-square)
![GitHub issues](https://img.shields.io/github/issues/bhklab/predictio-uv-dist?style=flat-square)
![GitHub pull requests](https://img.shields.io/github/issues-pr/bhklab/predictio-uv-dist?style=flat-square)
![GitHub contributors](https://img.shields.io/github/contributors/bhklab/predictio-uv-dist?style=flat-square)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/bhklab/predictio-uv-dist?style=flat-square)

## Project Overview

This repository implements a distributed framework for evaluating the predictive value of RNA-based signatures in response to Immuno-Oncology (IO) therapies. It supports:

- Center-specific signature scoring and modeling (e.g., OS, PFS, response)
- Strict data privacy (no sharing of raw or patient-level data)
- Centralized meta-analysis of effect sizes across datasets
- Modular, reproducible pipeline built with **Pixi**, **Nextflow**, and **R**

## Set Up

### Prerequisites

Pixi is required to run this project.
If you haven't installed it yet, [follow these instructions](https://pixi.sh/latest/)

### Installation

```bash
# Clone the repository
git clone https://github.com/bhklab/predictio-uv-dist.git
cd predictio-uv-dist

# Install dependencies via Pixi
pixi install
```

## Repository Structure

```
predictio-uv-dist/
├── config/           # YAML config files for each dataset and center
├── data/             # Raw, processed, and results directories
├── workflow/         # Scripts and Nextflow pipeline for analysis
├── docs/             # MkDocs-based project documentation
│   └── README.md     # Documentation index and setup instructions
└── pixi.toml         # Pixi environment specification
```

---

## Documentation

Full documentation, including usage instructions, data setup, config templates, and pipeline stages, is available at:

🔗 [https://bhklab.github.io/predictio-uv-dist](https://github.com/bhklab/PredictIO-UV-Dist)



