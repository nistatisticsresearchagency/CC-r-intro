# Intro to R and RStudio

# NOTE - you should have run renv setup with renv::restore() before starting


# R Basics ----

# This script is contained within a Project, denoted by the .Rproj file in the folder
# Projects are useful for containing all of your code/input data/functions in one place  

# Script pane: write and save code. 
# Console: run temporary commands and shows results from script or console commands.
# Use Ctrl + Enter (or Run) to execute code.
  
# Comments start with #
# Ctrl + Shift + C comments/uncomments lines


# Data Types ----

5                  # Number
"Bumblebee"        # Text

# Expressions
5 + 5
paste("Bumble", "Bee") # all functions, such as paste0 are followed by ( ) and will require certain arguments

# Anything unassigned that is sent to the Console only exists there, it is not stored

# Store values in the environment using <-
my_name <- "Leonie"

# View stored values in the Environment pane
my_name

# Use variables in calculations
x <- 6
x + 7

# Logical values
y <- TRUE



# Data structures in R ----

# Vectors: store multiple values of the same type
names <- c("Brenda", "Joe", "Mike")
values <- c(1, 3, 5)

# Data frames: tables made up of vectors
# After running this line double click on df in the environment to view the data
df <- data.frame(names, values)

# View a column from df using a $ separator
df$names

# Number of rows
nrow(df)

# Create a new column - base R method
df$values_doubled <- df$values * 2


# Logic ----

# Check whether a condition is TRUE or FALSE
my_name == "Leonie"

# Note that we use a double equals sign == in logical commands
# be careful not to confuse with a single equals which is the same as using <- 
my_name = "Brian"

# Other operators
x < 7
x >= 3
x != 4

# If/Else statements
if (my_name == "Leonie") {
  "It's me"
} else {
  "Not you"
}


# Packages ----
# Since R is run by an open source community it is always expanding and improving and 
# there are many different packages that can be installed to increase its functionality on top of BASE R
# we have already ran renv to install the packages we need

# Load packages ----
# To use an already installed R package in an R project we call it with library()
library(dplyr)
library(ggplot2)

# dplyr adds many functions that can be used to transform data. We will use some of those below.
# We are also going to use the pipe %>% operator as it allows us to
# chain commands together and create a pipe

# importing data
# mutate(): add a new column
# select(): reorder, and select columns
# filter(): subset rows in a data frame based on a condition
# arrange(): sort data by a particular column
# group_by() + summarise()
# a simple ggplot


# Import data ----
# library(readr)
schools <- read.csv("postprimary_data.csv")

# read in excel files - need readxl library
# library(readxl)
# schools <- read_excel("postprimary_data.xlsx")

# SPSS
# library(haven)
# schools <- read_sav("postprimary_data.sav")


# Explore the data ----
head(schools)

names(schools)

nrow(schools)

# Create a new variable ----

# Calculate total enrolment across all year groups
schools_enrolment <- schools %>%
  mutate(
    total_enrolment =
      year_8 +
      year_9 +
      year_10 +
      year_11 +
      year_12 +
      year_13 +
      year_14
  )

# View selected columns
schools_selected <- schools_enrolment %>%
  select(
    school_name,
    school_type,
    integrated,
    total_enrolment
  )

# Filtering data ----

# Grammar schools only
schools_grammar <- schools %>%
  filter(school_type == "Grammar")

# Sorting data ----

# Smallest schools first - default is ascending
schools <- schools_enrolment %>%
  arrange(total_enrolment)

# Largest schools first
schools <- schools_enrolment %>%
  arrange(desc(total_enrolment))


# Using multiple dplyr functions together ----
# Using the pipe operator means not having to declare which data frame 
# we are using at each step
# The result of each step in the piped commands is passed to the next step
# Note how the resultant data frames are identical

# if you need to break into a pipe partway through you can separate out the statements
# or you can highlight up to the pipe on a selection of rows and run that

school_summary <- schools %>%
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
  select(
    school_type,
    school_name,
    total_enrolment
  ) %>%
  arrange(desc(total_enrolment))

school_summary


#################################################
# EXERCISE
#################################################

# Create a table showing enrolment for integrated schools by school and district council.

### REMINDER
### You can test part of your pipe by selecting from the start of it, up to just before the pipe operator on the line you want to run
### and run those lines only

# Steps:
# 1. Filter to integrated schools
# 2. Select school name, district council and total enrolment
# 3. Sort by district council (ascending)

integrated_schools <- schools %>%
  filter(xxxx == "Yes") %>%
  select(
    xxxx,
    xxxx,
    xxxx
  ) %>%
  arrange(xxxx)

integrated_schools

# Rename columns ----

integrated_schools_export <- integrated_schools %>%
  rename(
    `School Type` = school_type,
    `School Name` = school_name,
    `Total Enrolment` = total_enrolment
  )

# Export data ----

write.csv(
  integrated_schools_export,
  "integrated_schools_council.csv",
  row.names = FALSE
)


# Keyboard shortcuts ----
# assignment operator: Alt + -
# Pipe: Ctrl + Shift + M

