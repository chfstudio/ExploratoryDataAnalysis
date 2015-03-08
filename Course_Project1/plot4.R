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

# plot the 4 graphs
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# first graph: relationship beetween Global_active_power and Date_Time
plot(subset$Global_active_power~subset$Date_time, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
# second graph: relationship beetween Voltage and Date_Time
plot(subset$Voltage~subset$Date_time, type="l", 
     ylab="Voltage (volt)", xlab="datetime")
# third graph: relationship beetween Sub_metering_X and Date_Time
plot(subset$Sub_metering_1~subset$Date_time, type="l", 
     ylab="Energy sub metering", xlab="")
lines(subset$Sub_metering_1~subset$Date_time,col='black')
lines(subset$Sub_metering_2~subset$Date_time,col='red')
lines(subset$Sub_metering_3~subset$Date_time,col='blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# fourth graph: relationship between Global_reactive_power and Date_time
plot(subset$Global_reactive_power~subset$Date_time, type="l", 
     ylab="Global_reactive_power", xlab="datetime")
dev.off()
