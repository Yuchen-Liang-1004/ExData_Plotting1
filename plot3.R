library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips == "24510")
type_emissions <- aggregate(Emissions ~ year + type, baltimore, sum)

png("plot3.png", width = 480, height = 480)
print(
  ggplot(type_emissions, aes(x = year, y = Emissions, color = type)) +
    geom_line(linewidth = 1) +
    geom_point(size = 2) +
    scale_x_continuous(breaks = sort(unique(type_emissions$year))) +
    labs(
      title = "Baltimore City PM2.5 Emissions by Source Type",
      x = "Year",
      y = "Total PM2.5 emissions (tons)",
      color = "Source type"
    ) +
    theme_bw()
)
dev.off()
