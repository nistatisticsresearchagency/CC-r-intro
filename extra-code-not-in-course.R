# THIS SCRIPT RUNS OFF DATAFRAMES CREATED IN R-INTRO-COFFEE-CODING.R
# YOU NEED TO HAVE CREATED THE 'character_details' AND 'new_character_details_piped' 
#  DATAFRAMES FROM THAT SCRIPT FOR SOME OF THE BELOW TO RUN
# IF UNSURE JUST RUN THE WHOLE R-INTRO-COFFEE-CODING.R SCRIPT

library(dplyr)
library(tidyr)




# Pivoting data ----
# a dataframe can be pivoted wider or longer with pivot_wider() and pivot_longer()
character_details_long <- character_details %>% 
  select(-Age) %>%
  pivot_longer(cols = c(first_name, surname), 
               names_to = "name type", 
               values_to = "name value")




# Joining data ----
# if we wanted to join another variable (height) onto the end of our original dataset we can use dplyr join statements
extra_info_for_merge <- data.frame(first_name = c("Obi-Wan", "Luke", "Darth", "Han", "Jar Jar", "R2", "Roos", "IG", "R4"),
                                   surname = c("Kenobi", "Skywalker", "Vader", "Solo", "Binks", "D2", "Tarpals", "88", "P17"),
                                   height_m = c(1.82, 1.75, 2.30, 1.86, 2.40, 1.20, 2.12, 0.78, 1.74))

character_details_merged <- character_details %>% 
  left_join(extra_info_for_merge, by = c("first_name", "surname"))




# Grouping and Summarising data ----
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




# Charts ----
# Graphs can be quickly created from data frames using the plotly or ggplot2 libraries
# We are going to look a ggplot2 today - plotly is just interactive version
library(ggplot2)

print(ggplot_plot <- ggplot(new_character_details_piped, aes(x = full_name, y = Age, fill = factor(Age))) +
        geom_col() +
        theme_minimal() +
        theme(legend.position = "none"))
# view in Plots tab

# The graphs will be shown in the viewer/plot tab in the bottom right of RStudio.




# Custom Functions ----
# We can write custom functions in R that will perform a series of operations when
# called by their name
# This function will add six to the number x, half it and output a sentence
my_fn <- function(x) {
  res <- (x + 6) / 2
  paste("The result of the function is", res)
}

my_fn(8)
my_fn(19)

# Functions can be as short or as long as you want and are handy when having
# to perform repetitive operations