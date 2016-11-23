## Script generates desired graph from Household Power Consumption data

## Downloads the data
theURL <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
z <- tempfile()
download.file(theURL, z)

## Unzips the file and extracts a few thousand rows that contains the desired dates
t <- read.table(unz(z,"household_power_consumption.txt"), header = TRUE, sep = ";", skip = 65000, nrows = 10000)

## Added column names back in
colnames(t) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

## Change class of date and time
t$date <- strptime(t$date, "%d/%m/%Y")


## Subset data to include February 1, 2007 and February 2, 2007 only
data_feb <- subset(t, date >= "2007-02-01" & date <= "2007-02-02")

## Generates 2X2 graphical layout
par(mfcol = c(2,2))

## generates graph at top left
with(data_feb, plot(global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xaxt = "n", xlab = " "))
axis(1, at = c(0,1250,2500), labels = c("Thu", "Fri", "Sat"))
with(data_feb, lines(global_active_power))

## generates graph at bottom left
with(data_feb, plot(sub_metering_1, type = "n", ylab = "Energy sub metering", xaxt = "n", xlab = " "))
axis(1, at = c(0,1250,2500), labels = c("Thu", "Fri", "Sat"))
with(data_feb, lines(sub_metering_1))
with(data_feb, lines(sub_metering_2, col = "red"))
with(data_feb, lines(sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), col = c("black", "red", "blue"), bty = "n")

## generates graph at top right
with(data_feb, plot(voltage, type = "n", ylab = "Voltage", xaxt = "n", xlab = "datetime"))
axis(1, at = c(0,1250,2500), labels = c("Thu", "Fri", "Sat"))
with(data_feb, lines(voltage))

## generates graph at bottom right
with(data_feb, plot(global_reactive_power, type = "n", ylab = "Global_reactive_power", xaxt = "n", xlab = "datetime"))
axis(1, at = c(0,1250,2500), labels = c("Thu", "Fri", "Sat"))
with(data_feb, lines(global_reactive_power))

## Creates PNG file
dev.copy(png, file = "plot4.png")