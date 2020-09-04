# Load packages
library(tidyverse)
library(caret)
library(DataExplorer)

# Read in the data
train <- read_csv("IMDBTrain.csv")
test <- read_csv("IMDBTest.csv")

# Combine the training and test sets
movies <- test %>% mutate(imdb_score = NA) %>% bind_rows(train)

exchange_rates <- read_csv("exchange_rates.csv")

movies_rates <- movies %>% left_join(exchange_rates, by = "country") 

movies_rates <- movies_rates %>% select(movie_title, country, language, budget, 
                                        exchange_rate, gross, imdb_score)
plot_missing(movies_rates)
