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

png(filename = "plot1.png")
with(powerdata,hist(Global_active_power, main='Global Active Power',
                    xlab='Global Active Power (kilowatts)',col='red'))


dev.off()