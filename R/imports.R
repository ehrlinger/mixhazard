#' @import dplyr
#' @import tidyr
#' @import ggplot2
#' @import statmod
#' @importFrom stats optim quantile runif
#' @importFrom utils capture.output
NULL

# Suppress R CMD check NOTEs for NSE variables used in dplyr/ggplot2
utils::globalVariables(
  c(
    "Time",
    "Fitted",
    "time_quartile",
    "Binary_outcome",
    "Subject_ID",
    "Average_Fitted",
    "Prop_TRUE"
  )
)
