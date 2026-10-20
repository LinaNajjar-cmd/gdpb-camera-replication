# GDP-B: Smartphone-Camera Replication and Sensitivity Extension

**BEEM136 Research Methods I — Tutorial 2 (22 October 2026)**

This repository documents a focused replication and original extension of the smartphone-camera valuation analysis in:

> Brynjolfsson, E., Collis, A., Diewert, W. E., Eggers, F., & Fox, K. J. (2025). *GDP-B: Accounting for the Value of New and Free Goods*. **American Economic Journal: Macroeconomics, 17**(4), 312–344. https://doi.org/10.1257/mac.20210319

**Original data and code:** [AEA / openICPSR replication archive](https://doi.org/10.3886/E209901V1), project 209901, version 1. The original authors developed `Cameras.R` and collected `Cameras.csv`. These original files are included for transparent provenance and are not my original work.

## Research question and scope

The paper develops GDP-B, a measure designed to account for consumer benefits from new and free goods. This project **reproduces only the smartphone-camera valuation analysis / Figure 3**, not the paper's other applications or full macro-level GDP-B calculations.

## Files

| File | Role |
| --- | --- |
| `Cameras.R` | **Unmodified authors' script**, estimating and plotting the original camera demand relationship. |
| `Cameras.csv` | **Original authors' survey data**, 213 respondents. |
| `Cameras_extension.R` | **My own extension script**: compares the original EUR 5–500 fitting range with EUR 5–250, outputs a comparison figure and CSV. |
| `README.md` | Project provenance, methods, results, run instructions, and limitations. |

## Run the analysis in RStudio

1. Download the repository files into the **same folder** on your computer.
2. Open `Cameras.R` in RStudio.
3. Choose **Session → Set Working Directory → To Source File Location** (the folder containing `Cameras.csv`).
4. Run `source("Cameras.R")` to reproduce the authors' plot and original median estimate.
5. Run `source("Cameras_extension.R")` to calculate the extension, print the comparison, and generate `Extension_comparison.png` and `Extension_results.csv`.

The `Cameras.R` and extension scripts use **base R only**: no external packages, no Stata, no Rtools. The archive README lists R 4.3.1 as the authors' original environment; the replication was carried out on Windows with R 4.6.1. No randomness is used in this selected script.

## Outcomes

| Outcome | Original | Sensitivity extension |
| --- | ---: | ---: |
| Compensation range used in fit | EUR 5–500 | EUR 5–250 |
| Number of offer levels in fit | 100 | 50 |
| Fitted median WTA | EUR 68.13 | EUR 74.44 |

Difference: **+EUR 6.31 (+9.26%)**. This is **sensitivity to the fitting range**, not evidence that respondents became better off. We have not calculated a standard error or significance test for the difference in estimated medians.

**Additional checks:** sample size = 213; raw median reported bid = EUR 100; original R-squared ≈ 0.877. The smooth fitted curve was compared with the corresponding published figure.

## Replication experience and documentation review

The official package provides the raw survey CSV, a dedicated short R script and survey materials, so no restricted data, proprietary licences or HPC were necessary for the camera analysis. The initial attempt to run the code failed because `Cameras.csv` was not in R's working directory; extracting both files to one folder and setting the working directory resolved the issue. This is a **file-path/setup issue**, not a discrepancy in the authors' estimates.

The authors' README usefully identifies scripts, software version and data provenance. For this camera-specific application it could be clearer that `Cameras.R` needs only base R, despite the archive-level package requirement mentioning `plyr`. It would also help to give explicit per-script entry points and working-directory instructions. The README's general statement about random seeds should be read in the context of individual scripts; the camera script does not set or need a random seed.

## Attribution and reuse

The survey data were originally collected by the paper's authors and are described in the archive README as **Creative Commons Attribution–NonCommercial (CC BY-NC)** licensed. Their data and code are credited here and linked to their official archive. This student project is for non-commercial academic replication. The authors' original research should not be presented as the student's work.

## Limitations

The original camera study uses 213 Dutch university students, not a representative national sample. The extension re-fits the *same observations* over a different range of constructed compensation levels; it does not remove survey respondents. Only one figure and its associated summary statistics were reproduced; Facebook, other digital services and aggregate GDP-B growth calculations were not replicated.
