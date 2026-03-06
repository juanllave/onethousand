library(tidyverse)

# Load the dataset
complete <- read_csv('H:/repos/R/onethousand/files/complete.csv')

# Pull the next album to listen to
next_album <- complete %>% 
  filter(is.na(Rating)) %>% 
  slice_sample(n = 1)

next_album

# Enter rating and notes to the listened album
next_album <- next_album %>% 
  replace_na(list(
    # Replace with correct values after each album has been listened to
    Rating = 4, 
    Notes = 'This is what seventies rock should have been like',
    Origin = 'us',
    `Generated Date` = Sys.Date()
  ))

# Merge the listened album to complete, re-run next_album
complete <- complete %>% 
  rows_update(next_album,
              by = 'id')

# Export csv file
write_csv(complete, 'H:/repos/R/onethousand/files/complete.csv')
