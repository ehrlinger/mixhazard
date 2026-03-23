# Plot simplified drug probability trajectories for a multi-mix lite model

This S3 method plots the estimated probabilities of drug administration
over time for each drug class, using the lite multimix model object.

## Usage

``` r
# S3 method for class 'multimix_model_lite'
plot(x, ...)
```

## Arguments

- x:

  An object of class `multimix_model_lite`, typically returned by
  [`multimix_lite()`](https://michelleUMD.github.io/multimix/reference/multimix_lite.md).

- ...:

  Additional arguments passed to underlying plotting functions
  (currently ignored).

## Value

`ggplot` object
