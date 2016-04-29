#!/usr/bin/Rscript

library("ggplot2")
require(mgcv)

golden_ratio <- 1.0 / 1.6180339887

url <- "http://www.metoffice.gov.uk/hadobs/hadcet/cetml1659on.dat"
cet <- read.table(url, sep = "", skip=6, header=TRUE, fill=TRUE,
                  na.string = c(-99.99, -99.9))

# Drop 2016 as it isn't finished
cet <- cet[-nrow(cet),]

# Last column is the annual value
years <- as.numeric(rownames(cet))
df_ann <- data.frame(temp=cet[,ncol(cet)], year=years)

ggplot(df_ann, aes(years, temp)) +
       geom_point(size=0.8) +
       xlab("Year") +
       ylab("Mean annual temperature (deg C)") +
       theme(aspect.ratio=golden_ratio)
       
# Drop year from monthly data
cet <- cet[,-ncol(cet)]
