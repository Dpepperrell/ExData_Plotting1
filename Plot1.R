library(tidyverse)
library(lubridate)

# Assuming data on local drive we import th data and subset to only include 01/02/07 and 02/02/07
hpc_data <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE, header = TRUE, sep =";")%>%
   subset(Date == "1/2/2007" | Date == "2/2/2007")


# Class of columns need to be checked and changed as neccessary
lapply(hpc_data, class)

# Change class

hpc_data$Date <- as.Date(hpc_data$Date, format="%d/%m/%Y") 
hpc_data$Time <- format(hpc_data$Time, format="%H:%M:%S") 
hpc_data$Global_active_power <- as.numeric(hpc_data$Global_active_power) 


png("plot1.png", width = 480, height = 480)
hist(hpc_data$Global_active_power, col="red", border="black", main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency") 
dev.off() 



