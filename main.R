library(dplyr)
data <- read.csv(file = "vacsi-s-a-reg-2022-12-19-19h00.csv",sep = ";", header =TRUE)


data <- na.omit(data)

names(data)
View(data)

mean(data$clage_vacsi)