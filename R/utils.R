# Example initial parameters ----

#' Example initial parameters for the full multimix model
#' @export
default_init_example <- c(
  beta0_1 = 10,
  beta0_2 = 0,
  a1 = 1,
  a2 = 2,
  log_sigma1 = 1,
  log_sigma2 = 1,
  log_t_half_early = log(3),
  log_t_half_late = log(10),
  eta_early = 8,
  eta_late = 8,
  gamma_early = 0,
  gamma_late = 0
)

#' Example lower bounds for the full multimix model
#' @export
lower_bounds_example <- c(
  beta0_1 = -10,
  beta0_2 = -10,
  a1 = -5,
  a2 = -5,
  log_sigma1 = log(1e-4),
  log_sigma2 = log(1e-4),
  log_t_half_early = log(0.01),
  log_t_half_late = log(0.01),
  eta_early = -5,
  eta_late = -5,
  gamma_early = -5,
  gamma_late = -5
)

#' Example upper bounds for the full multimix model
#' @export
upper_bounds_example <- c(
  beta0_1 = 5,
  beta0_2 = 5,
  a1 = 4,
  a2 = 4,
  log_sigma1 = log(10),
  log_sigma2 = log(10),
  log_t_half_early = log(10),
  log_t_half_late = log(20),
  eta_early = 5,
  eta_late = 5,
  gamma_early = 5,
  gamma_late = 5
)


#' Example initial parameters for the lite multimix model
#' @export
default_init_example_lite <- c(
  beta0_1 = 10,
  beta0_2 = 0,
  a1 = 1,
  a2 = 2,
  log_sigma = 1,
  log_t_half_early = log(3),
  log_t_half_late = log(10),
  eta_early = 8,
  eta_late = 8,
  gamma_early = 0,
  gamma_late = 0
)

#' Example lower bounds for the lite multimix model
#' @export
lower_bounds_example_lite <- c(
  beta0_1 = -10,
  beta0_2 = -10,
  a1 = -5,
  a2 = -5,
  log_sigma = log(1e-4),
  log_t_half_early = log(0.01),
  log_t_half_late = log(0.01),
  eta_early = -2,
  eta_late = -2,
  gamma_early = -2,
  gamma_late = -2
)

#' Example upper bounds for the lite multimix model
#' @export
upper_bounds_example_lite <- c(
  beta0_1 = 5,
  beta0_2 = 5,
  a1 = 4,
  a2 = 4,
  log_sigma = log(10),
  log_t_half_early = log(10),
  log_t_half_late = log(20),
  eta_early = 2,
  eta_late = 2,
  gamma_early = 2,
  gamma_late = 2
)

#' Generate random initial parameters within bounds
#'
#' Draws random initialization from a uniform distribution within the
#' specified bounds, rejecting draws where both eta and gamma are negative
#' (undefined model case) or where |eta| < 0.1 (near-zero exponent causes
#' instability).
#'
#' @param lower_bounds Named numeric vector of lower bounds.
#' @param upper_bounds Named numeric vector of upper bounds.
#' @return Named numeric vector of initial parameter values.
#' @export
generate_random_init_from_bounds <- function(lower_bounds, upper_bounds) {
  repeat {
    init <- mapply(
      function(lo, hi) runif(1, lo, hi),
      lower_bounds, upper_bounds
    )

    # Make sure not both are negative (undefined)
    eta_early   <- init["eta_early"]
    eta_late    <- init["eta_late"]
    gamma_early <- init["gamma_early"]
    gamma_late  <- init["gamma_late"]

    # reject invalid draws
    early_invalid <- eta_early < 0 && gamma_early < 0
    late_invalid  <- eta_late  < 0 && gamma_late  < 0
    eta_near_zero <- abs(eta_early) < 0.1 || abs(eta_late) < 0.1
    if (early_invalid || late_invalid || eta_near_zero) {
      next
    }

    return(init)
  }
}
