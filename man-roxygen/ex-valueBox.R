if (interactive()) {
  library(shiny)
  library(shinydashboard)
  ui <- fluidPage(
    tagList(
      valueBoxOutput("mean_today")
    )
  )
  server <- function(input, output, session) {
    param <- "weight"

    output$mean_today <- renderValueBox({
      valueBox(
        value = paste0("Today's ", param),
        subtitle = 1,
        color = colors_param[[param]],
        icon = icon("balance-scale-right")
      )
    })
  }
  runApp(shinyApp(ui = ui, server = server), launch.browser = TRUE)
}
