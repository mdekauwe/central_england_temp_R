#!/usr/bin/Rscript

url <- "http://www.metoffice.gov.uk/hadobs/hadcet/cetml1659on.dat"
download.file(url, destfile="CET_data.txt", method="curl")
