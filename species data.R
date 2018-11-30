library(dplyr)
library(tidyr)


veg_data <- read.csv("data/platt_veg_data_updated.csv") 

veg_data_by_plot <- select(veg_data, "BLOCK", "PLOT", "SPCODE", "FREQUENCY")

species_by_plot <- veg_data_by_plot %>% 
  mutate(id=1:n()) %>% 
  spread(SPCODE, FREQUENCY) 

species_by_plot[c("id")] <- list(NULL)

species_by_plot[is.na(species_by_plot)] <- 0