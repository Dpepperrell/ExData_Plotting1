library(tidyverse)
library(lubridate)

# Assuming data on local drive we import th data and subset to only include 01/02/07 and 02/02/07
hpc_data <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE, header = TRUE, sep =";")%>%
    subset(Date == "1/2/2007" | Date == "2/2/2007")


# Change formats

hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")
hpc_data$date_time <- strptime(paste(hpc_data$Date, hpc_data$Time), format = "%Y-%m-%d %H:%M:%S")
hpc_data$Global_active_power <- as.numeric(hpc_data$Global_active_power) 
hpc_data$Global_reactive_power <- as.numeric(hpc_data$Global_reactive_power) 
hpc_data$Voltage <- as.numeric(hpc_data$Voltage) 
hpc_data$Global_intensity <- as.numeric(hpc_data$Global_intensity) 
hpc_data$Sub_metering_1 <- as.numeric(hpc_data$Sub_metering_1) 
hpc_data$Sub_metering_2 <- as.numeric(hpc_data$Sub_metering_2) 
hpc_data$Sub_metering_3 <- as.numeric(hpc_data$Sub_metering_3) 


# Time series analysis, need to plot every minute of the two days so need to distinguish between the teo days buy combining


png("plot4.png", width=480, height=480) 
par(mfrow=c(2,2)) 
with(hpc_data, plot(date_time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")) 
with(hpc_data, plot(date_time, Voltage, type = "l", xlab="datetime", ylab = "Voltage")) 
with(hpc_data, plot(date_time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")) 
lines(hpc_data$date_time, hpc_data$Sub_metering_2,type ="l", col = "red") 
lines(hpc_data$date_time, hpc_data$Sub_metering_3,type = "l", col = "blue") 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col = c("black", "red", "blue")) 
with(hpc_data, plot(date_time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")) 
dev.off() 
