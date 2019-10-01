library(tidyverse)
load("rda/edx.rda")
load("rda/validation.rda")

RMSE <- function(true_ratings, predicted_ratings) {
  sqrt(mean((true_ratings - predicted_ratings)^2))
}

mu <- mean(edx$rating)
lambda <- 5.25

movie_reg_avgs <- edx %>%
  group_by(movieId) %>%
  summarize(b_i = sum(rating - mu) / (n() + lambda))

user_reg_avgs <- edx %>% 
  left_join(movie_reg_avgs, by='movieId') %>%
  group_by(userId) %>%
  summarize(b_u = sum(rating - b_i - mu)/(n() + lambda))

user_movie_resids <- edx %>% 
  left_join(movie_reg_avgs, by='movieId') %>%
  left_join(user_reg_avgs, by='userId') %>%
  mutate(resid = rating - mu - b_i - b_u) %>%
  select(userId, movieId, resid)

predicted_ratings <- validation %>% 
  left_join(movie_reg_avgs, by='movieId') %>%
  left_join(user_reg_avgs, by='userId') %>%
  left_join(user_movie_resids, by=c("userId", "movieId")) %>%
  mutate(resid = ifelse(is.na(resid), 0, resid), pred = mu + b_i + b_u + resid) %>%
  pull(pred)

rmse <- RMSE(predicted_ratings, validation$rating)
print(rmse)