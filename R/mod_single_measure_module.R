#' single_measure_module UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param param measure parameter. Character string
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import shinydashboard
#' @import ggplot2
mod_single_measure_module_ui <- function(id, param) {
  ns <- NS(id)
  tagList(
    br(),
    fluidRow(
      valueBoxOutput(ns("mean_today")),
      valueBoxOutput(ns("mean_week")),
      valueBoxOutput(ns("mean_month"))
    ),
    br(),
    fluidRow(
      box(
        width = 8, solidHeader = TRUE,
        title = "Time evolution",
        status = colors_param[param],
        plotOutput("plot_output", width = "100%", height = 600)
      ),
      box(
        width = 4,
        title = "Data",
        status = colors_param[param],
        tableOutput(ns("table_output")),
        downloadButton(ns("downloadCsv"), "Download as CSV")
      )
    )
  )
}

#' single_measure_module Server Function
#' @param data reactive dataset. as dataframe
#' @noRd
mod_single_measure_module_server <- function(input, output, session, param, data){
  ns <- session$ns
  output$mean_today <- renderValueBox({
    valueBox(
      paste0("Today's ", param),
      1,
      color = colors_param[param],
      icon = icon("balance-scale-right")
    )
  })
  output$mean_week <- renderValueBox({
    valueBox(
      paste0("Week's ", param),
      1,
      color = colors_param[param],
      icon = icon("balance-scale-right")
    )
  })
  output$mean_month <- renderValueBox({
    valueBox(
      paste0("Month's ", param),
      1,
      color = colors_param[param],
      icon = icon("balance-scale-right")
    )
  })

  output$plot_output <- renderPlot(
    ggplot(data, aes(x = time, y = param)) +
      geom_line() +
      geom_point()
  )

  output$table_output <- renderDataTable(data)

  output$downloadCsv <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep = '')
    },
    content = function(con) {
      write.csv(data, con)
    }
  )

}

## To be copied in the UI
# mod_single_measure_module_ui("single_measure_module_ui_1")

## To be copied in the server
# callModule(mod_single_measure_module_server, "single_measure_module_ui_1")

