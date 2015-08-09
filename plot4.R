library(dplyr)

##Load and subset the data
Pdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", as.is = TRUE, na.strings = "?")
Pdata <- subset(Pdata, Date %in% c("1/2/2007", "2/2/2007"))

##Compute and add the Datetime variable
Pdata <- cbind(Pdata, 
               Datetime = as.Date(Pdata$Date, format = "%d/%m/%Y") %>% paste(Pdata$Time) %>% 
                 strptime(format = "%Y-%m-%d %H:%M:%S"))

png(width = 480, height = 480, file = "plot4.png")
        ##Set up a 2X2 grid for four plots
        par(mfrow = c(2,2))
        ##Make the first plot, for Global_active_power as a function of Datetime
        with(Pdata, plot(Datetime, Global_active_power, xlab = NA, ylab = "Global Active Power", type = "l"))
        ##Plot 2 is for Voltage as a function of Datetime
        with(Pdata, plot(Datetime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l"))
        ##Plot 3, as in plot3.R, is first inialized by plotting Sub_metering_1 as a function of Datetime,then adding 
        ##the rest with calls to lines() and legend()
        with(Pdata, plot(Datetime, Sub_metering_1, xlab = NA, ylab = "Energy sub metering", type="l"))
                lines(Pdata$Datetime, Pdata$Sub_metering_2, col = "red")
                lines(Pdata$Datetime, Pdata$Sub_metering_3, col = "blue")
                legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), bty = "n",
                col = c("black", "red", "blue"))
        ##Plot 4 is for Global_reactive_power as a function of Datetime
        with(Pdata, plot(Datetime, Global_reactive_power, xlab = "datetime", type = "l"))
dev.off()