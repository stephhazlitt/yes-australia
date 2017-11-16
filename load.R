## Load Data from the Australia Bureau of Statistics 
## https://marriagesurvey.abs.gov.au/results/downloads.html

library(curl)
library(readxl)
library(readr)

url_responses <- "https://marriagesurvey.abs.gov.au/results/files/australian_marriage_law_postal_survey_2017_-_response_final.xls"
url_participation <- "https://marriagesurvey.abs.gov.au/results/files/australian_marriage_law_postal_survey_2017_-_participation_final.xls"
tmp <- dir.create("tmp", showWarnings = FALSE)
responses <- "responses.xls"
participation <- "participation.xls"

## Download the data
response_data <- curl_download(url_responses, destfile = "tmp/responses.xls")
participation_data <- curl_download(url_participation, destfile = "tmp/participation.xls")

## Import selections of the Excel sheets
state.responses.raw <- read_xls(response_data, range = "Table 1!A8:P16",
                            col_names = c("state", "clear_yes_count", "clear_yes_percent",
                                          "clear_no_count", "clear_no_percent", "clear_total_count", "clear_total_percent",
                                          "blank", "clear_response_count", "clear_response_percent", "not_clear_response_count",
                                          "not_clear_response_percent", "no_response_count", "no_response_percent",
                                          "total_pop", "tot_pop_percent"))
div.responses.raw <- read_xls(response_data, range = "Table 2!A8:P183",
                          col_names = c("div", "clear_yes_count", "clear_yes_percent",
                                        "clear_no_count", "clear_no_percent", "clear_total_count", "clear_total_percent",
                                        "blank", "clear_response_count", "clear_response_percent", "not_clear_response_count",
                                        "not_clear_response_percent", "no_response_count", "no_response_percent",
                                        "total_pop", "tot_pop_percent"))

state.part.raw <- read_xls(participation_data, range = "Table 1!A6:S41")
state.part.males.raw <- read_xls(participation_data, range = "Table 2!A6:S41")
state.part.females.raw <- read_xls(participation_data, range = "Table 3!A6:S41")
div.part.raw <- read_xls(participation_data, range = "Table 4!A6:S41")
div.part.males.raw <- read_xls(participation_data, range = "Table 5!A6:S41")
div.part.females.raw <- read_xls(participation_data, range = "Table 6!A6:S41")

## Join table for States & Divisions
state.div <- read_csv("data/state_div_join.csv")

## Save raw data in tmp folder
save(state.responses.raw, div.responses.raw, state.part.females.raw,
     state.part.raw, state.part.males.raw, div.part.raw,
     div.part.males.raw, div.part.females.raw, state.div,
     file = "tmp/raw_data.RData")