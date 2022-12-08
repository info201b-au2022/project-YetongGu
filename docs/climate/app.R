# Assignment 5

# Load libraries so they are available
library(tidyverse)
library(shiny)
library(plotly)

# import B5.R
source("B5.R")

# import summary information table.R
source("summary information table.R")

ui <- navbarPage("test",
# Create a page for question: temperature relate to CO2 emission
  tabPanel("temperature relate to CO2 emission",
           
    titlePanel("temperature relate to CO2 emission"),
    
    sidebarLayout(
      sidebarPanel(
        
        selectInput(inputId = "Country",
                    label = "Choose a country",
                    choices = c("Brazil", "China", "United States", "United Kingdom", "Australia", "South Africa")),
        
        sliderInput("years",
                    "____ years to ____",
                    min = 1990,
                    max = 2013,
                    value = c(1990, 2013))
    ),
    mainPanel(
      plotly::plotlyOutput("plot1"),
      plotly::plotlyOutput("plot2"),
      
      h3("Summary"),
      
      p("These two graphs show the data for each of the six countries through 
        CO2 and temperature changes with the year. Our preliminary findings show
        that there is actually no direct link between the change in temperature
        and CO2 emissions, indicating that there are many determinants of 
        temperature in a country that do not directly depend on CO2 emissions.
        And the global temperature tends to be stable."),
      
      p("We can also see that CO2 emissions in developing countries are clearly 
        on the rise compared to those in developed countries. In contrast, 
        developed countries like the United States and the United Kingdom have 
        been declining since 1990, which shows that an important sign for 
        developing countries to move into the developed world is to reduce CO2 
        emissions.")
    )
    )
  ),


  tabPanel("Summary takeaways",
    titlePanel("Summary takeaways"),
    
    h4(strong("We found 3 takeaways in our datasets and analysis")),
    
    p(strong("1."), 
      "Global temperatures are slowly rising in both the northern and southern 
      hemispheres, but the temperature rise is more dramatic in the northern 
      hemisphere than in the sparsely populated southern hemisphere. The 
      temperature difference between winter and summer in the Northern 
      Hemisphere has also increased compared to the Southern Hemisphere."),
    
    p(strong("2."),
      "From a global perspective, CO2 emissions are gradually rising. But a 
      large portion of the developed world is seeing a gradual decline in CO2 
      emissions this year. Most developing countries, however, have seen their 
      CO2 emissions increase year after year. In our study, it seems that the 
      decreasing trend of CO2 emissions is an important sign for developed 
      countries."),
    
    p(strong("3."),
      "Global temperatures have stabilized considerably in recent years, but 
      CO2 emissions are not trending downward. Our analysis suggests that CO2 
      emissions contribute only a small fraction to global temperatures.")
    
  )
)

# Define server logic required to draw two plots
server <- function(input, output) {
    
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
}

# Run the application 
shinyApp(ui = ui, server = server)
