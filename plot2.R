# plot2.R - Creates a PNG in the working directory called plot2.png
# containing one line graph: DateTime vs Global_active_power

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
png(filename="plot2.png", width=450, height=450, bg="white", units = "px")

# Create plot2 - a line graph 
with(data, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (killowatts)"))

dev.off()