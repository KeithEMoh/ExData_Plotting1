#Program to create a line plot of sub meter data (Plot 3)
#Relevant data columns: col 1 (date), col 7 (sub meter 1), col 8 (sub meter 2)
#and col 9 (sub meter 3)

#Read the data and copy the data that falls within the date range to variable "a"
data <- read.table("household_power_consumption.txt", header=FALSE,
                   sep=";", skip=1, stringsAsFactors=FALSE)
a <- subset(data, data[ ,1] == "1/2/2007" | data[ ,1] == "2/2/2007")

a[a[ ,7] == "?", 7] <- NA   #Change any "?" in the data to be plotted to "NA"
a[a[ ,8] == "?", 8] <- NA   #Change any "?" in the data to be plotted to "NA"
a[a[ ,9] == "?", 9] <- NA   #Change any "?" in the data to be plotted to "NA"

#Set various plot parameters so that the plot will correspond proportinally with
#the one shown in the specification.
par(mar=c(4, 5, 4, 9), mgp=c(3, 0.6, 0), cex.lab=0.9, cex.axis=0.9)

#Plot is over a 2 day period.  Extract first 3 chars of name of day for x-axis labeling.
firstTickDate <- as.Date(a[1,1], "%d/%m/%Y")
xAxisLabels <- c(substr(weekdays(firstTickDate), 1, 3),
                 substr(weekdays(firstTickDate + 1), 1, 3),
                 substr(weekdays(firstTickDate + 2), 1, 3))

#Figure out the maximum y axis value 
yMax <- max(max(as.numeric(a[ ,7]), as.numeric(a[ ,8]), as.numeric(a[ ,9]))) + 5

#Create the plot and store it in a .png file.
#Insert a legend in the top right corner.
png(filename = "Plot3.png", width=480, height=480)
plot(as.numeric(a[ ,7]), xlab="", ylim=c(0,yMax), 
     ylab="Energy sub metering", xaxt="n",yaxt="n", type="n")
axis(side=1, at=c(1, 1+nrow(a)/2, nrow(a)), labels=xAxisLabels)
axis(side=2, at=c(0,10,20,30))
lines(as.numeric(a[ ,7]), col="black")
lines(as.numeric(a[ ,8]), col="red")
lines(as.numeric(a[ ,9]), col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), cex=0.9,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()