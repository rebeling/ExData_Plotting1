
# create a line chart of three different cols in one plot with legend
# from household_power_consumption.txt
# just have a look on two specific days

repo_path = ''


filepath = paste(repo_path, "household_power_consumption.txt", sep="")
imagepath = paste(repo_path, "Plot3.png", sep="")


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
                    header=TRUE,
                    # skip = 1,
                    colClass=colClass,
                    na.strings="?"
                    )

# get just 2007-02-01 and 2007-02-02
mydata_reduced <- subset(
    mydata, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# set data for the plot  labels
ylab = "Energy sub metering"
xlab = ""

# create a png
png(filename = imagepath,
    width = 480,
    height = 480,
    units = "px",
    bg = "transparent"
    )

# set up the plot
with(
    mydata_reduced,
    plot(
        mydata_reduced$Sub_metering_1,
        type='l',
        xaxt="n",
        xlab=xlab,
        ylab=ylab
        )
    )

# and add the others
with(
    mydata_reduced,
    lines(
        mydata_reduced$Sub_metering_2,
        col='red'
        )
    )

with(
    mydata_reduced,
    lines(
        mydata_reduced$Sub_metering_3,
        col='blue'
        )
    )


legend(
    "topright",
    lty=1,
    col=c("black", "red", "blue"),
    legend=c(
        names(mydata_reduced)[7],
        names(mydata_reduced)[8],
        names(mydata_reduced)[9])
    )

axis(
    1,
    at = c(
        1,
        as.integer(nrow(mydata_reduced)/2), nrow(mydata_reduced)
        ),
    labels = c("Thu", "Fri", "Sat"))

dev.off()
