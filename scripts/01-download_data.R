#### Preamble ####
# Purpose: Downloads and saves the data from nflverse
# Author: Yihang Cai
# Date: 28 Mar 2024
# Contact: yihang.cai@mail.utoronto.ca
# Any other information needed? some of the codes are modified from Telling stories with Data by Rohan Alexander


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

         
