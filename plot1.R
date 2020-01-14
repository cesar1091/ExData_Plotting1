fileurl = "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists('./Electric power consumption.zip')){
  download.file(fileurl,"./Electric power consumption.zip")
  unzip("Electric power consumption.zip", exdir = getwd())
}

data <- read.table("./household_power_consumption.txt", header=T, sep=";", na.strings = "?")

data[,"Date"] <- as.Date(data[,"Date"],format = "%d/%m/%Y")
edited_data<-subset(data,Date == "2007-02-01" | Date == "2007-02-02")
edited_time <-strptime(paste(edited_data$Date,edited_data$Time,sep = " "), "%Y-%m-%d %H:%M:%S" )

#PLOT1

hist(edited_data$Global_active_power, main = "Global Active Power",  xlab= "Global Active Power (kilowatts)", ylab = "Frequency", col= "Red")

dev.copy(png, file = "plot1.png", height=480, width=480)
dev.off()
