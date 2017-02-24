library(gmodels)
library(gdata)
library(dplyr) #accessed the dplyr-library
library(ggplot2) #accessed the ggplot2-library
library(readr) #accessed the readr-library
library(tidyr) #accessed tidyr-library
library(tidyverse)
library(corrplot)
library(GGally)

human <- as.data.frame(read.table('human.csv'))

glimpse(human)
summary(human)

ggpairs(human)

corrplot(round(cor(human), digits = 2), method = "circle", type = "upper", tl.pos = "d", tl.cex = 0.8)

pca_human <- prcomp(human)
s_nonst <- summary(pca_human)
s_nonst

pr_snonst <- round(100*s_nonst$importance[2, ], digits = 1)
pc_snonst_lab <- paste0(names(pr_snonst), " (", pr_snonst, "%)")
biplot(pca_human, choices = 1:2, cex = c(0.6, 1), col = c("grey40", "deeppink2"), xlab = pc_snonst_lab[1], ylab = pc_snonst_lab[2])

human_st <- scale(human)
pca_st <- prcomp(human_st)
s_st <- summary(pca_st)
s_st

pr_sst <- round(100*s_st$importance[2, ], digits = 1)
pc_sst_lab <- paste0(names(pr_sst), " (", pr_sst, "%)")
biplot(pca_st, choices = 1:2, cex = c(0.6, 1), col = c("grey40", "deeppink2"), xlab = pc_sst_lab[1], ylab = pc_sst_lab[2])

