## Dive into the tidy data

library(ggplot2) # plotting

## Load clean data if not already in local repository
if (!exists("state.responses")) load("tmp/clean_data.RData")

(div.resp.plot <- div.responses %>% 
  filter(!grepl(" Total)$", div)) %>% 
  filter(div != "Total") %>% 
  ggplot(aes(x = clear_response_percent, 
                  y = clear_yes_percent)) + 
  geom_point() +
  facet_wrap(~state, nrow = 2)
)
 
(tot.resp.plot <- div.responses %>% 
    filter(grepl("Total", div)) %>% 
    filter(div != "Total") %>% 
    ggplot(aes(x = clear_response_percent, 
               y = clear_yes_percent)) + 
    geom_point()
)