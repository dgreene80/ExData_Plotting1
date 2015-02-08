# 02/06/15 David Greene
# Exploratory Data Analysis, Course Project 1, Plot 3
# This script performs these actions on the provided data:
#   - Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#   - Name each of the plot files as plot1.png.
#   - include code for reading the data so that the plot can be fully reproduced.
#   - include the code that creates the PNG file.
#   - We will only be using data from the dates 2007-02-01 and 2007-02-02.

# To start, download the data provided for this project:
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Unzip the file to the current working directory

library(datasets)

# Read the data file into a data frame
# Read only the rows of interest
vars <- c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric")
cols <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data <- read.table("household_power_consumption.txt", sep=";", colClasses=vars, col.names=cols, na.strings="?", skip=66637, nrows=2880)

# Generate helpful intermediate values
char_datetime <- paste(as.Date(data$Date,format="%d/%m/%Y"), data$Time, sep=" ")
posix_datetime <- as.POSIXlt(char_datetime)
ylimit <- c(0,max(data$Sub_metering_1))

# Generate graph and save it to a png file
# Use cairo on Windows to more closely match the examples, which were produced on a Mac.
png(file="plot3.png", height=480, width=480, bg="transparent", type="cairo")
  plot(posix_datetime, data$Sub_metering_1, ylim=ylimit, col="black", type="l", xlab="", ylab="Energy sub metering")
    lines(posix_datetime, data$Sub_metering_2, ylim=ylimit, col="red")
    lines(posix_datetime, data$Sub_metering_3, ylim=ylimit, col="blue")
    legend("topright", lty=1, col=c("black","red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

