## Load Data from the Australia Bureau of Statistics 
## https://marriagesurvey.abs.gov.au/results/downloads.html

library(curl)
library(readxl)
library(readr)

url_responses <- "http://www.abs.gov.au/ausstats/abs@archive.nsf/log?openagent&australian_marriage_law_postal_survey_2017_-_response_final.xls&1800.0&Time%20Series%20Spreadsheet&916379DAEE6E960CCA2581F0001A08A9&0&2017&11.12.2017&Latest"
url_participation <- "http://www.abs.gov.au/ausstats/abs@archive.nsf/log?openagent&australian_marriage_law_postal_survey_2017_-_participation_final.xls&1800.0&Time%20Series%20Spreadsheet&830FD42482B309D6CA2581F0001A085B&0&2017&11.12.2017&Latest"

tmp <- dir.create("tmp", showWarnings = FALSE)

## Download the data
response_data <- curl_download(url_responses, destfile = "tmp/responses.xls")
participation_data <- curl_download(url_participation, destfile = "tmp/participation.xls")

## Import selections of the Excel sheets
responses.raw <- read_xls(response_data, range = "Table 2!A8:P183",
                          col_names = c("div", "clear_yes_count", "clear_yes_percent",
                                        "clear_no_count", "clear_no_percent", "clear_total_count", "clear_total_percent",
                                        "blank", "clear_response_count", "clear_response_percent", "not_clear_response_count",
                                        "not_clear_response_percent", "no_response_count", "no_response_percent",
                                        "total_pop", "tot_pop_percent"))

participation.raw <- read_xls(participation_data, range = "Table 4!A6:S650")
participation.males.raw <- read_xls(participation_data, range = "Table 5!A6:S650")
participation.females.raw <- read_xls(participation_data, range = "Table 6!A6:S650")

## Join table for States & Divisions
state.div <- read_csv("data/state_div_join.csv")

## Save raw data in tmp folder
save(responses.raw, participation.raw,
     participation.males.raw, participation.females.raw, 
     state.div, file = "tmp/raw_data.RData")