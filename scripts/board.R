library(tidyverse)
library(ggiraph)

board <- complete %>% 
  select(-`Global Rating`) %>% 
  filter(!is.na(Rating)) %>% 
    mutate(Decade = paste0((Released %/% 10) * 10, 's')
  )

plot1 <- board %>% 
  ggplot() +
  aes(y = Rating) +
  geom_boxplot()
