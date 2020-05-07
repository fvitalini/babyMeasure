#' journal UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_journal_ui <- function(id){
  ns <- NS(id)
  tagList(

  )
}

#' journal Server Function
#'
#' @noRd
mod_journal_server <- function(input, output, session){
  ns <- session$ns

}

