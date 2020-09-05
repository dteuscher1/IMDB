# Load packages
library(tidyverse)
library(caret)
library(DataExplorer)

# Read in the data
train <- read_csv("IMDBTrain.csv")
test <- read_csv("IMDBTest.csv") %>% rename(movie_title = Id)

# Combine the training and test sets
movies <- test %>% mutate(imdb_score = NA) %>% bind_rows(train)

# Select the variables that our group will clean 
movies_rates <- movies %>% select(movie_title, country, language, budget,
                                        gross, imdb_score, title_year)

# Plot of percentage of missing values for each variable
plot_missing(movies_rates)

# There are no missing titles and the imdb_score is available for all of the 
# movies in the training set

movies_rates %>% filter(is.na(language))
unique(movies_rates$language)
# There are only five missing values for language and so we replace them and then 
# we will have a indicator variable for each language
# Replace values for missing languages 
missing_languages <- c("English", "None", "None", "None", "None")
movies_rates$language[is.na(movies_rates$language)] <- missing_languages


# Scatterplot for budget vs. gross
ggplot(movies_rates, aes(x = budget, y = gross)) +
    geom_point()
cor(movies_rates$budget, movies_rates$gross, use = "complete.obs")

# There is a somewhat strong correlation between budget and gross, so we will
# use the median to impute the budget since budget has fewer missing values and then
# we will have a linear regression model that uses the budget to predict the gross

# Impute the budget median for the missing values
median(movies_rates$budget, na.rm = TRUE)
movies_rates$budget[is.na(movies_rates$budget)] <- median(movies_rates$budget, na.rm = TRUE)

# Fit the model to get predictions for the missing gross values
gross_missing <- movies_rates %>% filter(is.na(gross))
fit <- lm(gross~budget, data = movies_rates)

# Replace the missing values with the predictions from the model
preds <- predict(fit, newdata = gross_missing)
movies_rates$gross[is.na(movies_rates$gross)] <- preds
plot_missing(movies_rates)

