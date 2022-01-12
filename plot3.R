data<-fread("household_power_consumption.txt")
FullTimeDate <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
data <- cbind(data, FullTimeDate)

## change class of all columns to correct class
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- format(data$Time, format="%H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## subset data from 2007-02-01 and 2007-02-02
subdata <- subset(data, Date == "2007-02-01" | Date =="2007-02-02")

## plot globalactivepower vs date&time
png("plot3.png", width=480, height=480)
with(subdata, plot(FullTimeDate, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
lines(subdata$FullTimeDate, subdata$Sub_metering_2,type="l", col= "red")
lines(subdata$FullTimeDate, subdata$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()
