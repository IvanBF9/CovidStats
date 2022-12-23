library(shiny)
library(shinythemes)

source("./main.R")

# Définition de l'interface utilisateur de notre application 
ui <- shinyUI(fluidPage(theme = shinytheme("slate"),
  
  # Le titre de votre application
  fluidRow(
        width = 12,
      tags$h1("Statistiques sur le COVID-19"), 
      tags$hr(), 
      tags$style(type="text/css", "h1{text-align:center; font-size: 40px; font-weight: bold;}"),
      tags$style(type="text/css", "hr{padding: 20px;}"),
   ),

  sidebarLayout(
        sidebarPanel(width = 6,
            tags$h3("Statistiques sur le COVID-19"),
            plotOutput("vaccinPlot")
        ),
        mainPanel(width = 6,
            tags$h3("Statistiques sur le COVID-19")
        )
    ),
))

server <- shinyServer(function(input, output) {
    output$vaccinPlot <- renderPlot(plot(group_age_couv_hf$clage_vacsi, group_age_couv$CouvComplet))
})

shinyApp(ui=ui, server=server)