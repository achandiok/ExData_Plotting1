##    Objective
## 1) Set working directory to the folder containing the "household_power_consumption.txt" data file. 
## 2) Import the data from 2/1/2007 and 2/2/2007 from the "household_power_consumption.txt"
##    and produces the plot "Plot1.png".
## 3) Send plot to the working folder


if (!file.exists("PowerDB.sqlite")){
  
  # load the library RSQLite and DBI for getting required data
  library(RSQLite)
  library(DBI)
  
  # Creating and Connecting to a database
  con <- dbConnect(RSQLite::SQLite(), dbname = "PowerDB.sqlite")
  
  # Reading the file into a SQLite database.
  dbWriteTable(con, name="Main", value="household_power_consumption.txt", 
               row.names=FALSE, header=TRUE, sep = ";")
  
  # Querying the database for the dates 2/1/2007 and 2/2/2007 and sending the data
  # to the data frame "Data"
  Data <- dbGetQuery(con, "SELECT * FROM Main WHERE Date = '1/2/2007' OR Date = '2/2/2007'")
  
  # Disconnecting
  dbDisconnect(con)
}
# Exporting plot to "Plot2.png" in the working directory folder.
png("Plot1.png",h=480,w=480)
hist(Data$Global_active_power,main = "Global Active Power", xlab="Global Active Power (kilowatts)", col="red", ylim = c(0, 1200))
dev.off()
