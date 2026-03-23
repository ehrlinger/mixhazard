# multimix 1.0.0.9000 (development)

## New Features

* Added `multimix_lite()`: a lighter model variant with a single shared random
  effect per subject, suitable for smaller datasets or faster convergence.
* Added `plot()` methods for both `multimix_model` and `multimix_model_lite`
  objects, producing temporal decomposition probability curves.
* Added `print()` method for `multimix_model` objects.
* Added `sample_data` dataset for examples and testing.
* Added `generate_random_init_from_bounds()` helper for random initialization
  within parameter bounds.
* Added `decompos()` for computing the temporal decomposition function.
* Added `check_df_long()` for validating input data format.

## Improvements

* Gauss-Hermite quadrature used for numerical integration in likelihood
  evaluation.
* L-BFGS-B optimization with user-configurable bounds and initial values.
* Empirical Bayes estimates of subject-specific random effects computed
  post-fitting.
* CI via GitHub Actions: R-CMD-check, lintr, and test coverage workflows.
* Full documentation with roxygen2, including parameter tables and examples.

# multimix 1.0.0

* Initial release.
