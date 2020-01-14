UCI_url = 
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("household_power_consumption.txt")){
  download.file(UCI_url, destfile = "exdata_data_household_power_consumption.zip")
  unzip("exdata_data_household_power_consumption.zip")
}

txtfile   = "./household_power_consumption.txt"
data_begin = grep("1/2/2007", readLines(txtfile))[1] - 1
data_end   = grep("3/2/2007", readLines(txtfile))[1] - 1

UCI_data = read.table(file  = txtfile,
                      sep   = ";",
                      skip  = data_begin,
                      nrows = data_end - data_begin,
                      na.strings = "?",
                      col.names  = strsplit(x = readLines(txtfile, n = 1),
                                            split = ";")[[1]])
UCI_data$Time <- as.POSIXct(paste(UCI_data$Date, UCI_data$Time),
                            format="%d/%m/%Y %H:%M:%S")
UCI_data$Date <- NULL

dir.create(file.path(getwd(), "figure"), showWarnings = FALSE)
cwd = getwd()
setwd(file.path(getwd(), "figure"))
png(file = "plot3.png", width = 480, height = 480)
Sys.setlocale("LC_TIME", "en_US")
plot(x = UCI_data$Time, type = "l",
     y = UCI_data$Sub_metering_1,
     ylab = "Energy sub metering",
     xlab = "")
lines(UCI_data$Time, UCI_data$Sub_metering_2, col = "red")
lines(UCI_data$Time, UCI_data$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
setwd(cwd)