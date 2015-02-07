##################################################################
##  Exploratory Data Analysis: Project 1                        ##
##                                                              ##
##  Description: Measursements of electric power consumption in ##
##  1 household with a one-minute sampling rate over a period   ##
##  of almost 4 years.  Different electrical quantities and     ##
##  some sub_metering values are available. The dataset has     ##
##  2075259 rows, 9 columns.                                    ##        
##  Requirments: Examine how household energy usage varies      ##
##  over a 2-day period, that is, from the period " 2007-02-01  ## 
##  and 2007-02-02".                                            ##
##################################################################

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

# remove the large object dataSet from active environment
remove(dataSet)

## converting Date and Time variables into "POSIXct", "POSIXt" classes
datetime <- paste(dateSet$Date, dateSet$Time)
dateSet$DateTime <- as.POSIXct(datetime)


# set margins for Plot 4
par(mfrow= c(2, 2), mar=c(4,4,2,2))

# Plot 4
with(dateSet, {
     plot(Global_active_power ~ DateTime, type="l", 
          ylab= "Global Active Power", xlab="")
     plot(Voltage ~ DateTime, type = "l",
          ylab="Voltage", xlab="datetime")
     plot(Sub_metering_1 ~ DateTime, type="l",
          ylab="Energy sub metering", xlab="")
     lines(Sub_metering_2 ~ DateTime,col='Red')
     lines(Sub_metering_3 ~ DateTime,col='Blue')
     legend("topright", cex=0.5, adj = c(0, -.3),legend=c("Sub_metering_1", "Sub_metering_2", 
        "Sub_metering_3"), col=c("black","red","blue"), lty=1,lwd=2, x.intersp=1, bty="n")
     plot(Global_reactive_power ~ DateTime, type="l",
          ylab="Global_reative_power", xlab="datetime")
})


# copy plot 4 to a PNG file
dev.copy(png, file="plot4.png", height=480, width=480)

# close the PNG file
dev.off()

####################### end of code #######################
