library('dplyr')
library('reshape2')
library('tidyverse')
library('shiny')
library('plotly')

# import B5.R
source("B5.R")

# import summary information table.R
source("B3.R")

# Read in data
temp <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-YetongGu/main/data/GlobalLandTemperaturesByMajorCity.csv", stringsAsFactors = FALSE)
co2 <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-YetongGu/main/data/historical_emissions.csv", stringsAsFactors = FALSE)

temp$dt <- as.Date(temp$dt)
temp$year <- format(temp$dt,"%Y")

#Filter the temperature data from the north
temp_n <- temp %>% 
  filter(stringr::str_detect(Latitude, 'N'))

#Filter the temperature data from the south
temp_s <- temp %>% 
  filter(stringr::str_detect(Latitude, 'S'))

# Clean the Co2 data
co2_clean <- co2[,-c(2:5) ]

# Reshape the Co2 data
co2_reshape <- melt(co2_clean, id.vars='Country')

server <- function(input, output) {
  
  output$temp_date <- renderPlot({
    
    south <- reactive({
      req(input$date)
      df <- temp_s %>% filter(dt > input$date[1], 
                              dt < input$date[2]) %>% 
        group_by(dt) %>%
        summarise(avg_temp_s = mean(AverageTemperature, na.rm = TRUE))
    })
    
    north <-  reactive({
      req(input$date)
      df <- temp_n %>% filter(dt > input$date[1], 
                              dt < input$date[2]) %>% 
        group_by(dt) %>%
        summarise(avg_temp_n = mean(AverageTemperature, na.rm = TRUE))
    })
    
    plot1_date <- ggplot() + 
      geom_line(data = south(), aes(x = dt, y = avg_temp_s), color = "blue") +                    
      geom_line(data = north(), aes(x = dt, y = avg_temp_n), color = "red") + 
      labs(x = "Date", y = "temperature", 
           caption = "This graph shows the Co2 emission change over the year by selected pole")
    ggtitle("North Avg Temperature vs South Avg Temperature",
            subtitle = "Blue: N Temp, Red: S Temp") 
    
    plot1_date
  })
  
  
  # get the plot for co2
  output$co2 <- renderPlot({
    
    co2_data <- reactive({
      req(input$country)
      df <- co2_reshape %>% filter(Country %in% input$country)
    })
    
    plot2 <- ggplot(co2_data(), aes(x = variable, y = value)) +
      geom_bar(stat="identity", fill = "cyan2") +
      labs(x = "Year", y = "Value", 
           caption = "This graph shows the Co2 emission change over the year by selected country")
    plot2
  })
  
  
  # get first plot for temperature in years
  output$plot1 <- renderPlotly({
    
    data <- rename(chart1, "United States" = "United_States",
                   "United Kingdom" = "United_Kingdom",
                   "South Africa" = "South_Africa")
    
    data <- filter(data, dt >= input$years[1], dt <= input$years[2]) %>%
      select(dt, input$Country)
    
    data[is.na(data)] <- 0
    
    y_output <- select(data, input$Country)
    
    p <- ggplot(data = data) +
      geom_bar(mapping = aes(x = dt, y = unlist(y_output)),
               stat='identity', fill = "cyan2") +
      labs(title = "Temperature of country by years",
           x = "years",
           y = "temperature(°C)")
    ggplotly(p)
  })
  
  
  # get second plot for co2 emission in years
  output$plot2 <- renderPlotly({
    
    data2 <- mutate(co2_reshape, year = substring(variable, 2, 5)) %>%
      filter(Country == input$Country, year >= input$years[1], year <= input$years[2])
    
    p2 <- ggplot(data = data2) +
      geom_col(mapping = aes(x = year, y = value),
               fill = "cyan2") +
      labs(title = "co2 emission of country by years",
           x = "years",
           y = "co2 emissions(million tonnes)")
    
    ggplotly(p2)
  })
  
  output$China <- renderImage({
    
    list(src = "summary 1 China.png",
         height = 330)
    
  }, deleteFile = F)
  
  output$US <- renderImage({
    
    list(src = "summary 2 US.png",
         height = 330)
    
  }, deleteFile = F)
  
  output$Climate <- renderImage({
    
    list(src = "climate change.jpg",
         height = 330)
    
  }, deleteFile = F)
}

