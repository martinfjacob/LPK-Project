#' Input fire history data and create ggplot with number of fires by block
#' 

library(dplyr)
library(ggplot2)

fire_history <- read.csv('data/LPK_Fire_HIstory.csv')

fire_totals <- select(fire_history, Block, Disc_Date) %>%
  group_by(Block) %>% 
  summarise(abundance = n())

fire_interval <- as.data.frame(select(fire_history, Block, Fire_Interval)) %>%
  group_by(Block)
  

ggplot() +
  geom_point(data = fire_totals, aes(x = Block, y = abundance)) +
  labs(x = "Burn Unit", y = "Number of Fires")

ggplot(fire_interval, aes(x = Block, y = Fire_Interval)) +
  geom_point(stat = "identity")


