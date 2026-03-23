# Introduction to multimix

## Overview

The `multimix` package fits **Biphasic Temporal Decomposition Logistic
Mixed Effects Models** to longitudinal binary outcome data. This model
is designed for settings where the probability of an event changes over
time in two distinct phases — an early phase and a late phase — with
subject-level variation captured by random effects.

## Setup

``` r
library(multimix)
```

## Data requirements

Input data must be in **long format** with three required columns:

- `Subject_ID`: unique identifier for each subject
- `Time`: numeric time of measurement (e.g., months post-operative)
- `Binary_outcome`: binary (0/1) outcome at each time point

``` r
data(sample_data)
head(sample_data)
#> # A tibble: 6 × 3
#>   Subject_ID   Time Binary_outcome
#>        <dbl>  <dbl>          <dbl>
#> 1          1 0.03                1
#> 2          1 0.0623              1
#> 3          1 0.0633              1
#> 4          1 0.0945              1
#> 5          1 0.263               1
#> 6          1 0.43                1
```

Let’s inspect the data structure:

``` r
cat("Subjects:", length(unique(sample_data$Subject_ID)), "\n")
#> Subjects: 44
cat("Observations:", nrow(sample_data), "\n")
#> Observations: 4743
cat("Time range:", range(sample_data$Time), "\n")
#> Time range: 0.03 142.6967
cat("Outcome prevalence:", mean(sample_data$Binary_outcome), "\n")
#> Outcome prevalence: 0.2960152
```

## Fitting the full model

The
[`multimix()`](https://michelleUMD.github.io/multimix/reference/multimix.md)
function fits the full model with two independent random effects (one
for each temporal phase). It uses multiple random initializations to
find the global optimum.

``` r
model <- multimix(sample_data, max_tries = 20, verbose = FALSE)
```

Key arguments:

- `fixed_pars`: named list of parameters to hold fixed (default:
  `list(beta0_2 = 0)`)
- `max_tries`: number of random initializations to attempt (default: 20)
- `seed`: random seed for reproducibility (default: 1234)
- `verbose`: print progress messages (default: FALSE)

## Viewing results

``` r
print(model)
```

The print method displays estimated parameters with readable names:

- `β₀₁`, `β₀₂`: baseline log-odds for early and late phases
- `a₁`, `a₂`: random effect scaling coefficients
- `σ₁`, `σ₂`: random effect standard deviations
- `t½`: half-life of each temporal function
- `η`, `γ`: shape parameters for the temporal decomposition

## Visualization

``` r
plot(model)
```

The plot shows:

- **Grey dashed lines**: subject-level fitted probability trajectories
- **Blue solid line**: population average trajectory
- **Points**: observed empirical proportions at time quantiles

## Fitting the lite model

For faster fitting or when data is limited,
[`multimix_lite()`](https://michelleUMD.github.io/multimix/reference/multimix_lite.md)
uses a single shared random effect across both phases:

``` r
model_lite <- multimix_lite(sample_data, max_tries = 20, verbose = FALSE)
print(model_lite)
plot(model_lite)
```

## Customizing bounds

You can supply custom initialization bounds to guide the optimizer:

``` r
my_lower <- lower_bounds_example
my_upper <- upper_bounds_example

# Narrow the search for half-life parameters
my_lower["log_t_half_early"] <- log(0.5)
my_upper["log_t_half_early"] <- log(5)

model_custom <- multimix(
  sample_data,
  lower_bounds = my_lower,
  upper_bounds = my_upper,
  max_tries = 30
)
```
