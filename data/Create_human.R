# Emma Haapa, 16.2.2017. 
# This is a file in which I wrangle the week 5 human data.
# The data: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt
# The unwrangled (separated hd and gii) data can be found in the links in the reading the data
# part of the last week's exercise below.

library(gmodels)
library(gdata)
library(dplyr) #accessed the dplyr-library
library(ggplot2) #accessed the ggplot2-library
library(readr) #accessed the readr-library
library(tidyr) #accessed tidyr-library

# Reading the data into R

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Summaries of the data

glimpse(hd)
str(hd)
summary(hd)
colnames(hd)

glimpse(gii)
str(gii)
summary(gii)
colnames(gii)

colnames(hd)[1] <- "HDIR"
colnames(hd)[2] <- "Country"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "LifeExp"
colnames(hd)[5] <- "YrsEduExp"
colnames(hd)[6] <- "YrsEduMean"
colnames(hd)[7] <- "GNIpercapita"
colnames(hd)[8] <- "GNIpercapita-HDIR"



colnames(gii)[1] <- "GIIR"
colnames(gii)[2] <- "Country"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "MaternalMort"
colnames(gii)[5] <- "AdolBirth"
colnames(gii)[6] <- "RepParliament"
colnames(gii)[7] <- "edu2F"
colnames(gii)[8] <- "edu2M"
colnames(gii)[9] <- "labF"
colnames(gii)[10] <- "labM"

# Changed the names of the columns into more tidy and easily understandable ones.

gii <- mutate(gii, eduRatioFM = edu2F/edu2M)# Adding the variable eduRatioFM
gii <- mutate(gii, labRatioFM = labF / labM)# Adding the variable labRatioFM


library(dplyr) # Accessing dplyr

gii$Country == hd$Country # TRUE on all counts


Country <- c(gii$Country)


# common columns to use as identifiers
join_by <- c("Country")


options(max.print=1000000) #maxprint, just in case

# join the two datasets by the selected identifier
human <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))
write.csv(human, file = "F:/IODS-project/data/human1.csv") # separator is a comma
write.csv2(human, file = "F:/IODS-project/data/human.csv") # separator is a semi-colon

dim(human) #195 observations, 19 variables. OK.

library(dplyr)
library(stringr)

colnames(human)
# Mutating GNIpercapita to numeric using mutate()
human <- mutate(human, GNIpercapita = as.numeric(str_replace(human$GNIpercapita, pattern=",", replace ="")))

# Getting rid of non-needed variables by only selecting those we are interested in.
human <- select(human, one_of('Country','eduRatioFM','labRatioFM','YrsEduExp','LifeExp','GNIpercapita','MaternalMort','AdolBirth','RepParliament'))

# Using na.omit to get rid of NAs (could have done it by using
# complete.cases in a similar way as in DataCamp but I found that
# this approach also worked [one could argue which is the more
# teaching of the approaches...])
human <- na.omit(human)

# Remove non-countries (last 7)
human <- head(human, -7)

# Defining countries as rownames
rownames(human) <- human$country
human <- human[,-1] # Removing country name column from the data.
glimpse(human) # Having a glimpse at the data,


# Overwriting the human dataset by using wirte.table.
write.table(human, file = "human.csv", sep = "\t", col.names = TRUE)

glimpse(human) # A final glimpse to see whether the variable/observation
# is correct. It is. The dimensions are 155 observations and 8 variables.
