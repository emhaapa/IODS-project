# Emma Haapa, 9.2.2017, This is a file in which the second data wrangling excercise is executed,
# wrangling the data found in this link: https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION.
library(dplyr)
library(GGally)
library(ggplot2)
library(readr)
library(tidyr)
library(readr)
# Reading the student-mat.csv -file into memory with read_csv(), because the separator in the data is a semi-colon
math <- read_csv2("F:/IODS-project/data/student-mat.csv", 
                  col_names = TRUE,
                  col_types = NULL)
# Reading the student-por.csv -file into memory similarly with read_csv().                      
por <- read_csv2("F:/IODS-project/data/student-por.csv", 
                  col_names = TRUE,
                  col_types = NULL)

# Exploring the structure and dimensions of both data.
str(math)
dim(math) # 395 observations (rows), 33 variables (columns).
str(por)
dim(por) # 649 observations (rows), 33 variables (columns).


# Joining the two datasets using common columns as identifiers.

# Creating a common columns -vector to be used as the vector of identifiers.
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

# Joining the two datasets by the selected identifiers. Inner_join takes care of taking only the students present in both datasets.
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# Exploring the structure and dimensions of the joined data.
str(math_por)
dim(math_por) # 382 observations (rows), 53 variables (columns).
glimpse(math_por) # Same information could be obtained using the glimpse-function.

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# For-loop: for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}


# Defining a new column alc_use by combining weekday and weekend alcohol use using "mutate".
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc) # Everything is in order: the data set has 382 observations and 35 variables.
write.csv(alc, file = "F:/IODS-project/data/alc.csv") # separator is a comma
write.csv2(alc, file = "F:/IODS-project/data/alc2.csv") # separator is a semi-colon
