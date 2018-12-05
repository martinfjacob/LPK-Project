#' Input fire history data and create ggplot with number of fires by block
#' 

library(dplyr)
library(ggplot2)

fire_history <- read.csv('data/LPK_Fire_HIstory.csv')

fire_totals <- select(fire_history, Block, Disc_Date) %>%
  group_by(Block) %>% 
  summarise(abundance = n())

fire_interval <- select(fire_history, Block, Fire_Interval) %>%
  group_by(Block) %>% 
  mutate(interval_years = Fire_Interval / 365) %>%
  na.omit() %>% 
  summarise(FRI = mean(interval_years)) 

fire_by_year <- select(fire_history, Block, Fire_Interval) %>%
  group_by(Block) %>% 
  mutate(interval_years = Fire_Interval / 365) %>%
  na.omit()
  
# Number of fire events per unit
ggplot() +
  geom_point(data = fire_totals, aes(x = Block, y = abundance)) +
  labs(x = "Burn Unit", y = "Number of Fires")

# Fire interval pattern by date
ggplot(fire_interval, aes(x = Block, y = Fire_Interval)) +
  geom_point(stat = "identity")

# Fire interval
ggplot(fire_interval, aes(x = Block, y = FRI)) +
  geom_point() +
  labs(x = "Burn Unit", y = "Fire Return Interval")

# Graph of fire intervals for each block 
ggplot() +
  geom_histogram(data = fire_by_year, aes(x = interval_years, fill = Block))

ggplot(fire_by_year, aes(x = Block, y = interval_years)) +
  geom_line() +
  labs(x = "Burn Unit", y = "Fire Return Interval")

           
