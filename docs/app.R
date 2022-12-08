library(tidyverse)
library(shiny)
library(plotly)
source("docs/summary information table.R")
co2 <- read.csv("data/historical_emissions.csv")

ui <- navbarPage("Temperature relate to co2"
  
)