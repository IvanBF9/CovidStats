library(dplyr)
data <- read.csv(file = "vacsi-s-a-reg-2022-12-19-19h00.csv")

View(data)

mean(data$clage_vacsi)