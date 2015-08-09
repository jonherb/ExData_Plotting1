##Loading the dplyr library specifically for the %>% function, to facilitate code readability
library(dplyr)

##Read-in and subset the data
Pdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", as.is = TRUE, na.strings = "?")
Pdata <- subset(Pdata, Date %in% c("1/2/2007", "2/2/2007"))

##add a new variable, Datetime, to the Pdata dataframe with cbind
Pdata <- cbind(Pdata, 
## First convert the Date strings to proper date format with as.Date. Pass the result to paste, to paste it with the
## Time string. Pass the resulting date-time string to strptime, to convert it to POSIXct class. 
          Datetime = as.Date(Pdata$Date, format = "%d/%m/%Y") %>% paste(Pdata$Time) %>% 
                      strptime(format = "%Y-%m-%d %H:%M:%S"))

png(width = 480, height = 480, file = "plot2.png")
##The newly added Datetime variable, in the POSIXct class, is x in the plot. Y is Global_active_power.
      with(Pdata, plot(Datetime, Global_active_power, xlab = NA, ylab = "Global Active Power (kilowatts)", type = "l"))
dev.off()