library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

motor_vehicle_scc <- SCC$SCC[
  grepl("Vehicle", SCC$EI.Sector) |
    grepl("Vehicle", SCC$SCC.Level.Two)
]

city_emissions <- subset(
  NEI,
  fips %in% c("24510", "06037") & SCC %in% motor_vehicle_scc
)
city_emissions$city <- ifelse(
  city_emissions$fips == "24510",
  "Baltimore City",
  "Los Angeles County"
)
city_vehicle_totals <- aggregate(Emissions ~ year + city, city_emissions, sum)

png("plot6.png", width = 480, height = 480)
print(
  ggplot(city_vehicle_totals, aes(x = year, y = Emissions, color = city)) +
    geom_line(linewidth = 1) +
    geom_point(size = 2) +
    scale_x_continuous(breaks = sort(unique(city_vehicle_totals$year))) +
    labs(
      title = "Motor Vehicle PM2.5 Emissions by City",
      x = "Year",
      y = "Total PM2.5 emissions (tons)",
      color = "Location"
    ) +
    theme_bw()
)
dev.off()
