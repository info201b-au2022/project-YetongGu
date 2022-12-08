# server.R
library('dplyr')
library('reshape2')

# Read in data
temp <- read.csv("../data/GlobalLandTemperaturesByMajorCity.csv", stringsAsFactors = FALSE)
co2 <- read.csv("../data/historical_emissions.csv", stringsAsFactors = FALSE)

co2_clean <- co2[,-c(2:5) ]

co2_reshape <- melt(co2_clean, id.vars='Country')

server <- function(input, output) {
  output$co2 <- renderPlot({
    
    co2_data <- reactive({
      req(input$country)
      df <- co2_reshape %>% filter(Country %in% input$country)
    })
    
    plot2 <- ggplot(co2_data(), aes(x = variable, y = value)) +
      geom_bar(stat="identity") +
      labs(x = "Year", y = "Value", 
           caption = "This graph shows the Co2 emission change over the year by selected country")
    plot2
  })

}