library(shiny)
library(shinythemes)

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
        column(12,
            tags$h3("Couverture vaccinale général par région"),
            plotOutput("reg_plot"),
        ),
    ),
    fluidRow(
        column(6,
            tags$h3(class="h3", "Couverture vaccinale général par région"),
            tags$style(type="text/css", ".h3{margin-top: 40px;}"),
            plotOutput("first_plot"),
        ),
        column(6,
            tags$h3(class="h3", "Couverture vaccinale général par région"),
            tags$style(type="text/css", ".h3{margin-top: 40px;}"),
            plotOutput("second_plot"),
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
    output$first_plot <- renderPlot(ggplot(reg_data, aes(x = reg_str, y = Couv, fill=reg)) + geom_col(position = position_dodge(0.1)))
    output$second_plot <- renderPlot(ggplot() +
    geom_area(data = group_age_couv_hf, aes(x = clage_vacsi, y = CouvF, fill="Femme"), color = "#FF24C27F", alpha = 0.5) +
    geom_area(data = group_age_couv_hf, aes(x = clage_vacsi, y = CouvH, fill="Homme"), color = "#3BB0FF7F", alpha = 0.5) +
    labs(title = "Difference couverture vaccinale Homme Femme", x = "Classe d'age",))
})

shinyApp(ui=ui, server=server)