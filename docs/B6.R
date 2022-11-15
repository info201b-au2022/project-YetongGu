# This is a line graph that shows the relationship between Co2 emission and world average temperature
# We have this graph because one of our research questions is to find out does the amount of Co2 emission
# has a relation with temperature change.
# The result does show at some point temperature and Co2 emission has a positive relationship.


install.packages("reshape2")
library('tidyverse')
library('dplyr')
library('stringr')
library('ggplot2')

temp <- temp <- read.csv("data/GlobalLandTemperaturesByMajorCity.csv")
co2 <- read.csv("data/historical_emissions.csv")

temp$dt <- as.Date(temp$dt)
temp$year <- format(temp$dt,"%Y")
temp$month <- format(temp$dt,"%m")


main_countries<- c("China", "United States", "Australia", "United Kingdom", "Brazil", "South Africa")
main_countries_years <- temp %>% 
  filter(year >= 1990) %>%
  filter(!is.na(AverageTemperature)) %>%
  group_by(year) %>%
  summarise(avg_temp = mean(AverageTemperature))

main_countries_years$year <- as.numeric(main_countries_years$year)

co2_world <- co2[c(1), -c(2:5)]
co2_world_reshape <- melt(co2_world, id.vars='Country')
co2_world_reshape[] <- lapply(co2_world_reshape, gsub, pattern='X', replacement='')
co2_world_reshape$variable <- as.numeric(co2_world_reshape$variable)
co2_world_reshape$value <- as.numeric(co2_world_reshape$value)
co2_world_reshape$value <- co2_world_reshape$value / 1000

plot3 <- ggplot() + 
  geom_line(data = main_countries_years, aes(x = year, y = avg_temp), color = "blue") +
  geom_line(data = co2_world_reshape, aes(x = variable, y = value), color = "red") +
  xlab('Year') +
  ylab('Value') +
  ggtitle("World Avg Temperature vs World Co2 Emission",
          subtitle = "Blue: Tempreature, Red: Co2 Emission") 






