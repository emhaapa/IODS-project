#Emma Haapa, 16.2.2017. This is a file in which I wrangle the week 5 data.


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
