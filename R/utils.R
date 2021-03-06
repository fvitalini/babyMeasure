#' Inverted versions of in, is.null and is.na
#'
#' @noRd
#'
#' @examples
#' 1 %not_in% 1:10
#' not_null(NULL)
`%not_in%` <- Negate(`%in%`)

not_null <- Negate(is.null)

not_na <- Negate(is.na)

#' Global variables
#'
#' @noRd
#'
colors_param <- list(
  weight = "#00c0ef",
  temperature = "#f39c12",
  length = "#00a65a"
)

#' Global variables
#'
#' @noRd
#'
colors_param_status <- list(
  weight = "info",
  temperature = "success",
  length = "warning"
)
