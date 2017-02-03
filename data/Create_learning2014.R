#Emma Haapa, 1.2.2017. This is a file in which the first actual data wrangling excercise is executed.

# Reading the full learning14 data into R
learning14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# The dimensions of the data:
dim(learning14)
# The learning14 data has 183 rows and 60 columns, i. e. 183 observations and 60 variables.

# The structure of the data:
str(learning14)
# The str-function also states that there are 183 observations and 60 variables in the data. The variables are coded as combinations of letters that refer to the statement or question as a variable.

library(dplyr) #accessed tge dplyr-library

# print the "Attitude" column vector of the lrn14 data
learning14$Attitude

# divide each number in the column vector
learning14$Attitude / 10

# create column 'attitude' by scaling the column "Attitude"
learning14$attitude <- learning14$Attitude / 10


# Creating objects that refer to all the questions that assess different types of learning: deep, surface and strategic learning.
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Selecting columns that have to do with deep learning and creating a column deep by averaging.
deep_columns <- select(learning14, one_of(deep_questions))
learning14$deep <- rowMeans(deep_columns)

# Selecting columns that have to do with surface learning and creating a column surf by averaging.
surface_columns <- select(learning14, one_of(surface_questions))
learning14$surf <- rowMeans(surface_columns)

#  Selecting columns that have to do with strategic learning and creating a column stra by averaging.
strategic_columns <- select(learning14, one_of(strategic_questions))
learning14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(learning14, one_of(keep_columns))

# print out the column names of the data
colnames(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# print out the new column names of the data
colnames(learning2014)

# Selecting the rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)

# Stucture of the new dataset
str(learning2014)
options(max.print=1000000)

?write.csv
write.table(learning2014, file = "learning2014.txt", append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")
read.table(file = "learning2014.txt")
str(learning2014)
head(learning2014)
