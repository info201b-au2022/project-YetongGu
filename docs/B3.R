library(tidyverse)

temp <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-YetongGu/main/data/GlobalLandTemperaturesByMajorCity.csv")
co2 <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-YetongGu/main/data/historical_emissions.csv")

temp <- mutate(temp, dt = substr(dt, 1, 4)) %>%
    select(c(dt, AverageTemperature, Country)) %>%
    filter(Country %in% c("China", "Brazil", "United Kingdom", "United States", "Australia", "South Africa"))

Brazil <- filter(temp, Country == "Brazil") %>%
    group_by(dt) %>%
    summarise(Brazil = mean(AverageTemperature))

China <- filter(temp, Country == "China") %>%
    group_by(dt) %>%
    summarise(China = mean(AverageTemperature))

US <- filter(temp, Country == "United States") %>%
    group_by(dt) %>%
    summarise(United_States = mean(AverageTemperature))

UK <- filter(temp, Country == "United Kingdom") %>%
    group_by(dt) %>%
    summarise(United_Kingdom = mean(AverageTemperature))

Australia <- filter(temp, Country == "Australia") %>%
    group_by(dt) %>%
    summarise(Australia = mean(AverageTemperature))

SA <- filter(temp, Country == "South Africa") %>%
    group_by(dt) %>%
    summarise(South_Africa = mean(AverageTemperature))

chart1 <- left_join(Brazil, China, by = "dt") %>%
    left_join(US, by = "dt") %>%
    left_join(UK, by = "dt") %>%
    left_join(Australia, by = "dt") %>%
    left_join(SA, by = "dt")

chart2 <- filter(co2, Country %in% c("China", "Brazil", "United Kingdom", "United States", "Australia", "South Africa")) %>%
    select(-c(Data.source, Sector, Unit, Gas))
