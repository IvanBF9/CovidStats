library(dplyr)

# Read csv
data <- read.csv(file = "vacsi-s-a-reg-2022-12-19-19h00.csv", sep=";", header=TRUE)

# Drop na
data <- na.omit(data)

# get name of columns
names(data)

# Remove clage_vacsi 0 (all ages)
group_age <- data %>% filter(clage_vacsi > 0)
# group_age <- group_age %>% group_by(clage_vacsi)


# Concat all couv in one
group_age$couv_complet <- do.call(paste, group_age[, c(
    "couv_complet_e",
    "couv_complet_f",
    "couv_complet_h"
    )])

# Group by age to get median of couv
group_age <- group_age %>%
group_by(clage_vacsi)%>%
summarise(Median=median(couv_complet))

View(group_age)