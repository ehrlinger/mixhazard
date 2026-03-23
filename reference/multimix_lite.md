# multimix_lite: Find optimal lighter model using several initiating parameters

Due to many undefined cases of the generic function and the lack of an
empirical solution to the optimizer, this function will retry several
initiating parameters and find the most optimal model. Contrary to the
full model, this model only fits a single random effect and uses a
scaling coefficient to approximate the second random effect.

## Usage

``` r
multimix_lite(
  df_long,
  fixed_pars = list(beta0_2 = 0),
  lower_bounds = lower_bounds_example_lite,
  upper_bounds = upper_bounds_example_lite,
  max_tries = 20,
  return_first_success = FALSE,
  return_first_sucess = NULL,
  verbose = FALSE,
  seed = 1234
)
```

## Arguments

- df_long:

  data in long format. Columns are: Subject_ID, Time, Binary_outcome

- fixed_pars:

  named list of parameters to fix values (i.e. no optimization on)

- lower_bounds:

  named list of lower bounds to guess initial params within

- upper_bounds:

  named list of upper bounds to guess initial params within

- max_tries:

  number of initial params to be tried

- return_first_success:

  logical. If `TRUE` then first model that works will be returned.
  Otherwise will exhaust the full number of retries to find the most
  optimal solution.

- return_first_sucess:

  Deprecated. Use `return_first_success` instead.

- verbose:

  logical. If `TRUE` then error messages will be displayed for each
  failed attempt

- seed:

  random number generator seed

## Value

An object of class `multimix_model_lite`, which is a list containing at
least:

- df_long:

  The original `df_long` data frame used for fitting.

- est:

  Named numeric vector of estimated parameters.

- u_hat:

  Named numeric vector of empirical Bayes random effects, one value per
  subject (length N).

- logLik:

  Numeric. Log-likelihood of the fitted model.

The object is intended to be used with S3 methods such as
[`print()`](https://rdrr.io/r/base/print.html),
[`summary()`](https://rdrr.io/r/base/summary.html), and
[`plot()`](https://rdrr.io/r/graphics/plot.default.html).
