#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_server <- function(input, output, session) {
  # List the first level callModules here
  callModule(mod_single_measure_module_server, "single_measure_module_ui_weight", param = "weight")
  callModule(mod_single_measure_module_server, "single_measure_module_ui_length", param = "length")
  callModule(mod_single_measure_module_server, "single_measure_module_ui_temperature", param = "temperature")
}
