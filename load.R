## Load Data from the Australia Bureau of Statistics 
## https://marriagesurvey.abs.gov.au/results/downloads.html

library(readxl)

url_responses <- "https://marriagesurvey.abs.gov.au/results/files/australian_marriage_law_postal_survey_2017_-_response_final.xls"
url_participation <- "https://marriagesurvey.abs.gov.au/results/files/australian_marriage_law_postal_survey_2017_-_participation_final.xls"
tmp <- dir.create("tmp", showWarnings = FALSE)
responses <- "responses.xls"
participation <- "participation.xls"

response_data <- curl_download(url_responses, destfile = "tmp/responses.xls")
participation_data <- curl_download(url_participation, destfile = "tmp/participation.xls")

state.responses <- read_xls(response_data, range = "Table 1!A5:P16")
div.responses <- read_xls(response_data, range = "Table 2!A5:P183")

state.part <- read_xls(participation_data, range = "Table 1!A6:S41")
state.part.males <- read_xls(participation_data, range = "Table 2!A6:S41")
state.part.females <- read_xls(participation_data, range = "Table 3!A6:S41")

save(state.responses, div.responses, state.part.females,
     state.part, state.part.males,
     file = "tmp/raw_data.RData")