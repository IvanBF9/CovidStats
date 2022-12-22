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


sex_plot <- ggplot() +
  geom_area(data = group_age_couv_hf, aes(x = clage_vacsi, y = CouvF, fill="Femme"), color = "#FF24C27F", alpha = 0.5) +
  geom_area(data = group_age_couv_hf, aes(x = clage_vacsi, y = CouvH, fill="Homme"), color = "#3BB0FF7F", alpha = 0.5) +
  labs(title = "Difference couverture vaccinale Homme Femme", x = "Classe d'age",)



group_year_age <- data %>% filter(clage_vacsi > 0)
group_year_age$couv_complet <- rowSums(group_year_age[, c(
    "couv_complet_f",
    "couv_complet_h"
    )])
group_year_age <- group_year_age %>% separate(jour, into = c("year", "month", "day"), sep = "-")
group_year_age <- group_year_age %>%
group_by(year, clage_vacsi) %>%
summarise(CouvComplet=median(couv_complet/2))
group_year_age  <- group_year_age %>% filter(year != '2020')

# 2021
# 2022
data_one <- group_year_age %>% filter(year == '2021')
data_two <- group_year_age %>% filter(year == '2022')

year_plot <- ggplot() +
  geom_area(data = data_one, aes(x = clage_vacsi, y = CouvComplet, fill="2021"), color = "#FF24C27F", alpha = 0.5) +
  geom_area(data = data_two, aes(x = clage_vacsi, y = CouvComplet, fill="2022"), color = "#3BB0FF7F", alpha = 0.5) +
  labs(title = "Couverture vaccinale 2021 / 2022", x = "Classe d'age",)

data$couv_complet <- rowSums(data[, c(
    "couv_complet_f",
    "couv_complet_h"
    )])
reg_data <- data %>%
group_by(reg) %>%
summarise(Couv=median(couv_complet/2), reg_str = toString(reg))


reg_plot <- ggplot(reg_data, aes(x = reg_str, y = Couv, fill=reg)) +
  geom_col(position = position_dodge(0.1))

# sex_plot
# year_plot
reg_plot