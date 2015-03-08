# Set locale
Sys.setlocale("LC_TIME", "C")

# Read the full set of data
data <- read.csv("./csv/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

# transform date string in date to easy subsetting
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# subsetting data for the interval 2007-02-01 and 2007-02-02
subset <- subset(data,data$Date>="2007-02-01" & data$Date<="2007-02-02")

# creating new column Date_time 
date_time <- paste(as.Date(subset$Date), subset$Time)
subset$Date_time <- as.POSIXct(date_time)

# plot the histogram for Global_active_power column
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))
hist(subset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
