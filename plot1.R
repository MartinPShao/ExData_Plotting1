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
png(filename='plot1.png',
    width=480,
    height=480,
    units='px')
#plot data
hist(data$Global_active_power, 
     main = "Global Active Power", 
     ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red", 
     breaks = 13, 
     ylim = c(0, 1200), 
     xlim = c(0, 6), 
     xaxp = c(0, 6, 3))
#close device
x<-dev.off()
