#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(nflverse)
library(tidyverse)
library(arrow)

#### Download data ####
qb_regular_season_stats <- 
  load_player_stats(seasons = TRUE) |> 
  filter(season_type == "REG" & position == "QB")



#### Save data ####
write_parquet(qb_regular_season_stats, "data/raw_data/raw_data.parquet") 

         
