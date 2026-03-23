# Display Results ----

## Table of coefficients ----

var_to_english_dict <- c(
  a1 = "a\u2081 (early)",
  a2 = "a\u2082 (late)",

  beta0_1 = "\u03b2\u2080\u2081 (early)",
  beta0_2 = "\u03b2\u2080\u2082 (late)",

  t_half_early = "t\u00bd (early)",
  t_half_late  = "t\u00bd (late)",

  eta_early   = "\u03b7 (early)",
  eta_late    = "\u03b7 (late)",

  gamma_early = "\u03b3 (early)",
  gamma_late  = "\u03b3 (late)",

  sigma = "\u03c3",
  sigma1 = "\u03c3\u2081 (early)",
  sigma2 = "\u03c3\u2082 (late)"
)

#' Print method for multi-mix model objects
#'
#' This S3 method prints a nicely formatted table of estimated parameters
#' from a `multimix_model` or `multimix_model_lite` object.
#'
#' @param x An object of class `multimix_model` or `multimix_model_lite`,
#'          typically returned by `multimix()` or its lite variant.
#' @param ... Additional arguments (currently ignored) to allow method
#'   dispatch compatibility.
#'
#' @return Invisibly returns the original object `x`.
#' @export
#' @method print multimix_model
print.multimix_model <- function(x, ...) {
  est <- x$est

  est_long <- data.frame(
    parameter = names(est),
    estimate  = unname(est),
    stringsAsFactors = FALSE
  )

  est_long$parameter <- ifelse(
    est_long$parameter %in% names(var_to_english_dict),
    var_to_english_dict[est_long$parameter],
    est_long$parameter
  )

  rownames(est_long) <- est_long$parameter
  est_long$parameter <- NULL

  print(round(est_long, 2), ...)

  invisible(x)
}


# Export the lite class method
#' @export
#' @method print multimix_model_lite
print.multimix_model_lite <- print.multimix_model


# Plotting functions ----
#' Plot drug probability trajectories for a multi-mix model
#'
#' This S3 method plots the estimated probabilities of drug administration
#' over time for each drug class, using the multimix model object.
#'
#' @param x An object of class `multimix_model`, typically returned
#'   by `multimix()`.
#' @param ... Additional arguments passed to underlying plotting functions
#'   (currently ignored).
#'
#' @return `ggplot` object
#' @export
#' @method plot multimix_model
plot.multimix_model <- function(x, ...) {
  plot_drug_probabilities(x, ...)
}

#' Plot simplified drug probability trajectories for a multi-mix lite model
#'
#' This S3 method plots the estimated probabilities of drug administration
#' over time for each drug class, using the lite multimix model object.
#'
#' @param x An object of class `multimix_model_lite`, typically returned
#'   by `multimix_lite()`.
#' @param ... Additional arguments passed to underlying plotting functions
#'   (currently ignored).
#'
#' @return `ggplot` object
#' @export
#' @method plot multimix_model_lite
plot.multimix_model_lite <- function(x, ...) {
  plot_drug_probabilities_lite(x, ...)
}
