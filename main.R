library(dplyr)

# Read csv
data <- read.csv(file = "vacsi-s-a-reg-2022-12-19-19h00.csv", sep=";", header=TRUE)

# Drop na
data <- na.omit(data)

# get name of columns and display df
names(data)
View(data)

mean(data$clage_vacsi)
