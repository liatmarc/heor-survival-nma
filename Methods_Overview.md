
# Methods Overview

This repository illustrates the application of simulated survival data and network meta-analysis (NMA) methods to compare the relative effectiveness of three hypothetical treatments (A, B, and C).

## Objectives

- Simulate individual patient survival data for three treatments
- Derive summary-level statistics (log hazard ratios and standard errors)
- Conduct a frequentist network meta-analysis using the `netmeta` R package
- Estimate treatment rankings and generate league tables
- Demonstrate best practices in documentation, visualization, and reproducibility

## 1. Data Simulation

The simulated dataset mimics a multi-arm clinical trial comparing treatments A, B, and C. The structure includes:

- `study_id`: Identifies each simulated study
- `treatment`: Treatment arm (A, B, or C)
- `time`: Time to event or censoring
- `event`: Event indicator (1 = event occurred, 0 = censored)

Survival times are generated from exponential distributions with specified hazard rates for each treatment group. Right censoring is introduced to simulate real-world incomplete follow-up.

## 2. Summary Statistics Calculation

The script estimates log hazard ratios (logHR) and their standard errors using Cox proportional hazards models per study comparison. These are structured into a summary-level data frame for NMA input.

## 3. Network Meta-Analysis

The `netmeta` package is used to:

- Define treatment contrasts and study-level comparisons
- Fit a fixed-effect network meta-analysis model using logHR as the effect measure
- Visualize the treatment network and results using forest plots and network diagrams

## 4. Treatment Ranking and League Table

- **P-scores** are calculated to rank treatments from most to least effective.
- A **league table** is generated to present all pairwise comparisons with confidence intervals.

## 5. Assumptions and Limitations

- The simulated data assumes proportional hazards and homogeneity across studies.
- Real-world trials may involve more complex covariate structures, heterogeneity, and missing data not addressed here.
- The NMA is performed with fixed-effect assumptions; random-effects modeling can be added for more realistic variation.

## 6. Future Work

This simulation serves as a foundation for applying population-adjusted indirect comparisons (MAIC or STC) when real patient-level trial data (e.g., BARI 2D or ACCORD) becomes available.

