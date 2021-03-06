
powerdata <- read.table('household_power_consumption.txt', header=TRUE, sep=";",
                        na.strings=c("?"),
                        colClasses = c("character","character","numeric","numeric", 
                                       "numeric","numeric","numeric",
                                       "numeric","numeric") )

powerdata <- powerdata[powerdata$Date %in% c("1/2/2007","2/2/2007"),]

powerdata[,'DateTime'] <- apply(powerdata[,c('Date','Time')] , 1,
                                function(x) as.POSIXct(strptime(paste(x[1],x[2],sep="-"),
                                                                format="%d/%m/%Y-%T"),
                                                       origin="1970-01-01"))

daterange=c(as.POSIXlt(min(powerdata$DateTime),origin="1970-01-01"), 
            as.POSIXlt(max(powerdata$DateTime)+60,origin="1970-01-01"))

png(filename = "plot4.png")

par(mfrow=c(2,2))

with(powerdata,plot(DateTime,Global_active_power, type='l',
                    xlab='',ylab='Global Active Power',xaxt='n'))
axis.POSIXct(1, at=seq(daterange[1],daterange[2],by="day"),format='%a')


with(powerdata,plot(DateTime,Voltage, type='l',
                    xlab='datetime',ylab='Voltage',xaxt='n'))
axis.POSIXct(1, at=seq(daterange[1],daterange[2],by="day"),format='%a')


with(powerdata,plot(DateTime,Sub_metering_1, type='l',
                    xlab='',ylab='Energy sub metering',
                    xaxt='n', col='black'))

with(powerdata,lines(DateTime,Sub_metering_2,col='red'))
with(powerdata,lines(DateTime,Sub_metering_3,col='blue'))
axis.POSIXct(1, at=seq(daterange[1],daterange[2],by="day"),format='%a')
legend("topright",lty=1,col=c('black','red','blue'),bty='n',
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(powerdata,plot(DateTime,Global_reactive_power, type='l',
                    xlab='datetime',ylab='Global_reactive_power',xaxt='n'))
axis.POSIXct(1, at=seq(daterange[1],daterange[2],by="day"),format='%a')

dev.off()

