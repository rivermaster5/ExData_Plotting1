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
                                       ,sql = "select Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3
                                       from file
                                       where Date IN ('1/2/2007', '2/2/2007')"
                                       ,eol = "\n"
                                       ,header = TRUE
                                       ,sep = ";")

hhpowerconsumption_raw$DateTime <-  dmy_hms(paste(hhpowerconsumption_raw$Date, hhpowerconsumption_raw$Time))

#####################
### CHART  ---------------------------------------------

# Create Line Chart

png("plot3.png", height=480, width=480)
par(cex = .75)
# get the range for the x and y axis 
xrange <- range(hhpowerconsumption_raw[,6]) 
yrange <- range(sapply(hhpowerconsumption_raw[,3:5], list)) 

# set color range
colors <- c("black", "red","blue")

plot(xrange,
     yrange,
     type="n",
     xlab = "",
     ylab = "Energy sub metering",
     main="") 

# add lines 
for (i in 3:5) { 
  measurename <- colnames(hhpowerconsumption_raw)[[i]]
  measure <- hhpowerconsumption_raw[,c("DateTime",measurename)] 
  lines(measure[,1], measure[,2], type="l", lwd=1.5, col=colors[i-2]) 
} 

# add a legend 
legend("topright",
       legend = colnames(hhpowerconsumption_raw[,3:5]),
       cex=0.8,
       lty=1,
       col=colors)
dev.off()
par(cex = 1)