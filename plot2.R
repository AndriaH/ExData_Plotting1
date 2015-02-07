###
# Exploratory Data Analysis: Project 1
# Requirments: Examine how household energy usage varies
# over a 2-day period, that is, from the period "
###
# Check required R libraries

if (!require("data.table")) {
        install.packages("data.table")
}


# Load required R libraries in Workspace
require("data.table")

# get full dataset of 2075259 rows and 9 columns
dataSet <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", 
                        colClasses = c("character","character", "numeric", "numeric", "numeric", 
                                       "numeric","numeric","numeric","numeric"), nrows= -1, check.names=F, stringsAsFactors=F, quote="\"'")

# convert the Date variables to Date classes
dataSet$Date <- as.Date(dataSet$Date, "%d/%m/%Y")

# subset the dataSet for data between '2007-02-01' and '2007-02-02'
dateSet <- subset(dataSet, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# remove object dataSet from active environment
remove(dataSet)

## converting Date and Time variables into "POSIXct", "POSIXt" classes
datetime <- paste(dateSet$Date, dateSet$Time)
dateSet$DateTime <- as.POSIXct(datetime)


# set margins for Plot 1
par(mar = c(5, 5, 2, 2))

# Plot 2
plot(dateSet$Global_active_power ~ dateSet$DateTime, type="l", xlab="",
     ylab= "Global Active Power (kilowatts)")
     

# copy plot to a PNG file
dev.copy(png, file="plot2.png", height=480, width=480)

# close the PNG file
dev.off()

####################### end of code #######################

