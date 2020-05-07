#' single_measure_module UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param param type of measure: weight, temperature, length
#'
#' @noRd
#'
#' @import shiny
#' @import ggplot2
mod_single_measure_module_ui <- function(id, param) {
  ns <- NS(id)
  tagList(
    br(),
    fluidRow(
      mod_caseBoxes_ui(ns("mean_today")),
      mod_caseBoxes_ui(ns("mean_week")),
      mod_caseBoxes_ui(ns("mean_month"))
    ),
    br(),
    fluidRow(
      shinydashboard::box(
        width = 8, solidHeader = TRUE,
        title = "Time evolution",
        status = colors_param_status[[param]],
        plotOutput("plot_output", width = "100%", height = 600)
      ),
      shinydashboard::box(
        width = 4,
        title = "Data",
        status = colors_param_status[[param]],
        tableOutput(ns("table_output")),
        downloadButton(ns("downloadCsv"), "Download as CSV")
      )
    )
  )
}

#' single_measure_module Server Function
#' @param param type of measure: weight, temperature, length
#' @param data reactive dataset. as dataframe
#' @import shiny
#' @import shinydashboard
#' @importFrom stats time
#' @importFrom utils write.csv
#' @noRd
mod_single_measure_module_server <- function(input, output, session, param, data){
  ns <- session$ns

  # Data ----
  counts <- reactive({data.frame(mean_today = 1, mean_week = 2, mean_month = 3)})

  # Boxes ----
  callModule(mod_caseBoxes_server, "mean_today", counts)
  callModule(mod_caseBoxes_server, "mean_week", counts)
  callModule(mod_caseBoxes_server, "mean_month", counts)

  # Plot ----
  output$plot_output <- renderPlot(
    ggplot(data, aes(x = time, y = param)) +
      geom_line() +
      geom_point()
  )

  # Table ----
  output$table_output <- renderDataTable(data())

  output$downloadCsv <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep = '')
    },
    content = function(con) {
      write.csv(data, con)
    }
  )

}
