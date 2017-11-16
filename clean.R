## Tidy the raw data files

library(dplyr) # data munging

## Load raw data if not already in local repository
if (!exists("state.responses")) load("tmp/raw_data.RData")

## state responses
state.responses <- state.responses.raw %>% 
  select(-blank) 

## div responses
div.responses <- div.responses.raw %>% 
  select(-blank) %>% 
  left_join(state.div) %>%
  filter(!is.na(div) & div != "Australia") %>%
  filter(!grepl(" Divisions$", div))
  