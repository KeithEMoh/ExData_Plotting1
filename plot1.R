#Program to create a historgam of global active power (Plot 1)
#Relevant data columns: column 1 (date) and column 3 (global active power)

#Read the data and copy the data that falls within the date range to variable "a"
data <- read.table("household_power_consumption.txt", header=FALSE,
                    sep=";", skip=1, stringsAsFactors=FALSE)
a <- subset(data, data[ ,1] == "1/2/2007" | data[ ,1] == "2/2/2007")

a[a[ ,3] == "?", 3] <- NA   #Change any "?" in the data to be plotted to "NA"

#Create the histogram and store it in a .png file.  Override cex.lab and cex.axis values
#so that the axis and label text size is consistent with what is shown in the specification
png(filename = "Plot1.png", width=480, height=480)
hist(as.numeric(a[ ,3]), col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", cex.lab=0.9, cex.axis=0.9)
dev.off()