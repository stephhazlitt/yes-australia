## Dive into the tidy data to explore the influence of age,
## gender, participation on response by State and Division.

library(dplyr) # data munging and the pipe
library(tidyr) # wide to long dataframe
library(ggplot2) # plotting

## @knitr pre

## Load clean data if not already in local repository
if (!exists("responses")) load("tmp/clean_data.RData")

## @knitr states

## States: responses and participation
(state <- responses %>% 
    filter(grepl("Total", div) | div == "Australia") %>% 
    ggplot(aes(x = clear_response_percent, 
               y = clear_yes_percent)) + 
    geom_point(colour = "blue", size = 3) +
    geom_text(aes(label = state), colour = "grey30", hjust = 0, vjust = 1.5) +
    geom_hline(yintercept = 50, colour = "blue", linetype = 2) +
    ylab("Percent YES Vote") +
    xlab("Percent Participation") +
    theme_bw() +
    scale_x_continuous(limits = c(50, 100), expand = c(0,0),
                       breaks = seq(50, 100, by = 10),
                       labels = seq(50, 100, by = 10)) +
    scale_y_continuous(limits = c(45, 80), expand = c(0,0),
                       breaks = seq(45, 80, by = 5),
                       labels = seq(45, 80, by = 5)) +
    theme(axis.text = element_text(size=10),
          axis.title = element_text(size=10))
)


## States: responses and participation with CIs
# (state2 <- responses %>% 
#     filter(!grepl("Total", div)) %>%
#     filter(state != "Australia") %>%
#     select(state, div, clear_yes_percent, clear_response_percent, total_pop) %>%
#       group_by(state) %>% 
#       mutate(resp = mean(clear_response_percent),
#            sd_resp = sd(clear_response_percent),
#            yes = mean(clear_yes_percent),
#            sd_yes = sd(clear_yes_percent),
#            pop_size = sum(total_pop)) %>%
# #    gather(key = measure, value = value, clear_yes_count, clear_response_count, total_pop) %>% 
#     distinct(state, .keep_all = TRUE) %>% 
#     select(-div, -clear_response_percent, -clear_yes_percent, -total_pop) %>% 
#     ggplot(aes(x = resp, 
#                y = yes)) + 
#     geom_point(colour = "blue", size = 3) +
#     geom_errorbar(aes(ymin = yes+sd_yes, ymax = yes-sd_yes), width = 0.6, colour = "blue") +
#     geom_text(aes(label = state), colour = "grey30", hjust = 0, vjust = 1.5) +
#     ylab("Percent YES Vote") +
#     xlab("Percent Participation") +
#     theme_bw() +
#     scale_x_continuous(limits = c(55, 100), expand = c(0,0),
#                        breaks = seq(55, 100, by = 10),
#                        labels = seq(55, 100, by = 10)) +
#     scale_y_continuous(limits = c(40, 80), expand = c(0,0),
#                        breaks = seq(40, 80, by = 5),
#                        labels = seq(40, 80, by = 5)) +
#     theme(axis.text = element_text(size=10),
#           axis.title = element_text(size=10))
# )

## @knitr divisions

## Divisions: responses and participation
(divisions <- responses %>% 
  filter(!grepl(" Total)$", div)) %>% 
  filter(div != "Australia") %>% 
  mutate(outcome = if_else(clear_yes_percent>50, "YES", "NO")) %>% 
  ggplot(aes(x = clear_response_percent, 
                  y = clear_yes_percent)) + 
  geom_point(aes(colour = outcome)) +
  scale_colour_manual(values = c("red", "blue"), name = "Electorate Voting\nOutcome") +
  ylab("Percent YES Vote") +
  xlab("Percent Participation") +
  facet_wrap(~state, nrow = 2,
             labeller = label_wrap_gen(width = 25, multi_line = TRUE)) +
  geom_hline(yintercept = 50, colour = "blue", linetype = 2) +
  theme_bw() +
  theme(axis.text = element_text(size=10),
       axis.title = element_text(size=10))
)


## @knitr end

## Save PNGs of plots
png(filename = "./tmp/state.png", width = 500, height = 500, units = "px")
plot(state)
dev.off()

png(filename = "./tmp/divisions.png", width = 500, height = 500, units = "px")
plot(divisions)
dev.off()

