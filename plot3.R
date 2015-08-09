library(dplyr)

##Load and subset the data.
Pdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", as.is = TRUE, na.strings = "?")
Pdata <- subset(Pdata, Date %in% c("1/2/2007", "2/2/2007"))

##Compute and add the Datetime variable
Pdata <- cbind(Pdata, 
               Datetime = as.Date(Pdata$Date, format = "%d/%m/%Y") %>% paste(Pdata$Time) %>% 
                 strptime(format = "%Y-%m-%d %H:%M:%S"))

png(width = 480, height = 480, file = "plot3.png")
        ##First plot the Sub_metering_1 line
        with(Pdata, plot(Datetime, Sub_metering_1, xlab = NA, ylab = "Energy sub metering", type="l"))
        ##Then add the Sub_metering_2 line
        lines(Pdata$Datetime, Pdata$Sub_metering_2, col = "red")
        ##Then add the Sub_metering_3 line
        lines(Pdata$Datetime, Pdata$Sub_metering_3, col = "blue")
        ##Then add the legend
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), 
              col = c("black", "red", "blue"))
dev.off()