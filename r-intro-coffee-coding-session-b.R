#################################################
# SESSION 1 RECAP
#################################################

# Import data
schools <- read.csv("postprimary_data.csv")

# Key dplyr functions
# filter()  -> keep rows
# select()  -> keep columns
# mutate()  -> create new columns
# arrange() -> sort rows

# Example workflow using the pipe (%>%)
schools_summary <- schools %>%
  mutate(
    total_enrolment =
      year_8 +
      year_9 +
      year_10 +
      year_11 +
      year_12 +
      year_13 +
      year_14
  ) %>%
  filter(school_type == "Grammar") %>%
  select(school_name, total_enrolment) %>%
  arrange(desc(total_enrolment))

schools_summary

# Export data

write.csv(
  schools_summary,
  "schools_summary.csv",
  row.names = FALSE
)

#################################################
# SESSION 2
#################################################

# Loops ----

# We can create a for loop to repeat a process.
# A loop works through a collection of values one at a time.

# Here we ask R to print the statement "My name is ___"
# for each value stored in the names vector.

names <- c("Brenda", "Joe", "Mike")

for (name in names) {
  print(paste("My name is", name))
}

# Summarising data ----

# Number of schools by type
schools %>%
  count(school_type)

# Average enrolment by school type
schools_agg <- schools %>%
  mutate(
    total_enrolment =
      year_8 +
      year_9 +
      year_10 +
      year_11 +
      year_12 +
      year_13 +
      year_14
  ) %>%
  group_by(school_type) %>%
  summarise(
    average_enrolment = mean(total_enrolment),
    total_enrolment = sum(total_enrolment)
  )


# if/else logic ----
# Last session we used logical tests such as x >= 3. 
# Today we're using those same logical tests inside if_else() to create a new variable.

# Create a school size group using if_else()

schools_enrolment <- schools %>%
  mutate(
    total_enrolment =
      year_8 +
      year_9 +
      year_10 +
      year_11 +
      year_12 +
      year_13 +
      year_14,
    school_size_group = if_else(
      total_enrolment < 1000,
      "Small/Medium",
      "Large"
    )
  )

# This works, but becomes harder to read as the number of conditions grows.
# a cleaner alternative is case_when

# case when logic ----

school_size_group = case_when(
  total_enrolment < 500 ~ "Small",
  total_enrolment < 1000 ~ "Medium",
  TRUE ~ "Large"
)

# join df ----
# Often our data is split across multiple files. 
# Rather than manually copying values between datasets, we can use a join to combine them.

fsme <- read.csv("postprimary_fsme.csv")

# Join FSME data onto the schools dataset, selecting only the variables we need

fsme <- fsme %>%
  select(
    deni_ref,
    fsme_number
  )

schools_joined <- schools %>%
  left_join(fsme, by = "deni_ref")


# Other joins exist:
# left_join()  - keep all rows from the first dataset
# inner_join() - keep only matching rows
# right_join() - keep all rows from the second dataset
# full_join()  - keep all rows from both datasets
# anti_join() - keep all from first that don't match second


# pivot data ----
# Sometimes data are too wide. 
# Here, each year group has its own column. 
# We can pivot the data longer so that year group becomes a variable.
library(tidyr)

# pivot longer ####
# select columns
schools_year <- schools %>%
  select(
    deni_ref,
    school_name,
    year_8:year_14
  )


schools_long <- schools_year %>%
  pivot_longer(
    cols = year_8:year_14,
    names_to = "year_group",
    values_to = "enrolment"
  )

# pivot wider ####

# create summary table
# 1. Group by council and school type.
# 2. Summarise to count the number of schools.
council_summary <- schools %>%
  group_by(
    district_council,
    school_type
  ) %>%
  summarise(
    schools = n()
  )

# 3. Pivot wider to turn school types into columns.
council_summary_wider <- council_summary %>%
  pivot_wider(
    names_from = school_type,
    values_from = schools,
    values_fill = 0
  )


# Simple chart ----

schools_chart <- schools_enrolment %>%
  group_by(school_type) %>%
  summarise(
    total_enrolment =
      sum(total_enrolment)
  ) %>%
  ggplot(
    aes(
      x = school_type, # School type on the x-axis
      y = total_enrolment, # total enrolment on the y-axis
      fill = school_type  # Fill bars according to school type
    )
  ) +
  geom_col() +  # Create a bar chart using the supplied values
  labs(
    title = "Total enrolment by school type",
    x = "School Type",
    y = "Enrolment"
  ) +
  theme_minimal() + # Apply a simple, clean theme
  theme(legend.position = "none") # Hide the legend as school type is already shown on the x-axis

schools_chart
