#####################
### SET LIBRARY

library(sqldf)

## Set directory
setwd("C:/Users/bmolin/Documents/Coursera/Exploratory Analysis/Week 1/ExData_Plotting1-master/")

#####################
### Importing Data  ---------------------------------------------

# Download Data
file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Import
temp <- tempfile()
download.file(file,temp)

fns <- unzip(temp, junkpaths = TRUE, exdir = tempdir())

hhpowerconsumption_raw <- read.csv.sql(fns 
                                       ,sql = "select Date,
                                                      Time,
                                                      Global_active_power,
                                                      Global_reactive_power,
                                                      Voltage,
                                                      Sub_metering_1,
                                                      Sub_metering_2,
                                                      Sub_metering_3
                                       from file
                                       where Date IN ('1/2/2007', '2/2/2007')"
                                       ,eol = "\n"
                                       ,header = TRUE
                                       ,sep = ";")

hhpowerconsumption_raw$DateTime <-  dmy_hms(paste(hhpowerconsumption_raw$Date, hhpowerconsumption_raw$Time))


#####################
### CHART PIECES ---------------------------------------------

# CHART 1
topleft <- function() {
  plot(hhpowerconsumption_raw$DateTime,
       hhpowerconsumption_raw$Global_active_power,
       type="n",
       xlab = "",
       ylab = "Global Active Power (kilowatts)",
       main="",
       cex = .75) 
  lines(hhpowerconsumption_raw$DateTime,
        hhpowerconsumption_raw$Global_active_power)
}

# CHART 2
bottomleft <- function() {
  # Create Line Chart
  
  # get the range for the x and y axis 
  xrange <- range(hhpowerconsumption_raw[,9]) 
  yrange <- range(sapply(hhpowerconsumption_raw[,6:8], list)) 
  
  # set color range
  colors <- c("black", "red","blue")
  
  plot(xrange,
       yrange,
       type="n",
       xlab = "",
       ylab = "Energy sub metering",
       main="") 
  
  # add lines 
  for (i in 6:8) { 
    measurename <- colnames(hhpowerconsumption_raw)[[i]]
    measure <- hhpowerconsumption_raw[,c("DateTime",measurename)] 
    lines(measure[,1], measure[,2], type="l", lwd=1.5, col=colors[i-5]) 
  } 
  
  # add a legend 
  legend("topright",
         legend = colnames(hhpowerconsumption_raw[,6:8]),
         cex=0.8,
         lty=1,
         col=colors)
}

# CHART 3
topright <- function() {
    plot(hhpowerconsumption_raw$DateTime,
         hhpowerconsumption_raw$Voltage,
         type="n",
         xlab = "datetime",
         ylab = "Voltage",
         main="") 
    lines(hhpowerconsumption_raw$DateTime,
          hhpowerconsumption_raw$Voltage)
}

# CHART 4
bottomright <- function() {
  
  plot(hhpowerconsumption_raw$DateTime,
       hhpowerconsumption_raw$Global_reactive_power,
       type="n",
       xlab = "datetime",
       ylab = "Global_reactive_power",
       main="") 
  lines(hhpowerconsumption_raw$DateTime,
        hhpowerconsumption_raw$Global_reactive_power)
}

#####################
### CHART ---------------------------------------------

png("plot4.png", height=480, width=480)
par(mfrow=c(2,2), cex = .5)
topleft()
topright()
bottomleft()
bottomright()
dev.off()
par(mfrow=c(1,1), cex = 1)
