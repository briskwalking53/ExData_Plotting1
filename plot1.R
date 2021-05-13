#
# This is Plot1.R file
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
file <- read.table(unzip(tmp), header=F, sep=";", stringsAsFactors = FALSE, skip = 66637, nrows = 2880)
colnames(file) <- read.table(unzip(tmp), header=F, sep=";", stringsAsFactors = FALSE, nrows = 1)

# delete the temporaly file
unlink(tmp);rm(tmp)

# convert between character representations and objects of class "Date"
file$Date <- as.Date(file$Date, format = "%d/%m/%Y")

# open the graphics device for PNG file
png("plot1.png")

# plot the histgram of Global Active Power by painting the bars red
hist(file$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

# close the graphics device
dev.off()

# move to the original directory
## setwd(orgdir)