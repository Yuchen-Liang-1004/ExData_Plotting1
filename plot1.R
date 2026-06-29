NEI <- readRDS("summarySCC_PM25.rds")

total_emissions <- aggregate(Emissions ~ year, NEI, sum)

png("plot1.png", width = 480, height = 480)
plot(
  total_emissions$year,
  total_emissions$Emissions,
  type = "b",
  pch = 19,
  lwd = 2,
  xaxt = "n",
  xlab = "Year",
  ylab = "Total PM2.5 emissions (tons)",
  main = "Total PM2.5 Emissions in the United States"
)
axis(1, at = total_emissions$year)
dev.off()
