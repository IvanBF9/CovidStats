library(shiny)
library(shinythemes)
library(gridExtra)


source("main.R")

# Définition de l'interface utilisateur de notre application 
ui <- shinyUI(fluidPage(theme = shinytheme("slate"),
  
  # Le titre de notre application
  fluidRow(
    width = 12,
    tags$h1("Statistiques sur le COVID-19"), 
    tags$hr(), 
    tags$style(type="text/css", "h1{text-align:center; font-size: 40px; font-weight: bold;}"),
    tags$style(type="text/css", "hr{padding: 20px;}")
   ),

  sidebarLayout(
        sidebarPanel(width = 6,
            tags$h3("Couverture vaccinale général pour les années 2021/2022"),
            plotOutput("year_plot")
        ),
        mainPanel(width = 6,
            tags$h3(id="h3","Couverture vaccinale général par sexe H/F"),
            tags$style(type="text/css", "#h3{margin-top: 40px;}"),
            plotOutput("sex_plot")
        ),
    ),
    fluidRow(
        column(10,
            tags$h3("Couverture vaccinale général par région"),
            plotOutput("reg_plot"),
        ),
        column(2,
            tags$h3("Min Max"),
            tags$style(type="text/css", ".h3{margin-top: 40px;}"),
            plotOutput("regions_abt"),
        ),
    
    ),
    # fluidRow(
    #     column(6,
    #         tags$h3(class="h3", "Couverture vaccinale général par région"),
    #         tags$style(type="text/css", ".h3{margin-top: 40px;}"),
    #         plotOutput("guyanne_plot"),
    #     ),
    #     column(6,
    #         tags$h3(class="h3", "Couverture vaccinale général par région"),
    #         tags$style(type="text/css", ".h3{margin-top: 40px;}"),
    #         plotOutput("auvergne_plot"),
    #     ),
    # ),
    fluidRow(
        column(6,
            tags$h3(class="h3", "Comparaison entre la couverture vaccinale et ceux qui ont reçu au moins une dose année 2021"),
            tags$style(type="text/css", ".h3{margin-top: 40px;}"),
            plotOutput("diff_couv_dose_plot_2021"),
        ),
        column(6,
            tags$h3(class="h3", "Comparaison entre la couverture vaccinale et ceux qui ont reçu au moins une dose année 2022"),
            tags$style(type="text/css", ".h3{margin-top: 40px;}"),
            plotOutput("diff_couv_dose_plot_2022"),
        ),
    ),
    fluidRow(
        column(12,
            tags$p("Made with ❤ by Louis Poulin & Ivan Braga Fernandes"),
            tags$style(type="text/css", "p{margin-top: 40px;background-color: #1C1E22; padding: 20px; width: 100%; text-align: center;}"),
        ),
    ),
))

server <- shinyServer(function(input, output) {
    output$reg_plot <- renderPlot({reg_plot})
    output$sex_plot <- renderPlot({sex_plot})
    output$year_plot <- renderPlot({year_plot})
    # output$guyanne_plot <- renderPlot({guyanne_plot})
    # output$auvergne_plot <- renderPlot({auvergne_plot})
    output$diff_couv_dose_plot_2021 <- renderPlot({diff_couv_dose_plot_2021})
    output$diff_couv_dose_plot_2022 <- renderPlot({diff_couv_dose_plot_2022})

    output$regions_abt <- renderPlot({grid.arrange(guyanne_plot, auvergne_plot, nrow = 2)})
})

shinyApp(ui=ui, server=server)