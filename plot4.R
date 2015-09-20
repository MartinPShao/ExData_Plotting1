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
png(filename='plot4.png',
    width=480,
    height=480,
    units='px')
#plot data
par(mfrow = c(2, 2))
# plot 1 (NW)
plot(data$Datetime, 
     data$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power", 
     xlab = "")

# plot 2 (NE)
plot(data$Datetime, 
     data$Voltage, 
     type = "l", 
     ylab = "Voltage", 
     xlab = "datetime")

# plot 3 (SW)
plot(data$Datetime, 
     data$Sub_metering_1, 
     type = "l", 
     ylab = "Energy sub metering", 
     xlab = "", 
     col = "black")
points(data$Datetime, 
       data$Sub_metering_2, 
       type = "l", 
       xlab = "", 
       ylab = "Sub_metering_2", 
       col = "red")
points(data$Datetime, 
       data$Sub_metering_3, 
       type = "l", 
       xlab = "", 
       ylab = "Sub_metering_3", 
       col = "blue")
legend("topright", 
       lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", "Sub_metering_3"), 
       bty = "n")

# plot 4 (SE)
plot(data$Datetime, 
     data$Global_reactive_power, 
     type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power", ylim = c(0, 0.5))
#close device
x<-dev.off()
