# UI for scatterplot
library(shiny)
library(ggplot2)


sel_country <- selectInput(
  "country",
  label = h4(strong("Select country:")),
  list("World", "China", "United States", "Russia", "India", "Germany", "Ukraine", "France", "Italy",
       "Canada", "Mexico", "Africa", "Turkey", "Philippines", "Switzerland", "United Kingdom", "Japan")
)




plot2_panel <- tabPanel(
  "Co2",
  titlePanel("Co2 Emission Change by Year",
             "Under Selected Country"),
  
  sidebarLayout(
    sidebarPanel(
      h3(strong("Options:")),
      h4("You can select the country you want here."),
      sel_country),
    
    mainPanel(
      plotOutput("co2")
    )
    
  )
)

ui <- navbarPage(
  plot2_panel
)
