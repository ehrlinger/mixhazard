# Temporal decomposition function

Computes cumulative distribution (capgt), density (gt), and hazard (ht)
for the generalized temporal decomposition model parameterized by
half-life, exponent nu (eta), and shape m (gamma).

## Usage

``` r
decompos(time, thalf, nu, m, complet)
```

## Arguments

- time:

  Numeric vector of time values.

- thalf:

  Half-life parameter for the temporal function.

- nu:

  Exponent of time (eta in model notation).

- m:

  Exponent of the entire function (gamma in model notation).

- complet:

  Integer flag for complete (1) vs incomplete (0) distribution
  (currently unused).

## Value

A list with components: capgt (cumulative), gt (density/early phase), ht
(hazard/late phase).

## Details

Handles 6 valid parameter combinations based on signs of m and nu. The
case where both m \< 0 and nu \< 0 is undefined and will raise an error.
