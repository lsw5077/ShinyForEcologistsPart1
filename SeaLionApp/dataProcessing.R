# data processing

library(tidyverse)

# load data

seaLions <- read.csv("C:/Users/Lyndsie/Documents/SeaLionApp/data/2014_pup_web_data.csv")

# make varaiable for mean of pup count at each site in each year

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
            
# join the dataframe

seaLionSimple <- seaLionSimple %>% rbind(seaLionDup)

# export the data


seaLions <- read.csv("C:/Users/Lyndsie/Documents/SeaLionApp/data/simpleData.csv") %>%
            select(-X)

seaLions$sitename <- fct_relevel(seaLions$sitename, "All", "Adak")

siteChoices <- seq(1:length(levels(seaLions$sitename)))
names(siteChoices) <- levels(seaLions$sitename)


write_rds(seaLions, "C:/Users/Lyndsie/Documents/SeaLionApp/data/seaLions.rds")
write_rds(siteChoices, "C:/Users/Lyndsie/Documents/SeaLionApp/data/siteChoices.rds")
