# 04. Exploritory Data Analysis
## Week 1 Assignment
### Plot 3 - Line Graph of Sub-Metering 1, 2 and 3 per Time in Overlay


# Set the working directory
setwd("~/Career Development/Skill Up/Coursera/DataScience/RworkingDir")

# Set object for file location for ease of use later
fileLoc <- "./data/household_power_consumption.txt"

# Read text file into a table data frame, but only the rows for dates February 1
# and 2, 2007, i.e. 01/02/2007 and 02/02/2007 as the Date is originally in
# dd/mm/yyyy

# A quick table prep step to set column classes
quickTable <- read.table(fileLoc, sep = ";", nrows = 10, header = TRUE)
classes <- sapply(quickTable, class)
classes[1:2] <- "character"

# Use the classes object in the colClasses argument to speed loading; header is
# set to false as I want to skip to the start of February 1, 2007 (skip 66637
# rows by inspection), and take the next 2880 rows (or 60 minutes * 24 hrs * 2
# days); col.names argument is passed the names from quicktable to
# replace the header
electric <- read.table(fileLoc, header = FALSE, sep = ";", colClasses = classes, col.names = names(quickTable), skip = 66637, nrows = 2880)

# Convert the Date and Time variables to Date/Time classes in R using
# the strptime() and as.Date() functions.
electric$Date <- as.Date(electric$Date, "%d/%m/%Y")
dateTime <- paste(electric$Date, electric$Time)
electric$dateTime <- strptime(dateTime, "%Y-%m-%d %H:%M:%S")


# Construct a x y plot, using line type, no main title across the top, label the
# x and y axis, overlay the three sub-metering variables in different colors
# (note:  I used "orange" as my 'colorblindness' makes red hard to differenciate
# from black in thin lines), add a legend in the topright corner
plot(electric$dateTime, electric$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(electric$dateTime, electric$Sub_metering_1, col = "black")
lines(electric$dateTime, electric$Sub_metering_2, col = "blue")
lines(electric$dateTime, electric$Sub_metering_3, col = "orange")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 2, col = c("black", "blue", "orange"))


# Copy plot to PNG (bitmap format) file device
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off (which = 4)