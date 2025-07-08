# Results Directory

## Purpose

This directory stores the **output files** from all stages of the analysis pipeline, including:

- Gene signature scores
- Clinical association results
- Meta-analysis outputs
- Summary tables and visualizations

The structure reflects a **federated analysis design**, with separate subfolders for:

- **Local results**: results generated independently by each contributing center
- **Central results**: results aggregated at the central node via meta-analysis

---

## Directory Structure

```console
/results/
├── local/        # Per-center results (e.g., ICB_Gide, ICB_VanAllen)
/results/local/
    ├── ICB_Gide/
    ├── ICB_VanAllen/

├── central/      # Meta-analysis results across all centers

