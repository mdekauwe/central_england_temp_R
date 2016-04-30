#!/usr/bin/Rscript

library("ggplot2")
require(mgcv)

fn <- "CET_data.txt"
cet <- read.table(fn, sep = "", skip=6, header=TRUE, fill=TRUE,
                  na.string = c(-99.99, -99.9))

# Drop 2016 as it isn't finished
cet <- cet[-nrow(cet),]

# Last column is the annual value
year <- as.numeric(rownames(cet))
cet_annual <- data.frame(temp=cet[,ncol(cet)], year=year)

golden_ratio <- 1.0 / 1.6180339887
ggplot(cet_annual, aes(year, temp)) +
  geom_point(size=0.8) +
  xlab("Year") +
  ylab(expression(MAT~(~degree~C))) +
  #geom_hline(yintercept=0.0, linetype="dashed", colour="lightgrey") +
  theme_bw() +
  theme(aspect.ratio=golden_ratio,
       panel.grid.major=element_blank(),
       panel.grid.minor=element_blank())

# Drop year from monthly data
cet_monthly <- cet[,-ncol(cet)]
