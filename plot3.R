# plot3.R - Creates a PNG in the working directory called plot3.png
# containing one line graph: DateTime vs Sub_metering_1, Sub_metering_2 and Sub_metering_3

# data.table package is necessary for this script to run
# load data.table library
library(data.table)

# Assuming that the text file household_power_consumption.txt is located in the working directory
# Use fread to read in the data for only 1/2/2007 and 2/2/2007. 
data <- fread("household_power_consumption.txt", sep=";", skip=66637, nrows=2880, na.strings="?")

# By skipping rows to read the data above, the first line (header) is also skipped which 
# contained the column names
# Read in one line of data and the header to retrieve the column names
columnNames <- fread("household_power_consumption.txt", sep=";", nrows=1, header=TRUE)

# Set the column names of the data data.table 
# using the column names from the columnNames data.table
setnames(data, names(data), names(columnNames))

# Transform the data table so that there is a DateTime field as POSIXct
data <- transform(data, Date = as.Date(Date, "%d/%m/%Y"))
data <- transform(data, DateTime = as.POSIXct(strftime(paste(Date, Time), "%Y-%m-%d %H:%M:%S")))

# Write the plot to PNG file
png(filename="plot3.png", width=450, height=450, bg="white", units = "px")

# Create plot3 - a line graph with three data sets (submetering)
with(data, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))

with(data, lines(DateTime, Sub_metering_1, col="Black"))
with(data, lines(DateTime, Sub_metering_2, col="Red"))
with(data, lines(DateTime, Sub_metering_3, col="Blue"))

# Add the legend in the top right
legend("topright", lty=c(1,1,1), col=c("Black", "Red", "Blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()