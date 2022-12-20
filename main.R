library(dplyr)
data <- read.csv(file = "vacsi-s-a-reg-2022-12-19-19h00.csv",sep = ";", header =TRUE)

# data <- na.omit(data)
# data <- data[!apply(data[-1:-3], 1, function(x) all(x == 0)), ]
names(data)
View(data[1])

#mean(data$clage_vacsi)