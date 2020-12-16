library(dplyr)
library(ggplot2)
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

data_sector <- SCC[grepl("mobile",SCC$EI.Sector, ignore.case=TRUE),]
scc_list <- data_sector[grep("vehicle",data_sector$SCC.Level.Two, ignore.case=TRUE),]

filteredSCC <- SCC[scc_list$SCC,]$SCC
filteredNEI <- NEI[NEI$SCC %in% filteredSCC,]
filteredNEI <- NEI[NEI$SCC %in% filteredSCC & NEI$fips %in% c("06037", "24510"),]
filteredNEI$year <- as.factor(filteredNEI$year)
combinedNEI <- mutate(filteredNEI, City = ifelse(fips == "06037", "Los Angeles, CA", ifelse(fips == "24510", "Baltimore City, MD", 0)))
agg <- aggregate(Emissions~(City+year), combinedNEI, sum)

png("plot6.png")
ggplot(data=agg, aes(y=Emissions, x=year, fill = City)) + 
  geom_bar(stat="identity", position = "dodge") +
  scale_y_continuous(breaks = round(seq(500, 7500, by = 500),1)) +
  ggtitle("Motor vehicle emission variation in Baltimore and Los Angeles in tons")+
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "PM2.5 Emissions (Tons)")
dev.off()