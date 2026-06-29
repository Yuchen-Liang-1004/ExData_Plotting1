library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

motor_vehicle_scc <- SCC$SCC[
  grepl("Vehicle", SCC$EI.Sector) |
    grepl("Vehicle", SCC$SCC.Level.Two)
]

baltimore_vehicles <- subset(NEI, fips == "24510" & SCC %in% motor_vehicle_scc)
baltimore_vehicle_totals <- aggregate(Emissions ~ year, baltimore_vehicles, sum)

png("plot5.png", width = 480, height = 480)
print(
  ggplot(baltimore_vehicle_totals, aes(x = year, y = Emissions)) +
    geom_line(color = "darkgreen", linewidth = 1) +
    geom_point(color = "darkgreen", size = 2) +
    scale_x_continuous(breaks = sort(unique(baltimore_vehicle_totals$year))) +
    labs(
      title = "Motor Vehicle PM2.5 Emissions in Baltimore City",
      x = "Year",
      y = "Total PM2.5 emissions (tons)"
    ) +
    theme_bw()
)
dev.off()
