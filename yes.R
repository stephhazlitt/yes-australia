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

state.responses <- read_xls(data, range = "Table 1!A5:P16")
div.responses <- read_xls(data, range = "Table 2!A5:P183")