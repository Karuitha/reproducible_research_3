## Load libraries
library(fivethirtyeight)
library(tidyverse)

## Load the data
data("steak_survey", package="fivethirtyeight")

## Check for missing values
sapply(steak_survey, is.na) %>% 
    
    colSums() %>% 
    
    tibble(Variables = names(steak_survey), missing =.) %>% 
    
    arrange(desc(missing)) %>% 
    
    set_names(names(.) %>% str_to_sentence()) %>% 
    
    knitr::kable(caption = "Missing Data in Steak Survey Data", booktabs = TRUE) %>% 
    
    kableExtra::kable_styling(full_width = TRUE, bootstrap_options = "striped")

## Check for Duplicates
steak_survey %>% filter(duplicated(.)) %>% nrow()

## Omit NAs and select mountain region
sdat <- na.omit(steak_survey) %>%
    filter(region=="Mountain")

## Plot of Steak Preparation by Sex
ggplot(sdat, 
       aes(x = steak_prep, fill = female)) + 
    geom_bar(position="dodge") +
    ggtitle(paste0("Steak Preparation Preference by Gender for ","Mountain"," Region"))
