
#load dependant packages
library(zip)

#download and unzip data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip", mode = "wb")
unzip("data.zip")

#read the data in
data <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

#change Date and Time columns to date/time class
data$Time <- strptime(data$Time, format = "%H:%M:%S")
data$Time <- sub(".*\\s+", "",  data$Time)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#subset data for the 2 day period we want
date1 <- as.Date("01/02/2007", format = "%d/%m/%Y")
date2 <- as.Date("02/02/2007", format = "%d/%m/%Y")
new <- subset(data, Date == date1 | Date == date2)

#plot histogram plot1 and save it as png file
png(filename = "plot1.png")
hist((as.numeric(as.character(new$Global_active_power))), col= "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()