# Full vs Lite Model Comparison

``` r
library(multimix)
data(sample_data)
```

## Two model variants

The `multimix` package provides two model variants that differ in their
random effects structure:

### Full model (`multimix()`)

- **Two independent random effects**
  $u_{1},u_{2} \sim N\left( 0,\sigma_{1}^{2} \right),N\left( 0,\sigma_{2}^{2} \right)$
- $u_{1}$ scales the early phase, $u_{2}$ scales the late phase
  independently
- Uses 2D Gauss-Hermite quadrature for numerical integration
- **12 parameters** (before fixing):
  $\beta_{01},\beta_{02},a_{1},a_{2},\sigma_{1},\sigma_{2},t_{1/2}^{early},t_{1/2}^{late},\eta^{early},\eta^{late},\gamma^{early},\gamma^{late}$

### Lite model (`multimix_lite()`)

- **Single shared random effect** $u \sim N\left( 0,\sigma^{2} \right)$
- The same $u$ scales both phases (via different coefficients
  $a_{1},a_{2}$)
- Uses 1D Gauss-Hermite quadrature (faster)
- **11 parameters** (before fixing): same as full model but with a
  single $\sigma$ instead of $\sigma_{1},\sigma_{2}$

## When to use each

| Scenario                                  | Recommended model                                 |
|-------------------------------------------|---------------------------------------------------|
| Large dataset (many subjects)             | Full model — can estimate two variance components |
| Small dataset (\< 30 subjects)            | Lite model — fewer parameters, more stable        |
| Exploratory analysis                      | Lite model — faster convergence                   |
| Strong prior that phases are correlated   | Lite model — shared random effect encodes this    |
| Phases are driven by different mechanisms | Full model — allows independent subject variation |
| Publication/final analysis                | Try both and compare via log-likelihood           |

## Comparing models

``` r
# Fit both models
full_model <- multimix(sample_data, verbose = FALSE)
lite_model <- multimix_lite(sample_data, verbose = FALSE)

# Compare log-likelihoods
cat("Full model logLik:", full_model$logLik, "\n")
cat("Lite model logLik:", lite_model$logLik, "\n")
cat("Difference:", full_model$logLik - lite_model$logLik, "\n")
```

The full model will always have a log-likelihood at least as high as the
lite model (since it is a more flexible model). However, if the
improvement is small, the lite model may be preferred for parsimony.

## Parameter interpretation differences

### Full model

``` r
print(full_model)
```

In the full model, $\sigma_{1}$ and $\sigma_{2}$ represent the standard
deviation of between-subject variation in the early and late phases
respectively. A large $\sigma_{1}$ with small $\sigma_{2}$ suggests
subjects differ mainly in their early phase response.

### Lite model

``` r
print(lite_model)
```

In the lite model, the single $\sigma$ captures overall between-subject
variation. The coefficients $a_{1}$ and $a_{2}$ determine how much of
this variation is expressed in each phase.

## Visual comparison

``` r
library(ggplot2)

p_full <- plot(full_model) + ggtitle("Full Model (two random effects)")
p_lite <- plot(lite_model) + ggtitle("Lite Model (single random effect)")

print(p_full)
print(p_lite)
```

Look for:

- **Subject-level curves**: More spread in the full model suggests the
  two random effects capture additional variability
- **Population average**: Should be similar between models if the data
  is well-behaved
- **Fit to observed data**: Compare how closely the points (empirical
  proportions) track the blue line

## Computational considerations

| Aspect              | Full model                               | Lite model                           |
|---------------------|------------------------------------------|--------------------------------------|
| Quadrature          | 2D ($n_{GH}^{2}$ evaluations)            | 1D ($n_{GH}$ evaluations)            |
| Per-subject cost    | $O\left( n_{GH}^{2} \cdot T_{i} \right)$ | $O\left( n_{GH} \cdot T_{i} \right)$ |
| Typical convergence | Slower, more retries                     | Faster, fewer retries                |
| Default nGH = 40    | 1,600 evaluations/subject                | 40 evaluations/subject               |

For large datasets, consider starting with the lite model to get
reasonable initial parameter estimates, then using those to inform the
bounds for the full model.
