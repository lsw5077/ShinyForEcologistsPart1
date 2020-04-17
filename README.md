# Break this app: an ecologist's intro to Shiny

Hello and welcome to my first tutorial on the R Shiny framework! Shiny is a framework for building interactive webpages using the R programming language. That means you can build powerful, customizable online tools to engage stakeholders in research communication using R programming skills you might already have. In this tutorial, we'll learn how to build a Shiny app that displays trends in Stellar sealion pup count data at different locations over time. This tutorial is meant to be an absolutely basic intro to Shiny, so if you're already making Shiny apps it might be a bit too basic for you. If you're looking for some help building your first app, this is the place for you! 

## What do I need to make a Shiny app?

To get started, you'll need to have R and RStudio installed on your computer. The main prerequisite to building our sealion Shiny app is a basic understanding of the Tidyverse, a collection of R packages designed for data science. If you're new to the Tidyverse, I highly recommend the book R for Data Science, as well as the unofficial solutions manual. 

Ready to get started? Awesome! Let's open RStudio and make sure our required packages are installed:  

```r

install.packages("tidyverse")
install.packages("shiny")
```

## File organization

For this next step, you'll need to download the SeaLionApp folder in this repo. We'll follow along with the "app.R file" in the app folder. When you open app.R, you'll see some code at the top. This code runs outside the scope of the Shiny app and just sets up some things to make our lives easier while we build the app. The first lines load our package libraries, shiny and tidyverse:

```r
library(shiny)
library(tidyverse)
```
In the next lines, we set up a custom ggplot theme, which we'll call "simpleTheme" so we can easily control the way our plot looks later:

```r
simpleTheme <- theme_bw()+
    theme(panel.grid = element_blank(),
          axis.text = element_text(size = 20, color = "black"),
          axis.title = element_text(size = 24, color = "black"))
```
At this point, we're ready to load some data that we'll use in a minute. Since the purpose of the app is to show trends in pup count data at different sites, we're loading an R data object that contains a named list of the sites so we can let users choose from them in an interactive widget a little later. 

```r
siteChoices <- read_rds("data/siteChoices.rds")
```
A note: sometimes directories can be a little tricky. You'll notice that the lines above use the path "data/" because a published shiny app needs all the data to be in a folder called "data," which it automatically looks for in the app directory. However, if you download and modify this app, it may be easier to use the commented out lines, which will help the app find the right paths to run on your computer:

```r

# appPath <- dirname(rstudioapi::getSourceEditorContext()$path)
# siteChoices <- read_rds(paste0(appPath, "/data/siteChoices.rds"))
```

## App structure

Shiny apps are built out of two fundamental elements: the user interface and server. The user interface (ui) controls how the shiny app looks to the user. It contains all the static text and defines the appearence of interactive elements. We define the user interface using the shinyUI function:

```r

ui <- shinyUI()

```

The server controls all the operations that make the app run. There is a feedback between server and ui where the user manipulates the interactive elements in the ui, then the server process their input and returns data and graphics elements. We define the server using the shinyServer() function:

```r
server <- shinyServer(function(input, output, session){

})

```

Shiny assembles the server and ui into a cohesive 



## Server


### Reactivity

The core advantage of Shiny is reactivity. Reactivity is the ability of Shiny apps to receive user inputs and perform operations. We can see this in the "reactive({})" statement in the server section of the code:

```r

siteSelection <- reactive({
                
                site <- names(siteChoices)[as.numeric(input$site)] # The user's selection from the drop-down
                
                }) 
```



### Widgets





## Other Shiny resources
