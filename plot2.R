#####################
### SET LIBRARY

library(sqldf)
library(lubridate)

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
                                       ,sql = "select Global_active_power, Date, Time
                                       from file
                                       where Date IN ('1/2/2007', '2/2/2007')"
                                       ,eol = "\n"
                                       ,header = TRUE
                                       ,sep = ";")

hhpowerconsumption_raw$DateTime <-  dmy_hms(paste(hhpowerconsumption_raw$Date, hhpowerconsumption_raw$Time))

#####################
### CHART  ---------------------------------------------

png("plot2.png", height=480, width=480)
par(cex = .75)
plot(hhpowerconsumption_raw$DateTime,
     hhpowerconsumption_raw$Global_active_power,
     type="n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     main="",
     cex = .25) 
lines(hhpowerconsumption_raw$DateTime,
      hhpowerconsumption_raw$Global_active_power)
dev.off()
par(cex = 1)