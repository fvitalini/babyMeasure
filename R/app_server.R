#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @import dplyr
#' @noRd
app_server <- function(input, output, session) {
  dataset_name <- "fagiolina.rds"
  # List the first level callModules here
  callModule(mod_single_measure_module_server, "single_measure_module_ui_weight", param = "weight", data = data_reactive())
  callModule(mod_single_measure_module_server, "single_measure_module_ui_length", param = "length", data = data_reactive())
  callModule(mod_single_measure_module_server, "single_measure_module_ui_temperature", param = "temperature", data = data_reactive())

  observeEvent(input$submit, {
    # New data
    new_data <- data.frame(time = Sys.time(), weight = input$weight, temperature = input$temperature, length = input$length)

    # load data
    if (file.exists(dataset_name)) {
      data <- readRDS(dataset_name) %>%
        bind_rows(new_data)
    } else {
      data <- new_data
    }

    saveRDS(data, dataset_name)
    data_reactive <- reactive(data)
  })

}
