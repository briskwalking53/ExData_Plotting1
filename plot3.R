#
# This is plot3.R file
#

# move to the working directory
## workdir <- "./work"
## if(!file.exist(workdir)){dir.create(workdir)}
## orgdir <- getwd()
## setwd(workdir)

# download the zip file from  UC Irvine Machine Learning Repository
tmp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tmp, method = "curl")

# extract the zip file, read the data from 2007/02/01 to 2007/02/02 and rename colums of the data
file <- 0
file <- read.table(unzip(tmp), header=F, sep=";", stringsAsFactors = FALSE, skip = 66637, nrows = 2880)
colnames(file) <- read.table(unzip(tmp), header=F, sep=";", stringsAsFactors = FALSE, nrows = 1)

# delete the temporaly file
unlink(tmp);rm(tmp)

# convert between character representations and objects of class "Date" and "Time"
file$Date <- as.Date(file$Date, format = "%d/%m/%Y")
file$tmpTime <- 0
file$tmpTime <- strptime(file$Time, format = "%H:%M:%S")

# combine Date & Time
file$DateandTime <- 0
file$sec <- 0
file$sec <- difftime(as.POSIXct(file$tmpTime), Sys.Date(), units = "sec")
file$DateandTime <- as.POSIXct(file$Date) + file$sec

# open the graphics device for PNG file
png("plot3.png")


# plot the grahp of the daily Global Active Power 
plot(file$DateandTime, file$Sub_metering_1, type ="l", xlab ="", ylab = "", ylim=c(0,40), xaxt = "n", yaxt = "n")
par(new = T)
plot(file$DateandTime, file$Sub_metering_2, type ="l", xlab ="", ylab = "", ylim = c(0,40), col = "red", xaxt = "n",yaxt = "n")
par(new = T)
plot(file$DateandTime, file$Sub_metering_3, type ="l", xlab ="", ylab = "Energy sub metering", ylim = c(0,40), col = "blue", xaxt = "n",yaxt = "n")
legend("topright", legend=c(colnames(file[,c(7,8,9)])),col = c("black", "red", "blue"),lty = c(1,1,1), xjust = 0)
axis(1, at = c(1170255600, 1170341970, 1170428340), labels = c("Thu", "Fri", "Sat"))
axis(2, at = c(0,10,20,30))

# close the graphics device
dev.off()

# move to the original directory
## setwd(orgdir)