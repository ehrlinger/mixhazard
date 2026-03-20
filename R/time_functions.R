#' Temporal decomposition function
#'
#' Computes cumulative distribution (capgt), density (gt), and hazard (ht)
#' for the generalized temporal decomposition model parameterized by
#' half-life, exponent nu (eta), and shape m (gamma).
#'
#' @param time Numeric vector of time values.
#' @param thalf Half-life parameter for the temporal function.
#' @param nu Exponent of time (eta in model notation).
#' @param m Exponent of the entire function (gamma in model notation).
#' @param complet Integer flag for complete (1) vs incomplete (0) distribution
#'   (currently unused).
#' @return A list with components: capgt (cumulative), gt (density/early
#'   phase), ht (hazard/late phase).
#' @details
#' Handles 6 valid parameter combinations based on signs of m and nu.
#' The case where both m < 0 and nu < 0 is undefined and will raise an error.
#' @export
decompos <- function(time, thalf, nu, m, complet) {

  if (m != 0) mm1 <- -(1 / m) - 1
  if (nu != 0) num1 <- -(1 / nu) - 1

  # Case 1: m > 0, nu > 0
  if (m > 0 && nu > 0) {
    rho <- nu * thalf * ((((2^m) - 1) / m)^nu)
    bt <- nu * time / rho
    btnu <- 1 + m * (bt^(-1 / nu))
    capgt <- btnu^(-1 / m)
    gt <- (btnu^mm1) * (bt^num1) / rho
  } else if (m == 0 && nu > 0) { # Limiting Case 1: m = 0, nu > 0
    rho <- nu * thalf * (log(2)^nu)
    bt <- nu * time / rho
    btnu <- bt^(-1 / nu)
    capgt <- exp(-btnu)
    gt <- capgt * (bt^num1) / rho
  } else if (m < 0 && nu > 0) { # Case 2: m < 0, nu > 0
    rho <- nu * thalf / (((1 - 2^m)^(-nu)) - 1)
    bt <- 1 + nu * time / rho
    btnu <- 1 - bt^(-1 / nu)
    capgt <- btnu^(-1 / m)
    gt <- -(btnu^mm1) * (bt^num1) / (m * rho)
  } else if (m < 0 && nu == 0) { # Limiting Case 2: m < 0, nu = 0
    rho <- -thalf / (log(1 - 2^m))
    bt <- exp(-time / rho)
    btm <- (1 - bt)
    capgt <- btm^(-1 / m)
    gt <- -(btm^mm1) * bt / (m * rho)
  } else if (m > 0 && nu < 0) { # Case 3: m > 0, nu < 0
    rho <- -nu * thalf * (((2^m) - 1)^(nu))
    bt <- -nu * time / rho
    btnu <- 1 + m * (bt^(-1 / nu))
    capgt <- 1 - (btnu^(-1 / m))
    gt <- (btnu^mm1) * (bt^num1) / rho
  } else if (m == 0 && nu < 0) { # Limiting Case 3: m = 0, nu < 0
    rho <- -nu * thalf * (log(2)^nu)
    bt <- -nu * time / rho
    btnu <- bt^(-1 / nu)
    capgt <- 1 - exp(-btnu)
    gt <- exp(-btnu) * (bt^num1) / rho
  } else {
    stop(
      "Generic function undefined for m/gamma < 0 and nu/eta < 0: m = ",
      m, ", nu = ", nu
    )
  }

  ht <- gt / (1 - capgt)

  list(capgt = capgt, gt = gt, ht = ht)
}

#' Get early phase temporal component (density)
#'
#' @param time Numeric vector of time values.
#' @param thalf Half-life parameter.
#' @param eta Exponent of time (nu in decompos notation). Default 1.
#' @param gamma Shape parameter (m in decompos notation). Default 0.
#' @return Numeric vector of early phase density values.
#' @export
get_early_phase <- function(time, thalf, eta = 1, gamma = 0) {
  decompos(time, thalf, nu = eta, m = gamma, complet = 1)$gt
}

#' Get late phase temporal component (hazard)
#'
#' @param time Numeric vector of time values.
#' @param thalf Half-life parameter.
#' @param eta Exponent of time (nu in decompos notation).
#' @param gamma Shape parameter (m in decompos notation). Default 0.
#' @return Numeric vector of late phase hazard values.
#' @export
get_late_phase <- function(time, thalf, eta, gamma = 0) {
  decompos(time, thalf, nu = eta, m = gamma, complet = 1)$ht
}
