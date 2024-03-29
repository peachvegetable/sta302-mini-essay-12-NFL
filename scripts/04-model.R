#### Preamble ####
# Purpose: Generates two linear models, first with no feature engineering, second with feature engineering
# Author: Yihang Cai
# Date: 28 Mar 2024
# Contact: yihang.cai@mail.utoronto.ca
# Any other information needed? some of the codes are modified from Telling stories with Data by Rohan Alexander



#### Workspace setup ####
library(tidyverse)
library(arrow)
library(dplyr)
library(tidymodels)
library(ranger)
library(zoo)

#### Read data ####
analysis_data <- read_parquet("data/analysis_data/analysis_data.parquet")

### Model data ####
analysis_data <- analysis_data |>
  group_by(player_id) |>
  mutate(
    passing_epa_rolling_avg = rollapply(passing_epa, width = 3, FUN = mean, partial = TRUE, align = 'right', fill = NA)
  ) |>
  ungroup()

# Fill NA values in passing_epa_rolling_avg with the player's existing passing_epa values
analysis_data <- analysis_data |>
  group_by(player_id) |>
  mutate(passing_epa_rolling_avg = ifelse(is.na(passing_epa_rolling_avg), 0, passing_epa_rolling_avg)) |>
  ungroup()

nfl_training_data <- analysis_data |>
  filter(week >= 1 & week <= 9) 

first_model <- 
  linear_reg() |>
  set_engine("lm") |>
  fit(
    passing_epa ~ completions + passing_yards + passing_tds + interceptions + sacks + attempts,
    data = nfl_training_data
  )

second_model <-
  linear_reg() |>
  set_engine("lm") |>
  fit( 
    passing_epa ~ completions + passing_yards + passing_tds + interceptions + sacks + passing_epa_rolling_avg + attempts,
    data = nfl_training_data
  )
  
#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

saveRDS(
  second_model,
  file = "models/second_model.rds"
)



