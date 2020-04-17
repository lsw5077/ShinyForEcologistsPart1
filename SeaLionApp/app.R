# Load Libraries

library(shiny)
library(tidyverse)

#setwd("C:/Users/Lyndsie/Documents/SeaLionApp")

# Make custom ggplot theme for later

simpleTheme <- theme_bw()+
    theme(panel.grid = element_blank(),
          axis.text = element_text(size = 20, color = "black"),
          axis.title = element_text(size = 24, color = "black"))


# For running the app locally on your computer, grab the path of wherever you put the app
# appPath <- dirname(rstudioapi::getSourceEditorContext()$path)
# siteChoices <- read_rds(paste0(appPath, "/data/siteChoices.rds"))

# for Publication

siteChoices <- read_rds("data/siteChoices.rds")

# load the list of site choices from the data folder

# build user interface

ui <- shinyUI(navbarPage("Stellar Sealion Pup Count trends", # page title
                    tabPanel("Graphing pup counts", # Tab panel title
                             sidebarLayout( # give us a nice data selection side bar!
                                sidebarPanel(
                                    h2("Welcome to the Stellar Sealion vizualization
                                       app! "), # Some nice welcoming text for users
                                    br(), br(),

                                 selectInput("site", # Make a drop-down menu
                                             "Choose a site to display the time series of mean pup counts at that site.",
                                              # data selection prompt for the users
                                              choices = siteChoices, # referencing the siteChoices list we loaded above 
                                              selected = 1) # Make a default selection, the first item in the list, "All" sites
                                ),
                                
                                mainPanel( # The big panel next to the side panel
                                    
                                   plotOutput("trendPlot") # Print the plot we make below.

                             ))),
                     tabPanel("Citations", # Must cite the data collectors! In a nice new tab panel! 
                              
                              wellPanel("This app was created by Lyndsie S. Wszola
                                        at the University of Nebraska for instructional
                                        purposes only. The Stellar sealion pupcount 
                                        dataset was collected by The National Marine
                                        Fisheries Service. More information on 
                                        the original dataset can be found",
                                        
                                        tags$a(href="https://www.fisheries.noaa.gov/resource/data/counts-alaska-steller-sea-lion-pups-conducted-rookeries-alaska-1961-2015", "here. "),
                                        
                                        "The sealion pupcount data has been slightly
                                         summarized and aggregated for this app. The
                                         data visualizaions contained in the app are
                                         therefore purely for educational purposes
                                         and do not represent any
                                         official finding or policy.") 
                              # We must have a disclaimer so that people don't misuse/misinterpret anything here.
                              
                              )
                             
                ))

server <- shinyServer(function(input, output, session) {
    
            # Load the sea lion trend data
            # For running locally
            # seaLions <- read_rds(paste0(appPath, "/data/seaLions.rdata"))
            
            # For publication
  
           seaLions <- read_rds("data/seaLions.rds")
  
            # Set up a reactive value for the user's site selection
            
            siteSelection <- reactive({
                
                site <- names(siteChoices)[as.numeric(input$site)] # The user's selection from the drop-down
                
                }) 
    
# 
            data <- reactive({ # Subsetting the data based on user input

                    site <- siteSelection() # referencing site-selection from above

                    siteDat <- seaLions %>% # Keep only data from the user-specified site.
                               dplyr::filter(sitename == site)

            })
# 
# 
            output$trendPlot <- renderPlot({

                   siteDat <- data() # Source our data from above

                   ggplot(siteDat) + # Make a beautiful (simple!) plot
                          geom_line(aes(x = as.numeric(year), y = meanPups)) +
                          geom_point(aes(x = as.numeric(year), y = meanPups), size = 3) +
                          coord_cartesian(ylim = c(0, max(siteDat$meanPups + 5))) +
                          scale_x_continuous(limits = c(1960, 2015), breaks = seq(1960, 2020, 10)) +
                          labs(x = "Year", y = "Mean pups per observation") +
                          simpleTheme

            })

        })


# Run the application 

shinyApp(ui = ui, server = server)
