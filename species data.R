library(dplyr)
library(tidyr)

write.csv(veg_data, "new_veg_data.csv", row.names = FALSE)
veg_data <- read.csv("data/new_veg_data.csv") 


veg_data_by_plot <- select(veg_data, "BLOCK", "PLOT", "SPCODE", "FREQUENCY")

species_by_plot <- veg_data_by_plot %>% 
  mutate(id=1:n()) %>% 
  spread(SPCODE, FREQUENCY) 

species_by_plot[c("id")] <- list(NULL)

species_by_plot[is.na(species_by_plot)] <- 0

time_since_fire <- read.csv("data/ENP_PlattSlocum_Fire.csv")


