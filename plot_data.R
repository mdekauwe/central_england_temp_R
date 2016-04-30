#!/usr/bin/Rscript

library("ggplot2")
library(grid)
require(mgcv)
require(gridExtra)

fn <- "CET_data.txt"
cet <- read.table(fn, sep = "", skip=6, header=TRUE, fill=TRUE,
                  na.string = c(-99.99, -99.9))
names(cet) <- c(month.abb, "Annual")

#
# Clean up the dataset....
#

# Drop 2016 as it isn't finished
cet <- cet[-nrow(cet),]

# Last column is the annual value
year <- as.numeric(rownames(cet))
nvals = length(cet_annual$year)
year <- seq(min(cet_annual$year), max(cet_annual$year), length=nvals)
cet_year <- data.frame(temp=cet[,ncol(cet)], year=year)

# Drop year from monthly data
cet_month <- cet[,-ncol(cet)]

# Reorder the monthly data
cet_month <- stack(cet_month)[,2:1]
names(cet_month) <- c("month","temp")
years <- rep(year, times=12)
cet_month["year"] <- years

golden_ratio <- 1.0 / 1.6180339887
ax1 <- ggplot(cet_year, aes(year, temp)) +
         geom_point(size=0.8) +
         ylab("") +
         theme_bw() +
         theme(aspect.ratio=golden_ratio,
               panel.grid.major=element_blank(),
               panel.grid.minor=element_blank(),
               plot.margin=unit(c(1,1,-0.5,1), "cm"))

ax2 <- ggplot(cet_month, aes(year, temp)) +
         geom_point(size=0.8) +
         xlab("Year") +
         ylab("") +
         theme_bw() +
         theme(aspect.ratio=golden_ratio,
               panel.grid.major=element_blank(),
               panel.grid.minor=element_blank(),
               plot.margin=unit(c(-0.5,1,1,1), "cm"))

label <- textGrob(expression(Mean~annual~temperature~(~degree~C)), rot=90, vjust=4.5)
g <- grid.arrange(ax1, ax2, ncol=1, left=label)
