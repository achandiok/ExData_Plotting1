## Objective
## 1) Set working directory to the folder containing the "household_power_consumption.txt" data file. 
## 2) Import the data from 2/1/2007 and 2/2/2007 from the "household_power_consumption.txt"
##    and produces the plot "Plot3.png".
## 3) Send plot to the working folder


if (!file.exists("PowerDB.sqlite")){
  
  
  #  loading the library
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
  
  # Disconnecting
  dbDisconnect(con)
}

# Exporting plot to "Plot3.png" in the working directory folder. 
png("Plot3.png",h=480,w=480)

plot(Data$Sub_metering_1,type="l", ylab="Energy sub metering",xaxt="n",xlab="",main="")
lines(Data$Sub_metering_2,col="red")
lines(Data$Sub_metering_3,col="blue")
axis(1, at=c(0,1440,2880), labels=c("Thu","Fri","Sat"))
legend("topright",  c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"))

dev.off()

