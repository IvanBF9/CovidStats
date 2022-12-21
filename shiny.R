library(shiny)

# Définition de l'interface utilisateur de notre application 
ui <- shinyUI(fluidPage(
  
  # Le titre de votre application
  titlePanel("Aperçu d'un dataset"),
  
  #Indiquer le 'layout' de votre application : autrement dit le squelette visuel de l'application 
  sidebarLayout(
    #Composants de la région gauche de l'application 
    sidebarPanel(
      #Ici, nous insérons un champ pour entrer un chiffre, ainsi qu'un menu déroulant
      textInput(inputId = "lignes", 
                  label = "Combien de lignes voulez-vous voir ? ", 
                  value = 10), 
      selectInput(inputId = "labs", 
                  label = "Dataset", 
                  choice = c("cars","rock","beaver1", "sleep")
                  )
    ),
    
    #Ici, nous indiquons l'élement qui sera présent dans la fenêtre principale : l'element "dataset", qui est un graph 
    mainPanel(
      tableOutput("dataset")
    )
)))

server <- shinyServer(function(input, output) {
  #On retrouve ici l'élement "dataset", qui communique avec ui par 'output'. 
  output$dataset <- renderTable({
    #Nous imprimons les éléments d'après les données en entrée : ces derniers sont appellés avec `ìnput` puis le nom de la composante de ui (ici 'labs' et 'lignes')
   if(input$labs == "cars"){
     print(head(cars, input$lignes))
   } else if(input$labs == "rock"){
     print(head(rock, input$lignes))
  } else if(input$labs == "sleep"){
     print(head(sleep, input$lignes))
  } else {
     print(head(beaver1, input$lignes))
   }
  })
})

shinyApp(ui, server)