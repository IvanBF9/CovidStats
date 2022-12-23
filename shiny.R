library(shiny)
library(shinythemes)

source("./main.R")

# Définition de l'interface utilisateur de notre application 
ui <- shinyUI(fluidPage(theme = shinytheme("cyborg"),
  
  # Le titre de votre application
  fluidRow(
      column(10, align="center", offset = 2,
      tags$h1("Statistiques sur le COVID-19"), 
      tags$hr(), 
      tags$style(type="text/css", "h1{text-align:center; font-size: 40px; font-weight: bold;}"),
      tags$style(type="text/css", "hr{padding: 20px;}"),
      )
   ),

  sidebarLayout(
        sidebarPanel(
        ),
        mainPanel(
            column(6, align="center", offset = 3, 
                plotOutput("vaccinPlot"),
            ),
        ),
    ),
))

server <- shinyServer(function(input, output) {
    output$vaccinPlot <- renderPlot(plot(group_age_couv_hf$clage_vacsi, group_age_couv$CouvComplet))
})

shinyApp(ui=ui, server=server)