library(tidyverse)
library(dplyr)

temperature <- read.csv("data/GlobalLandTemperaturesByMajorCity.csv")
co2 <- read.csv("data/historical_emissions.csv")
View(temperature)


highest_temperature <- temperature %>%
  filter(AverageTemperature == max(AverageTemperature, na.rm = TRUE)) %>%
  pull(AverageTemperature)
lowest_temperature <- temperature %>%
  filter(AverageTemperature == min(AverageTemperature, na.rm = TRUE)) %>%
  pull(AverageTemperature)


temperature <- mutate(temperature, dt = substr(dt, 1, 4)) %>%
  select(c(dt, AverageTemperature, Country)) %>%
  filter(Country %in% c("China", "Brazil", "United Kingdom", "United States", "Australia", "South Africa"))

main_highest_temperature <- temperature %>%
  group_by(Country) %>%
  arrange((AverageTemperature), .by_group = TRUE) %>%
  filter(row_number()==1)
View(main_highest_temperature)
lowest_temperature <- main_highest_temperature %>%
  filter(AverageTemperature == min(AverageTemperature, na.rm = TRUE)) %>%
  pull(AverageTemperature)


View(co2)
highest_co2 <- co2 %>%
  filter(X2018 == max(X2018, na.rm = TRUE)) %>%
  pull(X2018)
lowest_co2 <- co2 %>%
  filter(X1990 == min(X1990, na.rm = TRUE)) %>%
  pull(X1990)







