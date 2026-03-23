# Package index

## Model Fitting

Fit the biphasic temporal decomposition logistic mixed effects model.
Use
[`multimix()`](https://michelleUMD.github.io/multimix/reference/multimix.md)
for two independent random effects per subject, or
[`multimix_lite()`](https://michelleUMD.github.io/multimix/reference/multimix_lite.md)
for a single shared random effect.

- [`multimix()`](https://michelleUMD.github.io/multimix/reference/multimix.md)
  : multimix: Find optimal model using several initiating parameters
- [`multimix_lite()`](https://michelleUMD.github.io/multimix/reference/multimix_lite.md)
  : multimix_lite: Find optimal lighter model using several initiating
  parameters

## S3 Methods

Print and plot methods for fitted model objects.

- [`print(`*`<multimix_model>`*`)`](https://michelleUMD.github.io/multimix/reference/print.multimix_model.md)
  : Print method for multi-mix model objects
- [`plot(`*`<multimix_model>`*`)`](https://michelleUMD.github.io/multimix/reference/plot.multimix_model.md)
  : Plot drug probability trajectories for a multi-mix model
- [`plot(`*`<multimix_model_lite>`*`)`](https://michelleUMD.github.io/multimix/reference/plot.multimix_model_lite.md)
  : Plot simplified drug probability trajectories for a multi-mix lite
  model

## Temporal Decomposition

Core functions for the early- and late-phase temporal components.

- [`decompos()`](https://michelleUMD.github.io/multimix/reference/decompos.md)
  : Temporal decomposition function
- [`get_early_phase()`](https://michelleUMD.github.io/multimix/reference/get_early_phase.md)
  : Get early phase temporal component (density)
- [`get_late_phase()`](https://michelleUMD.github.io/multimix/reference/get_late_phase.md)
  : Get late phase temporal component (hazard)

## Initialization & Bounds

Default initial parameter values and search bounds for optimization,
plus a helper to sample random starting points.

- [`default_init_example`](https://michelleUMD.github.io/multimix/reference/default_init_example.md)
  : Example initial parameters for the full multimix model
- [`default_init_example_lite`](https://michelleUMD.github.io/multimix/reference/default_init_example_lite.md)
  : Example initial parameters for the lite multimix model
- [`lower_bounds_example`](https://michelleUMD.github.io/multimix/reference/lower_bounds_example.md)
  : Example lower bounds for the full multimix model
- [`upper_bounds_example`](https://michelleUMD.github.io/multimix/reference/upper_bounds_example.md)
  : Example upper bounds for the full multimix model
- [`lower_bounds_example_lite`](https://michelleUMD.github.io/multimix/reference/lower_bounds_example_lite.md)
  : Example lower bounds for the lite multimix model
- [`upper_bounds_example_lite`](https://michelleUMD.github.io/multimix/reference/upper_bounds_example_lite.md)
  : Example upper bounds for the lite multimix model
- [`generate_random_init_from_bounds()`](https://michelleUMD.github.io/multimix/reference/generate_random_init_from_bounds.md)
  : Generate random initial parameters within bounds

## Data & Utilities

Example dataset and input validation helper.

- [`sample_data`](https://michelleUMD.github.io/multimix/reference/sample_data.md)
  : Example long-format binary dataset for multimix modeling
- [`check_df_long()`](https://michelleUMD.github.io/multimix/reference/check_df_long.md)
  : Validate input data frame for multimix model fitting
