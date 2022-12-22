library(dplyr)
library(tidyr)
library(ggplot2)

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
group_age$couv_complet <- rowSums(group_age[, c(
    "couv_complet_f",
    "couv_complet_h"
    )])

group_age$one_dosed <- rowSums(group_age[, c(
    "couv_dose1_f",
    "couv_dose1_h"
    )])

# Group by age to get median of couv
group_age_couv <- group_age %>%
group_by(clage_vacsi) %>%
summarise(CouvComplet=median(couv_complet/2), OneDosed=median(one_dosed/2))
# View(group_age_couv)

# Couv Men Women
group_age_couv_hf <- group_age %>%
group_by(clage_vacsi) %>%
summarise(CouvF=median(couv_complet_f), CouvH=median(couv_complet_h))
# View(group_age_couv_hf)


group_year_age <- data %>% filter(clage_vacsi > 0)
group_year_age$couv_complet <- rowSums(group_year_age[, c(
    "couv_complet_f",
    "couv_complet_h"
    )])
group_year_age <- group_year_age %>% separate(jour, into = c("year", "month", "day"), sep = "-")
group_year_age <- group_year_age %>%
group_by(clage_vacsi, year) %>%
summarise(CouvComplet=median(couv_complet/2))
group_year_age  <- group_year_age %>% filter(year != '2020')

View(group_year_age)

# X axis





ggplot(data=group_year_age,
mapping=aes(x = clage_vacsi, y = CouvComplet, fill=year)) +
geom_bar(stat = "identity", fill = "blue") +
labs(title = "Ventes de produits", x = "Produit", y = "Ventes (en euros)")