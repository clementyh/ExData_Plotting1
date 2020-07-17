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

#plot the final graphic plot4 and save it as png file
png(filename = "plot4.png")

  par(mfcol = c(2,2))

  #top left plot
  plot(seq(along.with = new$Time), as.numeric(as.character(new$Global_active_power)), type = "l", xaxt ="n", xlab = " ", ylab = "Global Active Power (kilowatts)")
  axis(1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

  #bottom left plot
  plot(seq(along.with = new$Time), as.numeric(as.character(new$Sub_metering_1)), xaxt ="n", type = "n", xlab = " ", ylab = "Energy sub metering")
  axis(1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
  points(seq(along.with = new$Time), as.numeric(as.character(new$Sub_metering_1)), type = "l")
  points(seq(along.with = new$Time), as.numeric(as.character(new$Sub_metering_2)), type = "l", col = "red")
  points(seq(along.with = new$Time), as.numeric(as.character(new$Sub_metering_3)), type = "l", col = "blue")
  legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

  #top right plot
  plot(seq(along.with = new$Time), as.numeric(as.character(new$Voltage)), type = "l", xaxt ="n", xlab = "datetime", ylab = "Voltage")
  axis(1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

  #bottom right plot
  plot(seq(along.with = new$Time), as.numeric(as.character(new$Global_reactive_power)), type = "l", xaxt ="n", xlab = "datetime", ylab = "Global_reactive_power")
  axis(1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
  dev.off()