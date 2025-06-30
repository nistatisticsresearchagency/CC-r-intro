library(dplyr)
library(tidyr)

# Pivot ----
# a dataframe can be pivoted wider or longer with pivot_wider() and pivot_longer()
character_details_long <- character_details %>% 
  select(-Age) %>%
  pivot_longer(cols = c(first_name, surname), 
               names_to = "name type", 
               values_to = "name value")
# Join ----
# if we wanted to join another variable (height) onto the end of our original dataset we can use dplyr join statements
extra_info_for_merge <- data.frame(first_name = c("Obi-Wan", "Luke", "Darth", "Han", "Jar Jar", "R2", "Roos", "IG", "R4"),
                                   surname = c("Kenobi", "Skywalker", "Vader", "Solo", "Binks", "D2", "Tarpals", "88", "P17"),
                                   height_m = c(1.82, 1.75, 2.30, 1.86, 2.40, 1.20, 2.12, 0.78, 1.74))

character_details_merged <- character_details %>% 
  left_join(extra_info_for_merge, by = c("first_name", "surname"))

# Grouping and summarising ----
# if we want to sum and condense a dataset by a given variable we can do
# that as follows - with a group_by() on the variable we want to group with
# and a summarise to tell R to sum or calculate by that grouping

# to do this on character_details_merged we need to add some extra variables first

character_details_grouped <- cbind(character_details_merged, 
                                   species = c("Human", "Human", "Human", "Human", "Gungan", "Droid", 
                                               "Gungan", "Droid", "Droid"))

character_details_grouped <- character_details_grouped %>% 
  group_by(species) %>% 
  summarise(avg_age = mean(Age), max_age = max(Age), min_age = min(Age))
