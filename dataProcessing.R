# data processing

# This file contains the data processing scripts used to make the
# named lists of sites and the simplified, summarized data that we use in the app.
# If you want to modify this file for your own project, you'll have to change the paths, etc.

# Very important note!!!
# You don't have to have .rds files to make a shiny app.
# You can use .csv's, .xls's, or any other data format you like.
# I just like to use .rds files, which are like r data objects written to file
# because they retain factor levels etc. so we don't have to include data cleaning code
# in our app, and our app code will be more concise. 

library(tidyverse)
library(forcats)

# forcats is a great package for working with factors, and it has a super cute hex.

# load data

seaLions <- read.csv("C:/Users/Lyndsie/Documents/SeaLionApp/data/2014_pup_web_data.csv")

# make varaiable for mean of pup count at each site in each year
# Also clean up site name and make it look nice for our human users 

seaLionSimple <- seaLions %>%
                  mutate(sitename = tools::toTitleCase(tolower(as.character(sitename)))) %>%
                  group_by(sitename, year) %>%
                  mutate(meanPups = round(mean(pupcount, na.rm = T))) %>%
                  as.data.frame() %>%
                  dplyr::select(year, sitename, meanPups) %>%
                  distinct()

# make a dataframe w/ the same format, but for all sites

seaLionDup <- seaLions %>%
              group_by(year) %>%
              mutate(meanPups = round(mean(pupcount, na.rm = T)),
                     sitename = "All") %>%
              dplyr::select(year, sitename, meanPups) %>%
              as.data.frame() %>%
              distinct()
            
# join the dataframe, so now we have a factor level that includes all sites.

seaLionSimple <- seaLionSimple %>% rbind(seaLionDup)

# Make "All" the first factor level. 
# This will make it the default for the dropdown/ put it at the top of the list. 

seaLionSimple$sitename <- fct_relevel(seaLionSimple$sitename, "All", "Adak")

# Now we make a named list of site choice levels, which are now indexes
# This makes our dropdown code simpler. 

siteChoices <- seq(1:length(levels(seaLionSimple$sitename)))
names(siteChoices) <- levels(seaLionSimple$sitename)

# export the data

write_rds(seaLionSimple, "C:/Users/Lyndsie/Documents/SeaLionApp/data/seaLions.rds")
write_rds(siteChoices, "C:/Users/Lyndsie/Documents/SeaLionApp/data/siteChoices.rds")
