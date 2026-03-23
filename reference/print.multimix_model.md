# Print method for multi-mix model objects

This S3 method prints a nicely formatted table of estimated parameters
from a `multimix_model` or `multimix_model_lite` object.

## Usage

``` r
# S3 method for class 'multimix_model'
print(x, ...)
```

## Arguments

- x:

  An object of class `multimix_model` or `multimix_model_lite`,
  typically returned by
  [`multimix()`](https://michelleUMD.github.io/multimix/reference/multimix.md)
  or its lite variant.

- ...:

  Additional arguments (currently ignored) to allow method dispatch
  compatibility.

## Value

Invisibly returns the original object `x`.
