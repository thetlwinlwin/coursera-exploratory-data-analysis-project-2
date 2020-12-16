library(ggplot2)
library(dplyr)
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

baltimore <- subset(NEI, fips=="24510")
baltimore$year <- as.factor(baltimore$year)
agg <- aggregate(Emissions~(year+type), baltimore, sum)


png("plot3.png")
# facet for each source type
ggplot(data=agg, aes(fill = type, y=Emissions, x=year)) + 
  geom_bar(stat="identity") +
  facet_wrap(~type) +
  ggtitle("Total PM2.5 Emissions - Baltimore City, MD", subtitle = "By Source Type")+
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "PM2.5 Emissions (million Tons)")
dev.off()