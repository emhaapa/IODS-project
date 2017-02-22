data("Boston")
library(clusterSim)

data.Normalization (Boston,type="n1",normalization="column")
?data.Normalization


# euclidean distance matrix
dist_eu <- dist(Boston)

# k-means clustering
km <-kmeans(dist_eu, centers = 4)
km <-kmeans(dist_eu, centers = 6)
km <-kmeans(dist_eu, centers = 10)
km <-kmeans(dist_eu, centers = 15)
# plot the Boston dataset with clusters
pairs(Boston, col = km$cluster)

library(ggplot2)
# MASS, ggplot2 and Boston dataset are available
set.seed(123)

# determine the number of clusters
k_max <- 10

# calculate the total within sum of squares
twcss <- sapply(1:k_max, function(k){kmeans(dist_eu, k)$tot.withinss})

# visualize the results
plot(1:k_max, twcss, type='b')

# k-means clustering
km <-kmeans(dist_eu, centers = 1)

# plot the Boston dataset with clusters
pairs(Boston, col = km$cluster)



# k-means clustering
km <-kmeans(dist_eu, centers = 3)


# linear discriminant analysis
lda.fit <- lda(km$cluster ~ . , data = Boston)

# print the lda.fit object
lda.fit


# target classes as numeric
classes <- as.numeric(km$cluster)


plot(lda.fit, dimen = 3, col = classes, pch= classes)
# the function for lda biplot arrows
lda.arrows <- function(x, myscale = 1, arrow_heads = 0.1, color = "red", tex = 0.75, choices = c(1,2)){
  heads <- coef(x)
  arrows(x0 = 0, y0 = 0, 
         x1 = myscale * heads[,choices[1]], 
         y1 = myscale * heads[,choices[2]], col=color, length = arrow_heads)
  text(myscale * heads[,choices], labels = row.names(heads), 
       cex = tex, col=color, pos=3)
}

# plot the lda results
plot(lda.fit, dimen = 2, col  =classes, pch =classes)
lda.arrows(lda.fit, myscale = 20)
---
  library(gmodels)
library(gdata)
library(dplyr) #accessed the dplyr-library
library(ggplot2) #accessed the ggplot2-library
library(readr) #accessed the readr-library
library(tidyr) #accessed tidyr-library

Boston <- mutate(Boston, high_crim = crim > 3.6 )


# initialize a plot of high_use and G3
g6 <- ggplot(Boston, aes(x = high_crim, y = lstat))

# define the plot as a boxplot and draw it.
g6 + geom_boxplot() + ggtitle("Crime rate by lower status of the population (%)")



# initialize a plot of high_use and G3
g7 <- ggplot(Boston, aes(x = high_crim, y = rad))

# define the plot as a boxplot and draw it
g7 + geom_boxplot() + ggtitle("Crime rate by index of accessibility to radial highways")


  
  # plot matrix of the variables
  pairs(Boston)
library(tidyverse)
library(corrplot)
# calculate the correlation matrix and round it
cor_matrix<-cor(Boston)

# print the correlation matrix
cor_matrix <- cor_matrix%>%round(2)
cor_matrix

# visualize the correlation matrix
corrplot(cor_matrix, method="circle", type = "upper", cl.pos = "b", tl.pos ="d", tl.cex = 0.6)

  
  
  # center and standardize variables
  boston_scaled <- scale(Boston)

# summaries of the scaled variables
summary(boston_scaled)

# change the object to data frame

boston_scaled <- as.data.frame(boston_scaled)  

str(boston_scaled)
  
  library(plyr)
library(dplyr)
library(corrplot)
library(tidyverse)
# boston_scaled is available
# save the scaled crim as scaled_crim

scaled_crim <- scale(boston_scaled$crim)

scaled_crim
# create a quantile vector of crim and print it
bins <- quantile(scaled_crim)

# create a categorical variable 'crime'
crime <- cut(scaled_crim, breaks = bins, include.lowest = TRUE, labels(c("low", "med-low", "med-high", "high")))

# look at the table of the new factor crime
#table(crime)

# remove original crim from the dataset
boston_scaled <- dplyr::select(boston_scaled, -crim)

# add the new categorical value to scaled data
boston_scaled <- data.frame(boston_scaled, crime)

# number of rows in the Boston dataset 
n <- nrow(boston_scaled)

# choose randomly 80% of the rows
ind <- sample(n,  size = n * 0.8)
# create train set
train <- boston_scaled[ind,]
# create test set 
test <- boston_scaled[-ind,]

# save the correct classes from test data
correct_classes <- test$crime




summary(train$crim)
# remove the crime variable from test data
test <- dplyr::select(test, -crime)

  
  
library(MASS)
# linear discriminant analysis
lda.fit <- lda(crime ~ . , data = train)

# print the lda.fit object
lda.fit

# target classes as numeric
classes <- as.numeric(train$crime)


plot(lda.fit, dimen = 3, col = classes, pch= classes)
# the function for lda biplot arrows
lda.arrows <- function(x, myscale = 1, arrow_heads = 0.1, color = "red", tex = 0.75, choices = c(1,2)){
  heads <- coef(x)
  arrows(x0 = 0, y0 = 0, 
         x1 = myscale * heads[,choices[1]], 
         y1 = myscale * heads[,choices[2]], col=color, length = arrow_heads)
  text(myscale * heads[,choices], labels = row.names(heads), 
       cex = tex, col=color, pos=3)
}

# plot the lda results
plot(lda.fit, dimen = 2, col  =classes, pch =classes)
lda.arrows(lda.fit, myscale = 10)


# lda.fit, correct_classes and test are available
# predict classes with test data
lda.pred <- predict(lda.fit, newdata = test)

str(boston_scaled)

# cross tabulate the results
table(correct = correct_classes, predicted = lda.pred$class)