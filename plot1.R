
##
##  Exploratory Data Analysis - Project 1
##  Chuck Demers
##  Aug 6, 2015
##
##  plot1.R
##

################################################################################
##  Step 1: Define the input and output data
################################################################################

dataset_url  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile      <- "dataset.zip"
datafile     <- "household_power_consumption.txt"
imagefile    <- "plot1.png"

################################################################################
##  Step 2: Download the data
################################################################################

datadir      <- "data"
zipfilepath  <- file.path(datadir, zipfile)
datafilepath <- file.path(datadir, datafile)

if (! file.exists(datadir)){
    dir.create(file.path(".",datadir))
}

if (! file.exists(zipfilepath)) {
    download.file( dataset_url, destfile=zipfilepath, method="curl")
}

if(! file.exists(datafilepath)){
    unzip(zipfilepath, exdir=datadir)
}

################################################################################
##  Step 3: Import the data
################################################################################

power <- read.csv( datafilepath, 
                   header=TRUE, 
                   na.strings="?", 
                   sep=";", 
                   stringsAsFactors=FALSE)

################################################################################
##  Step 4: Clean the data so it can be used
################################################################################

##    a) Get the date-time column

power$datetime <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")

##    b) select only the dates 2007-02-01 and 2007-02-02

power <- subset(power, datetime >= strptime("2007-02-01","%Y-%m-%d") 
                     & datetime < strptime("2007-02-03","%Y-%m-%d"))

################################################################################
##  Step 5: Generate the plot
################################################################################

##    a) Set the device to be used along with its parameters

png(filename=imagefile, width=480, height=480, units="px" )

##    b) Generate the plot

hist(power$Global_active_power, 
     col="Red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

##    c) Turn off the new device giving control back to monitor

dev.off()
