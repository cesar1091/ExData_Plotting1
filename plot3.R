fileurl = "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists('./Electric power consumption.zip')){
  download.file(fileurl,"./Electric power consumption.zip")
  unzip("Electric power consumption.zip", exdir = getwd())
}

data <- read.table("./household_power_consumption.txt", header=T, sep=";", na.strings = "?")

data[,"Date"] <- as.Date(data[,"Date"],format = "%d/%m/%Y")
edited_data<-subset(data,Date == "2007-02-01" | Date == "2007-02-02")
edited_time <-strptime(paste(edited_data$Date,edited_data$Time,sep = " "), "%Y-%m-%d %H:%M:%S")

#PLOT3

plot(edited_time, edited_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(edited_time, edited_data$Sub_metering_2, type="l", col = "red")
lines(edited_time, edited_data$Sub_metering_3, type="l", col = "blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1)

dev.copy(png, file = "plot3.png", height=480, width=480)
dev.off()
