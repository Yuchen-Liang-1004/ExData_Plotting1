library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_combustion_scc <- SCC$SCC[grepl("Coal", SCC$EI.Sector)]

coal_emissions <- subset(NEI, SCC %in% coal_combustion_scc)
coal_totals <- aggregate(Emissions ~ year, coal_emissions, sum)

png("plot4.png", width = 480, height = 480)
print(
  ggplot(coal_totals, aes(x = year, y = Emissions)) +
    geom_line(color = "steelblue", linewidth = 1) +
    geom_point(color = "steelblue", size = 2) +
    scale_x_continuous(breaks = sort(unique(coal_totals$year))) +
    labs(
      title = "Coal Combustion PM2.5 Emissions in the United States",
      x = "Year",
      y = "Total PM2.5 emissions (tons)"
    ) +
    theme_bw()
)
dev.off()
