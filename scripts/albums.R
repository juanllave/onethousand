library(tidyverse)
library(rvest)

# Get the full list from the website
url <- 'https://1001albumsgenerator.com/albums'
page <- read_html(url)

full <- page %>% 
  html_element('table') %>% 
  html_table()

names(full)[1:4] <- c('Album','Artist','Released','Genres')

# Upload the listened table
listened <- read_csv('H:/repos/R/onethousand/files/complete.csv')

# Merge the tables
complete <- full_join(full, listened,
                      by = c('Artist','Album','Released','Genres')) %>% 
  mutate(id = row_number())

# Pull the next album to listen to
next_album <- complete %>% 
  filter(is.na(Rating)) %>% 
  slice_sample(n = 1)

# Enter rating and notes to the listened album
next_album <- next_album %>% 
  replace_na(list(
    # Replace with correct values after every album has been listened to
    Rating = 5, 
    Notes = 'This is as good as it gets. What a beauty.',
    Origin = 'uk',
    `Generated Date` = Sys.Date()
  ))

# Merge the listened album to complete, re-run next_album
complete <- complete %>% 
  rows_update(next_album,
              by = 'id')

# Export csv file
write_csv(complete, 'H:/repos/R/onethousand/files/complete.csv')
