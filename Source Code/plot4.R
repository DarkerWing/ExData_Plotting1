## Script to reconstrunct plot4.png for the Coursera "Exploratory Data Analysis" 
## course project 1
##
##
## Data will be directly read and extracted from the web


# read data
temp <- tempfile()
download.file(
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
  temp, method = "curl")
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";",
                   header = TRUE, colClasses = "character")
unlink(temp)

# extract data for first and second of February 2007
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# convert Date and Time variables to one POSIX variable in first row
data$Date <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# get rid of now useless second row
data <- subset(data, select = c(1, 3:9))

# convert rows 2 - 8 to numeric.
data[,2:8] <- sapply(data[,2:8], as.numeric)

# make plot and print it to file
png(filename = "plot4.png", bg = "transparent")
# plot 1
par(mfrow = c(2, 2))
with(data, plot(Date,Global_active_power, type = "n", xlab = "", 
                ylab = "Global Active Power"))
lines(data$Date,data$Global_active_power)
# plot 2
with(data, plot(Date,Voltage, type = "n"))
lines(data$Date,data$Voltage)
# plot 3
with(data, plot(Date,Sub_metering_1, type = "n", xlab = "",
                ylab = "Energy sub metering"))
lines(data$Date,data$Sub_metering_1)
lines(data$Date,data$Sub_metering_2, col = "red")
lines(data$Date,data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = "solid", bty = "n",
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
# plot 4
with(data, plot(Date,Global_reactive_power, type = "n"))
lines(data$Date,data$Global_reactive_power)
dev.off()