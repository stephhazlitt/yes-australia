## Tidy the raw data files

library(dplyr) # data munging

## Load raw data if not already in local repository
if (!exists("state.responses")) load("tmp/raw_data.RData")
