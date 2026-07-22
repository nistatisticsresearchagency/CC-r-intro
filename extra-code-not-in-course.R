
# Functions ----

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


# Lists
# Like vectors but can contain multiple different types of data
# can be nested to create data hierarcy
list_example <- list(1, "a", TRUE, 100L)

# Factors
# Factors are used to represent categorical data. 
# They can be ordered or unordered and contain levels
factor_sex <- factor(c("male", "female", "female", "male"))
# R will assign 1 to the level "female" and 2 to the level "male" 
# (because f comes before m, even though the first element in this vector is "male")
# You can check this by using the function levels(), 
# and check the number of levels using nlevels():
levels(factor_sex)
nlevels(factor_sex)