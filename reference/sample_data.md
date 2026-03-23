# Example long-format binary dataset for multimix modeling

Longitudinal drug administration data for a post-operative inflammatory
medication, used as an example for biphasic temporal decomposition
modeling.

## Usage

``` r
sample_data
```

## Format

A data frame with the following variables:

- Subject_ID:

  Integer patient identifier.

- Time:

  Numeric time of measurement (months post-op).

- Binary_outcome:

  Binary indicator (0/1) of whether the patient is on the drug.

## Examples

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
table(sample_data$Binary_outcome)
#> 
#>    0    1 
#> 3339 1404 
```
