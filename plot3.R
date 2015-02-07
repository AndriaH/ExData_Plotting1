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


# set margins for Plot 3
par(mar = c(5, 5, 2, 2))

# Plot 3
with(dateSet,{
     plot(Sub_metering_1 ~ DateTime, type="l", 
          ylab= "Energy sub metering", xlab="")
     lines(Sub_metering_2 ~ DateTime, col='Red')
     lines(Sub_metering_3 ~ DateTime, col='Blue')
})

# the legend() is used to add the base graphic parameters:'col','lty','lwd'
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, cex=0.7, yjust=1, xjust=1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# copy plot 3 to a PNG file
dev.copy(png, file="plot3.png", height=480, width=480)

# close the PNG file
dev.off()

####################### end of code #######################

