
setwd("D:/ML")
library(dplyr)
power<-read.table("household_power_consumption.txt", sep=';', header=TRUE)
power<-mutate(power,Date = as.Date(Date,'%d/%m/%Y'))
power<-mutate(power,Time = as.POSIXct(strptime(paste(Date, ' ', Time), '%Y-%m-%d %H:%M:%S')))
power<- filter(power,Time >= strftime('2007-02-01 00:00:00'), Time < strftime('2007-02-03 00:00:00'))
if(!file.exists('figures')) dir.create('figures')
png(filename = './figures/plot1.png', width = 480, height = 480, units='px')
hist(as.numeric(power$Global_active_power)/1000,
     main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()
strDay<-weekdays(as.Date(strftime('2007-02-01 00:00:00')), abbreviate = TRUE)
endDay<-weekdays(as.Date(strftime('2007-02-02 00:00:00')), abbreviate = TRUE)
startDay = as.POSIXct(strftime("2007-02-01 00:00:00"))
endDay = as.POSIXct(strftime("2007-02-03 00:00:00"))
if(!file.exists('figures')) dir.create('figures')
png(filename = './figures/plot2.png', width = 480, height = 480, units='px')
startDay = as.POSIXct(strftime("2007-02-01 00:00:00"))
endDay = as.POSIXct(strftime("2007-02-03 00:00:00"))
plot(power$Time,
     power$Global_active_power,
     xlim=c(startDay, endDay),
     xaxt="n",
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)"
)
axis.POSIXct(1, at=seq(startDay, endDay, by="day"), format="%a")
