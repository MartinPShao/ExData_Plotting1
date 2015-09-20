setwd("~/Documents/git/ExData_Plotting1")
#Getting and cleaning the data
if (!file.exists("./household_power_consumption.txt")) {
    download.file("http://j.mp/TbC79E", "./power_data.zip")
    unzip("./power_data.zip", overwrite = T, exdir = ".")
}
system("head -n 1 ./household_power_consumption.txt > ./feb2007data.txt")
system("cat ./household_power_consumption.txt  | grep '^0\{0,1\}[12]/0\{0,1\}2/2007' >> ./feb2007data.txt")
datafile <- "./feb2007data.txt"
data <- read.table(datafile, sep = ";", header = T, na.strings = "?")
data$Datetime <- strptime(paste(data$Date, data$Time), 
                          "%d/%m/%Y %H:%M:%S")
#open device
png(filename='plot3.png',
    width=480,
    height=480,
    units='px')
#plot data
plot(data$Datetime, 
     data$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering")
points(data$Datetime, 
       data$Sub_metering_2, 
       type = "l", 
       xlab = "", 
       ylab = "Energy sub metering", 
       col = "red")
points(data$Datetime, 
       data$Sub_metering_3, 
       type = "l", 
       xlab = "", 
       ylab = "Energy sub metering", 
       col = "blue")
legend("topright", 
       lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", "Sub_metering_3"))
#close device
x<-dev.off()
