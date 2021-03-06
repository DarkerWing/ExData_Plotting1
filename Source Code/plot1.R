## Script to reconstrunct plot1.png for the Coursera "Exploratory Data Analysis" 
## course project 1
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
png(filename = "plot1.png", bg = "transparent")
with(data, hist(Global_active_power, xlab = "Global Active Power (kilowatts)",
                main = "Global Active Power", col = "red"))
dev.off()