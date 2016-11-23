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
t$time <- strptime(t$time, "%H:%M:%S")

## Subset data to include February 1, 2007 and February 2, 2007 only
data_feb <- subset(t, date >= "2007-02-01" & date <= "2007-02-02")

## Generates desired graph
with(data_feb, hist(global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

## Creates PNG file
dev.copy(png, file = "plot1.png")
