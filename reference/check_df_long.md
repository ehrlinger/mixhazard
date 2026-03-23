# Validate input data frame for multimix model fitting

Checks that the input data frame has the required structure and content.

## Usage

``` r
check_df_long(df_long)
```

## Arguments

- df_long:

  A data frame in long format with columns: Subject_ID, Time,
  Binary_outcome.

## Value

Invisibly returns TRUE if all checks pass.
