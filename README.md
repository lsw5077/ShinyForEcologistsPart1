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

## Starting our app

Shiny apps are built out of two fundamental elements: the user interface and server. The user interface (ui), as the name suggests, creates all the elements that the user engages with. It contains all the static text and defines the appearence of interactive elements. We define the user interface using the shinyUI function:

```r

ui <- shinyUI()

```

The server controls all the operations that make the app run. There is a feedback between server and ui where the user manipulates the interactive elements in the ui, then the server process their input and returns data and graphics elements. We define the server using the shinyServer() function:

```r
server <- shinyServer(function(input, output, session){

})

```

Shiny assembles the server and ui into a cohesive unit using the shinyApp() function:

```r
shinyApp(ui = ui, server = server)
```

Now that we have a handle on the basic structure of the app, let's dive into our sea lion visualization!

## UI

The first thing we need to do decide for our new app is how we want the text and visualization to be organized on the pages. Remember that shiny apps make websites, so we have to plan out both the overall structure of the web pages and how they relate, and the layout and organization of each page. We'll start out with an page layout that has clickable tabs across the top, called a "navbarPage." we define this structure using the "navbarPage()" function. We'll define the title of our navbarPage, which will show up in the top left, by typing it in quotes: "Stellar Sealion Pup Count Trends." Each time we add a new element, it will be wrapped inside all the previous ones, so we'll wrap our navbarPage in our shinyUI function:

```r

ui <- shinyUI(navbarPage("Stellar Sealion Pup Count Trends"))

```

Now we need to choose the layout of our first page. We're going to use a sitebarPanel() layout, which gives us a side panel and a main panel. The side panel and main panel can both hold text, plots, maps, user input widgets, videos, and whatever else we need them to hold. The advantage of using a sidepanel is that it draws the user's eye, so it's a great structure for communicating instructions and introductory material. Our sidepanel will hold a brief welcome for the user, made large using the h2() function, and a user input widget that prompts users to select a pup count site from a dropdown menu. So altogether, our user interface now looks like:

```r
ui <- shinyUI


```


## Server


### Reactivity

The core advantage of Shiny is reactivity. Reactivity is the ability of Shiny apps to receive user inputs and perform operations that are then returned to the user as updating visuals and values. We can see this in the "reactive({})" statement in the server section of the code:

```r

siteSelection <- reactive({
                
                site <- names(siteChoices)[as.numeric(input$site)] # The user's selection from the drop-down
                
                }) 
```



### Widgets





## Other Shiny resources

## Why break this app?

I called this tutorial "Break this app" in the hopes that you would do just that: take the example app and break it. Then fix it, add your own elements to it, and adapt the basic structure for your project. Coding a shiny app is likey different than anything you've coded before, and the best way to learn is to simply change one or a few things at a time and observe the effects. Just pick something and change it. You can start simple: text color, size, or content, graph style, whatever you feel like. If it works, you learned something. If it doesn't, you learned something. See you soon! 
