
# create a line chart of Global Active Power
# from household_power_consumption.txt
# just have a look on two specific days

repo_path = ''

filepath = paste(repo_path, "household_power_consumption.txt", sep="")
imagepath = paste(repo_path, "Plot2.png", sep="")


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

# set data for the plot  labels
ylab = "Global Active Power (kilowatts)"
xlab = ""

# create a png
png(filename = imagepath,
    width = 480,
    height = 480,
    units = "px",
    bg = "transparent"
    )

# set up the plot
plot(
    mydata_reduced$Global_active_power, type="l",
    xaxt="n",   # suppress the x axis, see axis labels below
    ylab=ylab,
    xlab=xlab
    )

axis(
    1,
    at = c(
        1,
        as.integer(nrow(mydata_reduced)/2), nrow(mydata_reduced)
        ),
    labels = c("Thu", "Fri", "Sat"))

dev.off()
