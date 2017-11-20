## Tidy the raw data files

library(dplyr) # data munging

## Load raw data if not already in local repository
if (!exists("responses.raw")) load("tmp/raw_data.RData")


## responses
responses <- responses.raw %>% 
  select(-blank) %>% 
  left_join(state.div) %>%
  filter(!is.na(div) & !is.na(clear_yes_count)) %>%
  filter(!grepl(" Divisions$", div)) %>% 
  mutate(div = replace(div, div=="Total", "Australia")) %>% 
  mutate(state = replace(state, is.na(state), "Australia"))

## participation
#participation <- participation.raw %>% 
  
## Save clean data in tmp folder
save(responses, file = "tmp/clean_data.RData")