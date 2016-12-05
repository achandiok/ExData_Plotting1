## Objective
## 1) Set working directory to the folder containing the "household_power_consumption.txt" data file. 
## 2) Import the data from 2/1/2007 and 2/2/2007 from the "household_power_consumption.txt"
##    and produces the plot "Plot4.png".
## 3) Send plot to the working folder

if (!file.exists("PowerDB.sqlite")){
  
  # Loading the library
  library(RSQLite)
  library(DBI)
  
  
  # Creating and Connecting to a database
  con <- dbConnect("SQLite", dbname = "PowerDB.sqlite")
  
  # Reading the file into a SQLite database.
  dbWriteTable(con, name="Main", value="household_power_consumption.txt", 
               row.names=FALSE, header=TRUE, sep = ";")
  
  # Querying the database for the dates 2/1/2007 and 2/2/2007 and send this data
  # to the data frame "Data"
  Data <- dbGetQuery(con, "SELECT * FROM Main WHERE Date = '1/2/2007' OR Date = '2/2/2007'")
  
  # Disconnecting the connection
  dbDisconnect(con)
}

# Exporting plot to "Plot4.png" in the working directory folder. 

png("Plot4.png",h=480,w=480)

# Creating a 2x2 figure plot.
par(mfrow=c(2,2))

# Coding for the first plot.
plot(Data$Global_active_power,type="l", ylab="Global Active Power (kilowatts)",xaxt="n",xlab="",main="")
axis(2, at=c(0,2,4,6), labels=c(0,2,4,6))
axis(1, at=c(0,1440,2880), labels=c("Thu","Fri","Sat"))

# Coding for the second plot.
plot(Data$Voltage,type="l", ylab="Voltage",xaxt="n",xlab="datetime",main="")
axis(2, at=c(234,238,242,246), labels=c(234,238,242,246))
axis(1, at=c(0,1440,2880), labels=c("Thu","Fri","Sat"))

# Coding for the third plot.
plot(Data$Sub_metering_1,type="l", ylab="Energy sub metering",xaxt="n",xlab="",main="")
lines(Data$Sub_metering_2,col="red")
lines(Data$Sub_metering_3,col="blue")
axis(1, at=c(0,1440,2880), labels=c("Thu","Fri","Sat"))
legend("topright",  c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n", lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"))

# Coding for the fourth plot.
plot(Data$Global_reactive_power,type="l", ylab="Global_reactive_power",xaxt="n",xlab="datetime",main="")
axis(2, at=c(0.0,0.1,0.2,0.3,0.4,0.5), labels=c(0.0,0.1,0.2,0.3,0.4,0.5))
axis(1, at=c(0,1440,2880), labels=c("Thu","Fri","Sat"))

dev.off()

