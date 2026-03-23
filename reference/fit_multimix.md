# fit_multimix: Fit a single model using initiating parameters

This is called by
[`multimix()`](https://michelleUMD.github.io/multimix/reference/multimix.md)
using different initiating parameters

## Usage

``` r
fit_multimix(
  df_long,
  n_gh = 40,
  fixed_pars = list(),
  default_init = default_init_example,
  verbose = FALSE
)
```

## Arguments

- df_long:

  data in long format. Columns are: Subject_ID, Time, Binary_outcome

- n_gh:

  number of nodes for optimizer

- fixed_pars:

  named list of parameters to fix values (i.e. no optimization on)

- default_init:

  named list of initial parameters to try optimizing on

- verbose:

  logical.

## Value

An object of class `multimix_model`, which is a list containing at
least:

- df_long:

  The original `df_long` data frame used for fitting.

- est:

  Named numeric vector of estimated parameters.

- u_hat:

  Estimated random effects of size `[N, 2]`

- logLik:

  Numeric. Log-likelihood of the fitted model.

The object is intended to be used with S3 methods such as
[`print()`](https://rdrr.io/r/base/print.html),
[`summary()`](https://rdrr.io/r/base/summary.html), and
[`plot()`](https://rdrr.io/r/graphics/plot.default.html).
