# multimix

`multimix` is an R package for fitting and visualizing the **Biphasic
Temporal Decomposition Logistic Mixed Effects Model** — a framework for
analyzing longitudinal binary outcomes that exhibit two temporal phases
(early and late) with subject-specific random effects.

## Model Overview

The model decomposes the conditional odds of a binary outcome into early
and late temporal components:

    Conditional odds = exp(β₀₁ + a₁·u₁) · Λ₁(t) + exp(β₀₂ + a₂·u₂) · Λ₂(t)

Where: - `Λ₁(t)` and `Λ₂(t)` are generalized temporal decomposition
functions for the early and late phases - `u₁`, `u₂` are
subject-specific random effects (or a single shared `u` in the lite
variant) - Parameters are estimated via maximum likelihood with
Gauss-Hermite quadrature

Two model variants are available: -
**[`multimix()`](https://michelleUMD.github.io/multimix/reference/multimix.md)**
— Full model with two independent random effects per subject -
**[`multimix_lite()`](https://michelleUMD.github.io/multimix/reference/multimix_lite.md)**
— Lighter model with a single shared random effect

## Installation

Install the development version from GitHub:

``` r
install.packages("devtools")
devtools::install_github("michelleUMD/multimix")
```

## Quick Start

``` r
library(multimix)

# Load example data
data(sample_data)
head(sample_data)

# Fit the full model
model <- multimix(sample_data)

# View estimated parameters
print(model)

# Visualize fitted trajectories
plot(model)
```

### Using the lite model

``` r
# Fit the lighter single-random-effect variant
model_lite <- multimix_lite(sample_data)

print(model_lite)
plot(model_lite)
```

## Data Format

Input data must be a data frame in **long format** with three required
columns:

| Column           | Type              | Description                                |
|------------------|-------------------|--------------------------------------------|
| `Subject_ID`     | integer/character | Unique subject identifier                  |
| `Time`           | numeric           | Time of measurement (e.g., months post-op) |
| `Binary_outcome` | integer (0/1)     | Binary outcome at each time point          |

## Key Parameters

| Parameter         | Description                                 |
|-------------------|---------------------------------------------|
| `β₀₁`, `β₀₂`      | Baseline log-odds for early and late phases |
| `a₁`, `a₂`        | Random effect scaling coefficients          |
| `σ₁`, `σ₂`        | Random effect standard deviations           |
| `t½` (early/late) | Half-life of the temporal functions         |
| `η` (early/late)  | Time exponent shape parameter               |
| `γ` (early/late)  | Distribution shape parameter                |

## Vignettes

- [Introduction to
  multimix](https://michelleUMD.github.io/multimix/vignettes/multimix-introduction.Rmd)
  — Basic usage tutorial
- [Understanding temporal
  decomposition](https://michelleUMD.github.io/multimix/vignettes/temporal-decomposition.Rmd)
  — Mathematical foundations
- [Full vs lite model
  comparison](https://michelleUMD.github.io/multimix/vignettes/model-comparison.Rmd)
  — When to use each variant

## Contributing

Issues and pull requests are welcome at the [GitHub
repository](https://github.com/ehrlinger/mixhazard/issues).

## Citation

If you use this package in your research, please cite:

    Fang, M. (2026). multimix: Biphasic Temporal Decomposition Logistic Mixed
      Effects Model. R package version 1.0.0.9000.
      https://github.com/ehrlinger/mixhazard
