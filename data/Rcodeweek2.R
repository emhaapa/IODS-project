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


