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

png(filename = "plot2.png")

with(powerdata,plot(DateTime,Global_active_power, type='l',
                    xlab='',ylab='Global Active Power (kilowatts)',xaxt='n'))
axis.POSIXct(1, at=seq(daterange[1],daterange[2],by="day"),format='%a')

dev.off()
