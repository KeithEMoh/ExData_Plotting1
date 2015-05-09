data <- read.table("household_power_consumption.txt", header=FALSE,
                   sep=";", skip=1, stringsAsFactors=FALSE)
a <- subset(data, data[ ,1] == "1/2/2007" | data[ ,1] == "2/2/2007")
a[a[ ,3] == "?", 3] <- NA
a[a[ ,7] == "?", 7] <- NA
a[a[ ,8] == "?", 8] <- NA
a[a[ ,9] == "?", 9] <- NA
firstTickDate <- as.Date(a[1,1], "%d/%m/%Y")
xAxisLabels <- c(substr(weekdays(firstTickDate), 1, 3),
                 substr(weekdays(firstTickDate + 1), 1, 3),
                 substr(weekdays(firstTickDate + 2), 1, 3))

png(filename = "Plot4.png", width=480, height=480)
par(mfcol=c(2,2), mar=c(4, 5, 5, 1), mgp=c(3, 0.6, 0), 
    cex.axis=0.9, cex.label=0.9, tck=-0.04)

##First plot (Global Active Power) -- row 1, col 1
with(a, plot(as.numeric((as.character(V3))), type="l", xlab="", 
     ylab="Global Active Power", xaxt="n"))
axis(side=1, at=c(1, 1+nrow(a)/2, nrow(a)), labels=xAxisLabels)

##Second plot (Energy Sub Metering) -- Row 2, col 1
yMax <- max(max(as.numeric(a[ ,7]), as.numeric(a[ ,8]), as.numeric(a[ ,9]))) + 5
with(a, plot(as.numeric(V7), xlab="", ylim=c(0,yMax), 
     ylab="Energy sub metering", xaxt="n",yaxt="n", type="n"))
axis(side=1, at=c(1, 1+nrow(a)/2, nrow(a)), labels=xAxisLabels)
axis(side=2, at=c(0,10,20,30))
with(a, lines(as.numeric(V7), col="black"))
with(a, lines(as.numeric(V8), col="red"))
with(a, lines(as.numeric(V9), col="blue"))
legend("topright", bty="n", cex=0.9, lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Third plot (Voltage) -- Row 1, col 2
with(a, plot(as.numeric((V5)), type="l", xlab="datetime",
             ylab="Voltage", xaxt="n"))
axis(side=1, at=c(1, 1+nrow(a)/2, nrow(a)), labels=xAxisLabels)

##Fourth plot (Global Reactive Power) -- Row 2, col 2
with(a, plot(as.numeric((V4)), type="l", xlab="datetime",
             ylab="Global_reactive_power", xaxt="n"))
axis(side=1, at=c(1, 1+nrow(a)/2, nrow(a)), labels=xAxisLabels)

dev.off()