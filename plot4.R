##  ---
##  title: "Exploratory Data Analysis: peer assignment 1: plot 4"
##  author: "DianeCS"
##  date: "Sunday, August 9, 2015"
##  output: "graphs and plots"
##  ---


## obtain and read data
if(!file.exists("./household_power_consumption.txt")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, "./household_power_consumption.zip")
  unzip("./exdata-data-household_power_consumption.zip",exdir = ".")
}
HouseholdPowerConsumption <- read.table("household_power_consumption.txt"
                                        , header = TRUE
                                        , sep = ";"
                                        , stringsAsFactors = FALSE
                                        , na.strings = "?")
HouseholdPowerConsumption$DateTime <- paste(HouseholdPowerConsumption$Date
                                            , HouseholdPowerConsumption$Time)

## format dates
HouseholdPowerConsumption$DateTime <- as.Date(HouseholdPowerConsumption$DateTime
                                              , format = "%d/%m/%Y %H:%M:%S")
HouseholdPowerConsumption$Date2 <- as.Date(HouseholdPowerConsumption$Date
                                           , format="%d/%m/%Y")
HouseholdPowerConsumption$DateTimeConcat <- paste(HouseholdPowerConsumption$Date
                                                  , HouseholdPowerConsumption$Time)
HouseholdPowerConsumption$DateTime2 <- strptime(HouseholdPowerConsumption$DateTimeConcat
                                                , "%d/%m/%Y %H:%M:%S")

## identify subset with selected dates
beginDate <- as.Date("2007-02-01 00:00:00")
endDate <- as.Date("2007-02-02 23:59:59")
beyondDate <- as.Date("2007-02-03")
HPCselectedDates <- subset(HouseholdPowerConsumption
                           , DateTime >= beginDate & DateTime < beyondDate)

## make and store plot 4
png(filename="plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
### plot 4.1
plot(HPCselectedDates$DateTime2, HPCselectedDates$Global_active_power
     , type="l"
     , ylab = "Global Active Power (kilowatts)"
     , xlab = "")
### plot 4.2
plot(HPCselectedDates$DateTime2, HPCselectedDates$Voltage
     , type="l"
     , ylab = "Voltage"
     , xlab = "datetime")
### plot 4.3
plot(HPCselectedDates$DateTime2, HPCselectedDates$Sub_metering_1
     , type="l"
     , ylab = "Energy sub metering"
     , xlab = "")
lines(HPCselectedDates$DateTime2, HPCselectedDates$Sub_metering_2, col = "red")
lines(HPCselectedDates$DateTime2, HPCselectedDates$Sub_metering_3, col = "blue")
legend("topright", lty = 1
       , col = c("black", "red", "blue")
       , legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))
### plot 4.4
plot(HPCselectedDates$DateTime2, HPCselectedDates$Global_reactive_power
     , type="l"
     , ylab = "Global_reactive_power"
     , xlab = "datetime")
dev.off()
