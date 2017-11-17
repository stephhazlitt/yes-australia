## Dive into the tidy data to explore the influence of age,
## gender, participation on response by State and Division.

library(dplyr) # data munging and the pipe
library(ggplot2) # plotting

## Load clean data if not already in local repository
if (!exists("responses")) load("tmp/clean_data.RData")

## States: responses and participation
(state <- responses %>% 
    filter(grepl("Total", div) | div == "Australia") %>% 
    ggplot(aes(x = clear_response_percent, 
               y = clear_yes_percent)) + 
    geom_point(colour = "blue") +
    geom_text(aes(label = state), colour = "grey30", hjust = 0, vjust = 1.5) +
    ylab("Percent YES Vote") +
    xlab("Percent Participation") +
    theme_bw() +
    scale_x_continuous(limits = c(50, 100), expand = c(0,0),
                       breaks = seq(50, 100, by = 10),
                       labels = seq(50, 100, by = 10)) +
    scale_y_continuous(limits = c(55, 75), expand = c(0,0),
                       breaks = seq(55, 75, by = 5),
                       labels = seq(55, 75, by = 5)) +
    theme(axis.text = element_text(size=10),
          axis.title = element_text(size=10))
)

## Save PNG of plot
png(filename = "./tmp/state.png", width = 500, height = 500, units = "px")
plot(state)
dev.off()

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
  theme_bw() +
  theme(axis.text = element_text(size=10),
       axis.title = element_text(size=10))
)

## Save PNG of plot
png(filename = "./tmp/divisions.png", width = 500, height = 500, units = "px")
plot(divisions)
dev.off()
