#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(arrow)

#### Clean data ####
raw_data <- read_parquet("data/raw_data/raw_data.parquet")

cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  select(player_id, recent_team, season, week, passing_epa, season_type, completions, interceptions, passing_tds, attempts, sacks, passing_yards) |>
  filter(
    season_type == "REG", season == 2023
  )

#### Save data ####
write_parquet(cleaned_data, "data/analysis_data/analysis_data.parquet")
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
