#####################
### SET LIBRARY

library(sqldf)

## Set directory
setwd("C:/Users/bmolin/Documents/Coursera/Exploratory Analysis/Week 1/ExData_Plotting1-master")

#####################
### Importing Data  ---------------------------------------------

# Download Data
file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Import
temp <- tempfile()
download.file(file,temp)

fns <- unzip(temp, junkpaths = TRUE, exdir = tempdir())

hhpowerconsumption_raw <- read.csv.sql(fns 
                      ,sql = "select Global_active_power
                               from file
                               where Date IN ('1/2/2007', '2/2/2007')"
                      ,eol = "\n"
                      ,header = TRUE
                      ,sep = ";")

#####################
### CHART  ---------------------------------------------

png("plot1.png", height=480, width=480)
par(cex = .75)
hist(x = hhpowerconsumption_raw$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     cex = .75)
dev.off()