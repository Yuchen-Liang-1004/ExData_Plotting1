data_file <- "household_power_consumption.txt"
desktop_file <- file.path(Sys.getenv("HOME"), "Desktop", data_file)

if (!file.exists(data_file)) {
  data_file <- desktop_file
}

power_data <- read.table(
  data_file,
  header = TRUE,
  sep = ";",
  na.strings = "?",
  colClasses = c("character", "character", rep("numeric", 7))
)

power_data <- power_data[power_data$Date %in% c("1/2/2007", "2/2/2007"), ]
power_data$DateTime <- strptime(
  paste(power_data$Date, power_data$Time),
  format = "%d/%m/%Y %H:%M:%S"
)

png("plot2.png", width = 480, height = 480)
plot(
  power_data$DateTime,
  power_data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)
dev.off()
