library(tidyverse)
library(CodeClanData)

sales <- game_sales %>% 
  rename(year = year_of_release) %>% 
  mutate(avg_reviews = ((user_score * 10) + critic_score) /2 )

# Lists for dropdowns
list_genre <- unique(sales$genre)
list_publisher <- unique(sales$publisher)
list_platform <- unique(sales$platform)

# Key stat outputs
top_seller <- sales %>% 
  slice_max(order_by = sales, n = 1) %>% pull(name)

top_genre_critics <- sales %>% 
  group_by(genre) %>% 
  summarise(mean_critic_score = mean(critic_score)) %>% 
  slice_max(order_by = mean_critic_score, n = 1) %>% pull(genre)

top_genre_users <- sales %>% 
  group_by(genre) %>% 
  summarise(mean_user_score = mean(user_score)) %>% 
  slice_max(order_by = mean_user_score, n = 1) %>% pull(genre)

sales_2016 <- sales %>% 
  filter(year == 2016) %>%
  summarise(tot_sales = sum(sales)) %>% pull(tot_sales)

top_rated <- sales %>% 
  slice_max(order_by = avg_reviews, n = 1) %>% pull(name)


