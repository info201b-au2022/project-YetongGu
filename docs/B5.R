# This is the graph that shows the six main countries that we picked from each continents'
# Co2 emission from each year. We use this graph to show the total Co2 emission from each
# year because later we want to compare the Co2 emission of each country to each
# year's temperature.



install.packages("reshape2")
library('tidyverse')
library('dplyr')
library('stringr')
library('ggplot2')
library('reshape2')

temp <- read.csv("data/GlobalLandTemperaturesByMajorCity.csv")
co2 <- read.csv("data/historical_emissions.csv")


main_countries<- c("China", "United States", "Australia", "United Kingdom", "Brazil", "South Africa")
 

#first of all you need to melt your data.frame
co2_clean <- co2[-c(1),-c(2:5) ] %>%
  filter(Country %in% main_countries) 
  
#when you melt essentially you create only one column with the value
#and one column with the variable i.e. your x,y,z 
co2_reshape <- melt(co2_clean, id.vars='Country')


#ggplot it. x axis will be m, y will be the value and fill will be
#essentially your x,y,z
plot2 <- ggplot(co2_reshape, aes(x = Country, y = value, fill = variable)) + 
  geom_col(position = "stack") +
  ggtitle("Six main country Co2 emissions from 1990 to 2018",
    subtitle = "China, United States, Australia, United Kingdom, Brazil, South Africa") 