##  ---
##  title: "Exploratory Data Analysis: peer assignment 1: plot 1"
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

## make and store plot 1 
png(filename="plot1.png", width = 480, height = 480)
options(scipen=1200)
hist(HPCselectedDates$Global_active_power
     , col="red"
     , main = "Global Active Power"
     , xlab = "Global Active Power (kilowatts)")  
##  dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()