fileurl = "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists('./Electric power consumption.zip')){
  download.file(fileurl,"./Electric power consumption.zip")
  unzip("Electric power consumption.zip", exdir = getwd())
}

data <- read.table("./household_power_consumption.txt", header=T, sep=";", na.strings = "?")

data[,"Date"] <- as.Date(data[,"Date"],format = "%d/%m/%Y")
edited_data<-subset(data,Date == "2007-02-01" | Date == "2007-02-02")
edited_time <-strptime(paste(edited_data$Date,edited_data$Time,sep = " "), "%Y-%m-%d %H:%M:%S")

#PLOT4

par(mfrow = c(2, 2))

plot(edited_time, edited_data$Global_active_power, type="l", ylab="Global Active Power", xlab="")

plot(edited_time, edited_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(edited_time, edited_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(edited_time, edited_data$Sub_metering_2, type="l", col = "red")
lines(edited_time, edited_data$Sub_metering_3, type="l", col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1,1), lwd = c(1, 1,1), bty="n")

plot(edited_time, edited_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file = "plot4.png", height=480, width=650)
dev.off()
