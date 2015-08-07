### Loading the Household Power Consumption data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./data/household_power_consumption.zip",method = "curl")
unzip(zipfile = "./data/household_power_consumption.zip",exdir = "./data")

### Read data from file
data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 2075259)

### Format date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

### Subset data for dates 2007-02-01 and 2007-02-02
dataExtract <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

### Convert date/time to POSIXct
dateTime <- paste(as.Date(dataExtract$Date), dataExtract$Time)
dataExtract$dateTime <- as.POSIXct(dateTime)

### Plot 3 - Create line graph with sub metering series
with (dataExtract, {
	plot(dataExtract$dateTime,
		dataExtract$Sub_metering_1, 
		type = "l", 
		xlab = "", 
		ylab = "Energy sub metering",
		col = "Black")
	lines(dataExtract$dateTime,
		dataExtract$Sub_metering_2, 
		col = "Red")
	lines(dataExtract$dateTime,
		dataExtract$Sub_metering_3,
		col = "Blue")
	legend("topright", 
		col = c("Black", "Red", "Blue"), 
		lwd = 2,
		legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
		cex = 0.75)
})

### Copy plot to png file (480x480 pixels) -- don't forget to close the PNG device!
dev.copy (png, file = "./data/plot3.png", height = 480, width = 480) 
dev.off() 
