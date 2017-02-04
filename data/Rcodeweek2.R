options(max.print=1000000)
learning2014 <- read.table(file = "learning2014.txt")

library(dplyr) #accessed the dplyr-library
library(ggplot2) #accessed the ggplot2-library

# First, as an example, I will follow the idea in the DataCamp exercise and draw
# a plot of attitude versus exam points with gender specifying the plots. 
# Also a regression line is added to the plots, one for both genders (if gender is
# male, the line is blue and if female, the line is red.) The regression line is fitted 
# using the least squares approach so that
#

p1 <- ggplot(learning2014, aes(x = attitude, y = points, col =gender))

# define the visualization type (points)
p2 <- p1 + geom_point()

# add a regression line
p3 <- p2 + geom_smooth(method = "lm")

# add a main title and draw the plot
p4 <- p3 + ggtitle("Student's attitude versus exam points")
p4
ggsave("plot.png", width = 5, height = 5) # saved the plot as a png image

#Now I'm attempting to make a simila scatter plot out of two other variables in the learning2014 
# data, for learning's sake. I decided to choose variables "deep" and "points", to see if the student's
# deep leaning skills are in some kind of connection or loosely said, correlation, with each other.

p11 <- ggplot(learning2014, aes(x = deep, y = points, col =gender))

# define the visualization type (points)
p22 <- p1 + geom_point()

# add a regression line
p33 <- p2 + geom_smooth(method = "lm")

# add a main title and draw the plot
p44 <- p3 + ggtitle("Student's deep learning skills versus exam points")
p44
ggsave("plot1.png", width = 5, height = 5)
# As can be seen from the scatter plot and the linear regression curve fitted into it,
# there seems to be less connection between a student's deep learning skills and 
# their points earned in an exam, as the regression line is practically vertical.
# From this I got the idea to also illustrate the connection between a student's 
# stategic leaning skills with thei exam points, as I thought their strategic learning
# skills would have more to do with their points in an exam. Though the following
# code I got the resulting picture:

p111 <- ggplot(learning2014, aes(x = stra, y = points, col =gender))

# define the visualization type (points)
p222 <- p1 + geom_point()

# add a regression line
p333 <- p2 + geom_smooth(method = "lm")

# add a main title and draw the plot
p444 <- p3 + ggtitle("Student's strategic learning skills versus exam points")
p444
ggsave("plot2.png", width = 5, height = 5)
# From this I concluded, that there seems to be more connection with a students 
# strategic learning skills and their exam points, at least more so than with their
# deep leaning skills. The regression line in this case, is an ascending line
# i. e. the slope of the line is positive. This tends to say that the more
# the student is inclined towads strategic learning, the bigger number of points
# they seem to score from an exam. However, these are just initial observations,
# and have little if nothing to do with actual statistical analysis - but based
# on these ponderings and inclinations I would, as a statistician, try to establish my
# further work on this notion.


# After the initial exercises, I proceeded to create a scatter plort matrix of all the variables 
# in the learning2014 data. I use GGally and ggplot -packages to do this by first accessing the
# aforementioned libraries and then using the function ggpairs() on learning2014.

# Accessing the GGally and ggplot2 libraries
library(GGally)
library(ggplot2)

# Using ggpairs() to create a scatter plot with more advanced features than the one Base R has to offer (pairs()-function).
p <- ggpairs(learning2014, mapping = aes(col=gender, alpha=0.3), lower = list(combo = wrap("facethist", bins = 20)))
# The mapping argument "aes" defines the 'aesthetics' of the plot, i. e. as in this
# scatter plot, the colour of the spots is defined by the variable 'gender' similarly as in the previous plots and the alpha-argument decreases the opacity of the
# colours in the scatter plot to make the picture more comprehensible.

#Drawing the plot.
p

library(ggplot2)
library(GGally)
# create an plot matrix with ggpairs()
ggpairs(learning2014, lower = list(combo = wrap("facethist", bins = 20)))

# create a regression model with multiple explanatory variables
my_model4 <- lm(points ~ attitude + stra, data = learning2014)

# print out a summary of the model
summary(my_model4)
