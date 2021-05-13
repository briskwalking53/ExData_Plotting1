#
# This is plot2.R file
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
png("plot2.png")


# plot the grahp of the daily Global Active Power 
plot(file$DateandTime, file$Global_active_power, type ="l", xlab ="", ylab = "Global Active Power (kilowatts)",xaxt ="n")
axis(1, at = c(1170255600, 1170341970, 1170428340), labels = c("Thu", "Fri", "Sat"))

# close the graphics device
dev.off()

# move to the original directory
## setwd(orgdir)