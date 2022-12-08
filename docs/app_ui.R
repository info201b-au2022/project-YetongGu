library('shiny')
library('ggplot2')
library('dplyr')
library('reshape2')
library('tidyverse')
library('shiny')
library('plotly')



intro_panel <- tabPanel(
  "Introduction",
  
  titlePanel("Introduction"),
  
  br(),
  br(),
  
  imageOutput("Climate"),
  
  p("For our project, we decided to focus on how climate change and its effects 
  on the earth surface temperature. To do this, we collected data from research 
  that shows the potential causes of climate change and its risk factors. This 
  project allows us to intuitively see what the direct impacts of climate change 
  are and what we can do to possibly reverse or prevent the effects of climate change."),
  
  p(strong("Project framing:"),
    " The goal of this project is to develop a preliminary understanding of current 
    environmental temperatures, analyze The analysis and investigation of how humans 
    affect the environment and the causes of specific environmental impacts. 
    Inspired by:", a(strong(" Beyond Catastrophe A New Climate Reality Is Coming Into View."), 
                     href = "https://www.nytimes.com/interactive/2022/10/26/magazine/climate-change-warming-world.html")),
  
  p(strong("Human Values:"),
    " Environmental problems, especially temperature problems, are one of the major 
    problems in human society nowadays. This project will give us a preliminary 
    knowledge of the current state of the environment, so that we can form a proper 
    awareness of environmental protection."),
  
  p(strong("Direct stakeholders:"),
    " Environmental scientists, environmentalists who want to understand the 
    current state of the environment, Students."),
  
  p(strong("Indirect stakeholders:"),
    " Citizens of society."),
  
  p(strong("Benefits:"), div(),
    " Raise citizens' awareness of the current state of the environment.", div(),
    "Analyze as well as look for the main causes of ambient temperature changes."),
  
  p(strong("Harms:"), div(),
    " The reasons searched for are not necessarily beneficial to the development 
    of society."),
  
  br(),
  
  p(" We used some questions to conduct our research. These questions were 
    specifically catered to the material and data that we collected."),
  
  p(strong("1."), 
    " How can our data prove that global warming and climate change are happening 
    around the world? (We can look at the temperature changes around the globe to 
    decide if there are climate change taking place.)"),
  
  p(strong("2."), 
    " How does our data shows the temperature changes difference in the Northern and 
    Southern Hemisphere? (It could be specific described in certain time period.)"),
  
  p(strong("3."), 
    " What are the impacts of CO2 emissions on temperature?"),
  
  p(strong("3."), 
    " Does the emissions of CO2 cause an increase in temperature? 
    If so, how can we reduce the emissions of CO2?)"),
  
  br(),
  
  p("The data that we analyzed was the specific Carbon Dioxide (CO2) emissions 
    and the temperature of the Earth’s surface overtime in six of the world’s 
    major countries: China, Brazil, South Africa, Australia, the United Kingdom, 
    and the United States. By using this specific data, it helped comprehend and 
    demonstrate the exact contributions of climate change within each climate, 
    and overtime."),
  
  p("From the data that we had analyzed and collected, these were our key findings:"),
  
  p(strong("1."), 
    "How can our data prove that global warming and climate change are happening 
    around the world? (We can look at the temperature changes around the globe to 
    decide if there are climate change taking place.)"),
  
  p(strong("1."), 
    " Global Temperature is rising at a dramatic rate, specifically faster in northern regions rather than south."),
  
  p(strong("2."), 
    " Northern regions temperature changes are abnormal, and are rapidly changing in the summer and winter."),
  
  p(strong("3."), 
    "Compared to northern regions, southern regions have less temperature variability."),
  
  p(strong("4."), 
    "Carbon dioxide emission levels differ from each country."),
  
  p(strong("5."), 
    "Carbon dioxide is not the main cause of temperature changes."),
)


plot1_panel <- tabPanel(
  "Temperature",
  
  titlePanel(" Global Land Average Temperature"),
  
  sidebarLayout(
    sidebarPanel(
      h3(strong("Options:")),
      h4("You can select the years range you want here."),
      
      sliderInput(
        "date", 
        label = h4(strong("Select Date Range:")),
        min = as.Date("1743-11-01","%Y-%m-%d"),
        max = as.Date("2013-09-01","%Y-%m-%d"),
        value=as.Date(c("2012-01-01","2012-12-31")),
        timeFormat="%Y-%m-%d"
      )),
    
    mainPanel(
      plotOutput("temp_date"),
      
      h3("Summary"),
      
      p("From plot 1, we can see that the red line which represents the north 
      temperatures change drastically by date. Compare to north temperatures, 
      the south temperature changes are more placid.  For example, from 2012-07 
      to 2013-01; the north temperature changed from 26ish to 11ish; the south 
      temperature changed from 18ish to 23ish."),
      )
  )
)

plot2_panel <- tabPanel(
  "CO2",
  
  titlePanel("Co2 Emission Change by Year"),
  
  sidebarLayout(
    sidebarPanel(
      h3(strong("Options:")),
      h4("You can select the country you want here."),
      
      selectInput(
        "country",
        label = h4(strong("Select country:")),
        list("World", "China", "United States", "Russia", "India", "Germany", 
             "Ukraine", "France", "Italy", "Canada", "Mexico", "Africa", "Turkey", 
             "Philippines", "Switzerland", "United Kingdom", "Japan")
      )
    ),
    
    mainPanel(
      plotOutput("co2"),
      
      h3("Summary"),
      
      p("This graph is mainly a global and country-by-country summary of carbon 
        dioxide emissions from 1990 to 2018. Since we wanted to study the effect 
        of carbon dioxide on global temperature, we first made a graph of the 
        overall carbon dioxide change. This table allows users to select trends 
        in different country or worldly to analyze the reasons for changes in 
        carbon dioxide emissions according to different trends in different regions."),
      
      p("We can also see that CO2 emissions in developing countries are clearly 
        on the rise compared to those in developed countries. In contrast, 
        developed countries like the United States and the United Kingdom have 
        been declining since 1990, which shows that an important sign for 
        developing countries to move into the developed world is to reduce CO2 
        emissions.")
    )
  )
)


plot3_panel <- tabPanel(
  "Comparison",
  
  titlePanel("temperature relate to CO2 emission"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "Country",
                         label = "Choose a country",
                         choices = c("Brazil", "China", "United States", 
                                     "United Kingdom", "Australia", "South Africa")),
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
)


summary_panel <- tabPanel(
  "Summary",
  
  titlePanel("Summary takeaways"),
  
  h4(strong("We found 3 takeaways in our datasets and analysis")),
  
  p(strong("1."), 
    "Global temperatures are slowly rising in both the northern and southern 
    hemispheres from 1800 to 2013. The temperature rise is more dramatic in the 
    northern hemisphere than in the sparsely populated southern hemisphere. The 
    temperature difference between winter and summer in the Northern 
    Hemisphere is also larger compared to the Southern Hemisphere."),
  
  p(strong("2."), 
    "From a global perspective, CO2 emissions are gradually rising. But a 
    large portion of the developed world is seeing a gradual decline in CO2 
    emissions this year. Most developing countries, however, have seen their 
    CO2 emissions increase year after year. In our study, it seems that the 
    decreasing trend of CO2 emissions is an important sign for developed 
    countries."),
  
  p(strong("3."), 
    "Global temperatures does shows a rising trend for a long time period, 1750 
    to 2013. But the global temperature have stabilized considerably in recent 
    years, but CO2 emissions are not trending downward. Our analysis suggests 
    that CO2 emissions contribute only a small fraction to global temperatures."),
  
  imageOutput("China"),
  imageOutput("US")
)


report_panel <- tabPanel(
  "Report",
  
  titlePanel("Digging Deeper into Climate Change Report"),
  
  br(),
  
  h4(strong("Code name:")),
  
  p("Crashing Climates"),
  
  br(),
  
  h4(strong("Project title:")),
  
  p("Digging Deeper into Climate Change"),
  
  br(),
  
  h4(strong("Authors:")),
  
  p("Leah S, Yetong G, Simon X, Maggie L"),
  
  br(),
  
  h4(strong("Affiliation:")),
  
  p("INFO-201: Technical Foundations of Informatics - The Information School - 
    University of Washington"),
  
  br(),
  
  h4(strong("Date:")),
  
  p("December 8th, 2022"),
  
  br(),
  
  h4(strong("Abstract:")),
  
  p("Climate change is rapidly changing and it’s happening now. The environment 
    is at risk and it is being harmed. The environment is shifting and is being 
    affected in all parts of the world. A change needs to be made, or else it 
    might be too late to go back. Humans have become overly consumed and it is 
    very prevalent in our environments. The overconsumption of waste, water, and 
    fossil fuels (coal etc;) has harmed the environment. The United States is one 
    of the most leading countries in overconsumption. If our consumption in all 
    aspects doesn’t reduce, we might be at risk for future catostrophies."),
  
  br(),
  
  h4(strong("Keywords:")),
  
  p("Climate Change, United States, Environment, Earth Surface, Waste, 
    Over Consumption, Fossil Fuels, Emissions, Greenhouse Gas, Carbon Dioxide, 
    Energy, Renewable Energy, Water Usage"),
  
  br(),
  
  h4(strong("Introduction:")),
  
  p("Our project will be focused on how climate change can change the earth 
  surface temperature and what role does carbon dioxide emissions play in this.
  We will be looking at data from researches that shows what are the potential 
  causes to climate change; what plays the biggest factor that causes climate 
  change. This project allows us to intuitively see what the impacts are and 
  what can we do to reduce the change."),
  
  br(),
  
  h4(strong("Problem domain:")),
  
  p(strong("Project framing:"),
    " The goal of this project is to develop a preliminary understanding of current 
    environmental temperatures, analyze The analysis and investigation of how humans 
    affect the environment and the causes of specific environmental impacts. 
    Inspired by:", a(strong(" Beyond Catastrophe A New Climate Reality Is Coming Into View."), 
    href = "https://www.nytimes.com/interactive/2022/10/26/magazine/climate-change-warming-world.html")),
  
  p(strong("Human Values:"),
    " Environmental problems, especially temperature problems, are one of the major 
    problems in human society nowadays. This project will give us a preliminary 
    knowledge of the current state of the environment, so that we can form a proper 
    awareness of environmental protection."),
  
  p(strong("Direct stakeholders:"),
    " Environmental scientists, environmentalists who want to understand the 
    current state of the environment, Students."),
  
  p(strong("Indirect stakeholders:"),
    " Citizens of society."),
  
  p(strong("Benefits:"), div(),
    " Raise citizens' awareness of the current state of the environment.", div(),
    "Analyze as well as look for the main causes of ambient temperature changes."),
  
  p(strong("Harms:"), div(),
    " The reasons searched for are not necessarily beneficial to the development 
    of society."),
  
  br(),
  
  h4(strong("Research questions:")),
  
  p(strong("1."), 
    "Can our data prove global warming and climate change are happening around 
    the world? (We can look at the temperature changes around the globe to 
    decide if there are climate change taking place.)"),
  
  p(strong("2."), 
    "How does our data shows the temperature changes difference in the Northern and 
    Southern Hemisphere? (It could be specific described in certain time period.)"),
  
  p(strong("3."), 
    "What are the impacts of CO2 emissions on temperature? (Does the emissions of CO2 
    cause an increase in temperature? If so, how can we reduce the emissions of CO2?)"),
  
  br(),
  
  h4(strong("The dataset:")),
  
  p(strong("1."), 
    "By addressing the Climate Change issue we mainly focused on whether global 
    warming is happening. Our dataset contains information like the average 
    temperature of each month from 1850 to 2013 and corresponding to different 
    locations with their Latitude and Longitude. Our second data set includes 
    the information of each yea's total CO2 emissions of different countries 
    from 1990 to 2018. The analyze of these information can support us to answer 
    our research questions. For example, the temperature change trend in a specific 
    time period can be obtained by processing the temperature feature, and by adding 
    regional restrictions we can have the temperature change trend in different 
    regions. Finally, the relationship between temperature change and carbon dioxide 
    emission can be obtained by comparing the trend of temperature change and carbon 
    dioxide emission."),
  
  p(strong("2."), 
    "We found both our our data from Kaggle, below we included the link from 
    Kaggle and the source information of the data on Kaggle"),
  
  p(strong("GlobalLandTemperaturesByCity"), div(),
    a(strong("Climate Change: Earth Surface Temperature Data. (2017, May 1). Kaggle."), 
      href = "https://www.kaggle.com/datasets/berkeleyearth/climate-change-earth-surface-temperature-data?ref=hackernoon.com"),
    div(), "Data Overview. (2022, October 25). Berkeley Earth. http://berkeleyearth.org/data/"),
  
  p(strong("historical_emissions"), div(),
    a(strong("Carbon Dioxide Emissions of the World( 1990-2018). (2022, March 23). Kaggle."), 
      href = "https://www.kaggle.com/datasets/ankanhore545/carbon-dioxide-emissions-of-the-world")),
  
  p(a(strong("Data Explorer | Climate Watch. (n.d.). Retrieved October 31, 2022."), 
      href = "https://www.climatewatchdata.org/data-explorer/historical-emissions?historical-emissions-data-sources=cait")),
  
  br(),
  
  h4(strong("Findings:")),
  
  p("We brought up three research questions from our three plots: 
  The ", strong("first"), " one is ", em("“Can our data prove global warming and 
                                         climate change are happening around the 
                                         world? (We can look at the temperature 
                                         changes around the globe to decide if 
                                         there are climate change taking place.)”"), 
  " The ", strong("second"), " and ", strong("third"), " one are ", 
  em("“How does our data show the temperature changes difference in the Northern 
     and Southern Hemisphere? (It could  be specifically described in a certain 
     time period).”"), " and ", em("“What are the impacts of CO2 emissions on 
                                   temperature? (Does the emissions of CO2 cause 
                                   an increase in temperature?If so, how can we 
                                   reduce the emissions of CO2? )”")),
  
  p(strong("For the first question,"), 
    "we made a plot to show the CO2 emissions from different countries in different 
    years.The result is that carbon dioxide emissions from the world's point of 
    view are rising year by year. But if you look at some European countries 
    where the overall trend of CO2 emissions has been decreasing since 2000, 
    like Germany, France, and the United Kingdom. But China, Russia, Turkey, 
    Mexico are all growing."),
  
  p(strong("For the second question,"), 
    "we made a plot comparing the northern and southern hemispheres. We can see that 
    the red line which represents the north temperatures change drastically by 
    different month. Compared to north temperatures, the south temperature changes 
    are more placid. For example, from 2012-07 to 2013-01; the north temperature 
    changed from 26ish to 11ish, the difference is 15, but the south temperature 
    changed from 18ish to 23ish, the difference is 5. The pattern stays same 
    from 1743 to 2013."),
  
  p(strong("For the third question,"), 
    "we made one plot that shows the temperature of the country changing by year 
    and one plot that shows the co2 emission by year. We can see through these 
    two graphs that these two variables do not seem to affect each other (the 
    co2 emissions does not have a direct impact on the temperature.) However, 
    4 out of 6 countries’ CO2 keeps rising dramatically from the year 1990 to 2013. 
    Only two countries (Australia and South Africa) have a downward trend for 
    co2 emissions. We need to take action earlier in countries such as China, 
    the UK, and Brazil to find ways to reduce the co2 emissions. We believe that 
    the more co2 emissions the higher the temperature will rise which will be a 
    potential factor that causes global warming. Things we can do to prevent co2 
    emissions is to drive our car less unless we have to; making power on-site with 
    renewables and other climate-friendly energy resources; plant trees; reduce 
    air travel etc."),
  
  br(),
  
  h4(strong("Discussion:")),
  
  p("From the data that we have collected from looking at the CO2 emissions and 
  the earth's surface temperature, it is clear that overtime, climate change has 
  been prevalent. Each and every single one of our graphs depict and illustrate 
  this. With the increased usage of CO2 emissions, the temperature of the earth’s 
  surface increased. The temperature graph provides clear and concise evidence for 
  the global temperature increase. Therefore proving again that climate change is 
  a real thing and is directly impacting us. We think this is due to CO2 emissions 
  having a large influence on the global temperature increase. However, from the 
  CO2 emission graph, we first noticed that the world's Carbon dioxide emission 
  is increasing, there is a large difference between developed countries and 
  developing countries. Not only does this imply for us to think in a new way, 
  but it implies that Carbon dioxide emissions are not a trend for all countries. 
  And it is also not the main reason that causes the temperature change in a 
  short term period, but it is a key contributor."),
  
  br(),
  
  h4(strong("Conclusion:")),
  
  p("From the data that we’ve collected from this project, it’s evident that climate 
  change is affecting our environment. Some of you may be wondering, what is the main 
  why we decided to look at climate change? Or, why did we pick this specific issue 
  to conduct our study? How is climate change going to affect me?"),
  
  p("Climate change is impacting each and every one of us. The effects that climate 
  change is having on our planet is now irreversible. However, there’s still so much 
  we could do to prevent it from spreading even more. So how do we try to prevent 
  climate change from spreading even more than it has? It’s simple really, the main 
  contribution to climate change is overconsumption in all aspects." , div(), 
  "- Reducing the usage of electricity." , div(), 
  "- Reducing your carbon footprint. You can do this by carpooling, 
  using public transportation, or even walking! " , div(), 
  "- Eating more plant based foods! Eating healthier is always a good idea, 
  try incorporating more fruits and vegetables into your diet. This can help 
  reduce greenhouse gasses, and also require consumption in other aspects of 
  our environment."),
  
  p("From the data that we’ve collected from this project, it’s evident that climate 
  change is affecting our environment. Some of you may be wondering, what is the main 
  why we decided to look at climate change? Or, why did we pick this specific issue 
  to conduct our study? How is climate change going to affect me? "),
  
  br(),
  
  h4(strong("Acknowledgements:"), " Many thanks to my team members, as well as 
            Professor Hendry and the wonderful TAs!"),
  
  div(),
  
  br(),
  
  h4(strong("References:")),
  
  p(strong("1."), 
    " Kaggle: Your Home for Data Science. (n.d.). Retrieved October 31, 2022, from ", 
    a("https://www.kaggle.com/datasets/sohelranaccselab/global-climate-change", 
      href = "https://www.kaggle.com/datasets/sohelranaccselab/global-climate-change")),
  
  p(strong("2."), 
    " Home. (n.d.). Climate Change: Vital Signs of the Planet. Retrieved October 31, 2022, from ", 
    a("https://climate.nasa.gov", 
      href = "https://climate.nasa.gov")),
  
  p(strong("3."), 
    "  U.S. Climate Normals 2020: U.S. Monthly Climate Normals (1991-2020) - Catalog. (n.d.). Retrieved October 31, 2022, from ", 
    a("https://catalog.data.gov/dataset/u-s-climate-normals-2020-u-s-monthly-climate-normals-1991-20201", 
      href = "https://catalog.data.gov/dataset/u-s-climate-normals-2020-u-s-monthly-climate-normals-1991-20201")),
  
  p(strong("4."), 
    " Wikipedia contributors. (2022, October 28). Kaggle. Wikipedia. ", 
    a("https://en.wikipedia.org/wiki/Kaggle", 
      href = "https://en.wikipedia.org/wiki/Kaggle")),
  
  p(strong("5."), 
    " About. (2022, April 11). Berkeley Earth. ", 
    a("https://berkeleyearth.org/about/", 
      href = "https://berkeleyearth.org/about/")),
  
  p(strong("6."), 
    " About | Climate Watch. (n.d.). Retrieved October 31, 2022, from ", 
    a("https://www.kaggle.com/datasets/sohelranaccselab/global-climate-change", 
      href = "https://www.kaggle.com/datasets/sohelranaccselab/global-climate-change")),
  
  p(strong("7."), 
    " About | Climate Watch. (n.d.-b). Retrieved October 31, 2022, from ", 
    a("https://www.climatewatchdata.org/about/faq/general_questions", 
      href = "https://www.climatewatchdata.org/about/faq/general_questions"))
)


ui <- navbarPage(
  "Climate Change G19",
  intro_panel,
  plot1_panel,
  plot2_panel,
  plot3_panel,
  summary_panel,
  report_panel
)
