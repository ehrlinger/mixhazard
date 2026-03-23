# Plot drug probability trajectories for a multi-mix model

This S3 method plots the estimated probabilities of drug administration
over time for each drug class, using the multimix model object.

## Usage

``` r
# S3 method for class 'multimix_model'
plot(x, ...)
```

## Arguments

- x:

  An object of class `multimix_model`, typically returned by
  [`multimix()`](https://michelleUMD.github.io/multimix/reference/multimix.md).

- ...:

  Additional arguments passed to underlying plotting functions
  (currently ignored).

## Value

`ggplot` object
