##Read-in the full datafile. Datafile is in the working directory.
Pdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", as.is = TRUE, na.strings = "?")

##Subset the data for the two dates of interest 
Pdata <- subset(Pdata, Date %in% c("1/2/2007", "2/2/2007"))

##turn-on image writing device
png(width = 480, height = 480, file = "plot1.png")

##plot histogram for Global_active_power variable
      hist(Pdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
          main = "Global Active Power")

##turn-off image writing device
dev.off()