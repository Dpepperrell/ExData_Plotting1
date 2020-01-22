library(tidyverse)
library(lubridate)

# Assuming data on local drive we import th data and subset to only include 01/02/07 and 02/02/07
hpc_data <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE, header = TRUE, sep =";", na.strings = c("?",""))%>%
    subset(Date == "1/2/2007" | Date == "2/2/2007")


# Change formats
hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")
hpc_data$date_time <- strptime(paste(hpc_data$Date, hpc_data$Time), format = "%Y-%m-%d %H:%M:%S")
hpc_data$Global_active_power <- as.numeric(hpc_data$Global_active_power)


# Create plot2
png("plot2.png", width=480, height=480) 
with(hpc_data, plot(date_time, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)")) 
dev.off()
