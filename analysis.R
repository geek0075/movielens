# Load libraries
library(tidyverse)
# Load data
# Please see https://github.com/geek0075/movielens
# Follow instructions in Github README to download and prepare data below.
# GitHub large file policy (https://help.github.com/en/articles/conditions-for-large-files) prevents me from including these directly
load("rda/edx.rda")
load("rda/validation.rda")

# define Loss function (RMSE)
RMSE <- function(true_ratings, predicted_ratings) {
  sqrt(mean((true_ratings - predicted_ratings)^2))
}

# Compute estimate of global average rating
mu <- mean(edx$rating)

# Assign regularization penalty as determined using cross-validation (see report)
lambda <- 5.25

# Compute estimates of regularized average rating per movie
movie_reg_avgs <- edx %>%
  group_by(movieId) %>%
  summarize(b_i = sum(rating - mu) / (n() + lambda))

# Compute estimates of regularized average rating per user
user_reg_avgs <- edx %>% 
  left_join(movie_reg_avgs, by='movieId') %>%
  group_by(userId) %>%
  summarize(b_u = sum(rating - b_i - mu)/(n() + lambda))

# Compute estimates of residuals
user_movie_resids <- edx %>% 
  left_join(movie_reg_avgs, by='movieId') %>%
  left_join(user_reg_avgs, by='userId') %>%
  mutate(resid = rating - mu - b_i - b_u) %>%
  select(userId, movieId, resid)

# Compute predictions by applying trained model to validation set
predicted_ratings <- validation %>% 
  left_join(movie_reg_avgs, by='movieId') %>%
  left_join(user_reg_avgs, by='userId') %>%
  left_join(user_movie_resids, by=c("userId", "movieId")) %>%
  mutate(resid = ifelse(is.na(resid), 0, resid), pred = mu + b_i + b_u + resid) %>%
  pull(pred)

# Compute and print RMSE
rmse <- RMSE(predicted_ratings, validation$rating)
print(rmse)