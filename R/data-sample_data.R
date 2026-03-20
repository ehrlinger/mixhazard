#' Example long-format binary dataset for multimix modeling
#'
#' Longitudinal drug administration data for a post-operative inflammatory
#' medication, used as an example for biphasic temporal decomposition modeling.
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{Subject_ID}{Integer patient identifier.}
#'   \item{Time}{Numeric time of measurement (months post-op).}
#'   \item{Binary_outcome}{Binary indicator (0/1) of whether the patient is on the drug.}
#' }
#' @examples
#' data(sample_data)
#' head(sample_data)
#' table(sample_data$Binary_outcome)
"sample_data"
