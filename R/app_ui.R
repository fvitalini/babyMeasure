#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here
    dashboardPage(
      dashboardHeader(title = "babyMeasure"),
      dashboardSidebar(
        numericInput(inputId = "weight", label = "Weight", min = 0, value = 0),
        numericInput(inputId = "temperature", label = "Temperature", min = 0, value = 0),
        numericInput(inputId = "length", label = "Length", min = 0, value = 0),
        textAreaInput(inputId = "comment", label = "Journal", height = "150px"),
        actionButton(inputId = "submit", label = "Submit", style = "margin:10%")
      ),
      dashboardBody(
        tabsetPanel(
          tabPanel(title = "Weight",
                   mod_single_measure_module_ui("single_measure_module_ui_weight", param = "weight")
          ),
          tabPanel(title = "Temperature",
                   mod_single_measure_module_ui("single_measure_module_ui_temperature", param = "temperature")
          ),
          tabPanel(title = "Length",
                   mod_single_measure_module_ui("single_measure_module_ui_length", param = "length")
          ),
          tabPanel("Journal",
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){

  add_resource_path(
    'www', app_sys('app/www')
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'babyMeasure'
    )
  )
}

