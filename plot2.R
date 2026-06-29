NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips == "24510")
baltimore_emissions <- aggregate(Emissions ~ year, baltimore, sum)

png("plot2.png", width = 480, height = 480)
plot(
  baltimore_emissions$year,
  baltimore_emissions$Emissions,
  type = "b",
  pch = 19,
  lwd = 2,
  xaxt = "n",
  xlab = "Year",
  ylab = "Total PM2.5 emissions (tons)",
  main = "Total PM2.5 Emissions in Baltimore City"
)
axis(1, at = baltimore_emissions$year)
dev.off()
