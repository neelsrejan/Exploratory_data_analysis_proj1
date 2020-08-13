setwd("/Users/neelsrejan/datascience-R/course4/proj1")
zip_file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
unzip_file_name <- "./Electric_power_consumption"
file_name <- "./household_power_consumption.txt"

if (!file.exists(unzip_file_name)) {
    download.file(zip_file_url, destfile = unzip_file_name, method = "curl")
    unzip(unzip_file_name, overwrite = TRUE)
}

unclean_data <- read.table(file_name, header = T, sep = ";", na.string = "?")
unclean_data <- unclean_data[unclean_data$Date %in% c("1/2/2007", "2/2/2007"),]
date_and_time_str <- paste(unclean_data$Date, unclean_data$Time, sep = " ")
date_and_time_col <- strptime(date_and_time_str, format = "%d/%m/%Y %H:%M:%S")
clean_data <- cbind(date_and_time_col, unclean_data[,!(names(unclean_data) %in% c("Date", "Time"))])

png(filename = "./plot1.png")
hist(clean_data$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")
dev.off()