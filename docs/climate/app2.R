# Assignment 5

# Load libraries so they are available
library("shiny")



# Use source() to execute the `app_ui.R` and `app_server.R` files.
source("app_ui2.R")
source("app_server2.R")


# Create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp(ui = ui, server = server)
