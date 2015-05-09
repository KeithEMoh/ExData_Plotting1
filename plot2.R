#Program to create a line plot of global active power (Plot 2)
#Relevant data columns: column 1 (date) and column 3 (global active power)

#Read the data and copy the data that falls within the date range to variable "a"
data <- read.table("household_power_consumption.txt", header = FALSE, 
                   sep = ";", skip = 1, stringsAsFactors=FALSE)
a <- subset(data, data[ ,1] == "1/2/2007" | data[ ,1] == "2/2/2007")

a[a[ ,3] == "?", 3] <- NA   #Change any "?" in the data to be plotted to "NA"

#Set plot margins so that the plot will correspond proportinally with the one shown
#in the specification.
par(mar=c(4, 5, 4, 9))

#Plot is over a 2 day period.  Extract first 3 chars of name of day for x-axis labeling.
firstTickDate <- as.Date(a[1,1], "%d/%m/%Y")
xAxisLabels <- c(substr(weekdays(firstTickDate), 1, 3),
                 substr(weekdays(firstTickDate + 1), 1, 3),
                 substr(weekdays(firstTickDate + 2), 1, 3))

#Create the plot and store it in a .png file.  Override cex.lab and cex.axis values
#so that the axis and label text size is consistent with what is shown in the specification
png(filename = "Plot2.png", width=480, height=480)
plot(as.numeric((a[ ,3])), type="l", xlab="", 
     ylab="Global Active Power (kilowatts)", 
     cex.lab=0.9, cex.axis=0.9, xaxt="n")
axis(side=1, at=c(1, 1+nrow(a)/2, nrow(a)), labels=xAxisLabels, cex.axis=0.9)
dev.off()