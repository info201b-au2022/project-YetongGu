#This is a summary table for data we used in source

library(tidyverse)

temperature <- read.csv("data/GlobalLandTemperaturesByMajorCity.csv")
co2 <- read.csv("data/historical_emissions.csv")

temperature <- mutate(temperature, dt = substr(dt, 1, 4)) %>%
    select(c(dt, AverageTemperature, AverageTemperatureUncertainty, Country)) %>%
    filter(Country %in% c("China", "Brazil", "United Kingdom", "United States", "Australia", "South Africa"))

Brazil <- filter(temperature, Country == "Brazil") %>%
    group_by(dt) %>%
    summarise(Brazil_Celsius = mean(AverageTemperature), Brazil_Uncertain_Celsius = mean(AverageTemperatureUncertainty))

China <- filter(temperature, Country == "China") %>%
    group_by(dt) %>%
    summarise(China_Celsius = mean(AverageTemperature), China_Uncertain_Celsius = mean(AverageTemperatureUncertainty))

US <- filter(temperature, Country == "United States") %>%
    group_by(dt) %>%
    summarise(United_States_Celsius = mean(AverageTemperature), US_Uncertain_Celsius = mean(AverageTemperatureUncertainty))

UK <- filter(temperature, Country == "United Kingdom") %>%
    group_by(dt) %>%
    summarise(United_Kingdom_Celsius = mean(AverageTemperature), UK_Uncertain_Celsius = mean(AverageTemperatureUncertainty))

Australia <- filter(temperature, Country == "Australia") %>%
    group_by(dt) %>%
    summarise(Australia_Celsius = mean(AverageTemperature), Australia_Uncertain_Celsius = mean(AverageTemperatureUncertainty))

SA <- filter(temperature, Country == "South Africa") %>%
    group_by(dt) %>%
    summarise(South_Africa_Celsius = mean(AverageTemperature), SA_Uncertain_Celsius = mean(AverageTemperatureUncertainty))

#chart1 contains Brazil, China, US, UK, Australia and South Africa mean
#temperature and mean Uncertainty in each year from 1832 to 2013, using
#Celsius degree
chart1 <- left_join(Brazil, China, by = "dt") %>%
    left_join(US, by = "dt") %>%
    left_join(UK, by = "dt") %>%
    left_join(Australia, by = "dt") %>%
    left_join(SA, by = "dt")

#chart2 contains Brazil, China, US, UK, Australia and South Africa co2 emission by kiloton
chart2 <- filter(co2, Country %in% c("China", "Brazil", "United Kingdom", "United States", "Australia", "South Africa")) %>%
    select(-c(Data.source, Sector, Unit, Gas))