# Generate random initial parameters within bounds

Draws random initialization from a uniform distribution within the
specified bounds, rejecting draws where both eta and gamma are negative
(undefined model case) or where \|eta\| \< 0.1 (near-zero exponent
causes instability).

## Usage

``` r
generate_random_init_from_bounds(lower_bounds, upper_bounds)
```

## Arguments

- lower_bounds:

  Named numeric vector of lower bounds.

- upper_bounds:

  Named numeric vector of upper bounds.

## Value

Named numeric vector of initial parameter values.
