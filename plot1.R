
# create a histogram of Global Active Power values
# from household_power_consumption.txt
# just have a look on two specific days

repo_path = ''

filepath = paste(repo_path, "household_power_consumption.txt", sep="")
imagepath = paste(repo_path, "Plot1.png", sep="")


# transform datestring via own class
setClass("myDate")
setAs("character", "myDate", function(from) as.Date(from, format="%d/%m/%Y"))

# define the data value types
colClass = c("myDate", "factor", "numeric", "numeric", "numeric", "numeric",
    "numeric", "numeric", "numeric")

# read file
mydata <- read.table(
                    filepath,
                    sep=";",
                    dec=".",
                    head=TRUE,
                    colClass=colClass,
                    na.strings="?"
                    )

# get just 2007-02-01 and 2007-02-02
mydata_reduced <- subset(
    mydata, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# set data for the histogram title and labels
title = "Global Active Power"
ylab = "Frequency"
xlab = "Global Active Power (kilowatts)"


# create a png
png(filename = imagepath,
    width = 480,
    height = 480,
    units = "px"
    )

# generate a histogram
hist(
    mydata_reduced$Global_active_power,
    col="red",
    main=title,
    xlab=xlab,
    ylab=ylab
)

dev.off()
