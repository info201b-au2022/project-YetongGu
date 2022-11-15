# This graph shows the world's average temperature from the year 1750 to 2013. 
# The purpose of this graph is to show the temperature change over the year to 
# answer the question is global warming happing?
# The result of the graph does show the temperature around the world is rising now.

library('tidyverse')
library('dplyr')
library('stringr')
library('ggplot2')

temp <- read.csv("data/GlobalLandTemperaturesByMajorCity.csv")
co2 <- read.csv("data/historical_emissions.csv")

temp$dt <- as.Date(temp$dt)
temp$year <- format(temp$dt,"%Y")
temp$month <- format(temp$dt,"%m")

data_world <- temp %>%
  group_by(year) %>% 
  summarize(avg_temp = mean(AverageTemperature,na.rm = T))

data_world$year <- as.numeric(data_world$year)

plot1 <- ggplot(data_world, aes(year, avg_temp, color = avg_temp)) +
  geom_point() +
  scale_color_gradient(high = "#FF3333", low = "#3399FF") +
  geom_smooth(method = "lm") +
  theme(axis.line = element_line(size = 1)) +
  scale_x_continuous(breaks = seq(1750, 2013, by = 20)) +
  ggtitle("Global Land Average Temperature",subtitle = "1750 to 2013 ") 