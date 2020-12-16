library(dplyr)
library(ggplot2)
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

data_sector <- SCC[grepl("mobile",SCC$EI.Sector, ignore.case=TRUE),]
scc_list <- data_sector[grep("vehicle",data_sector$SCC.Level.Two, ignore.case=TRUE),]

filteredSCC <- SCC[scc_list$SCC,]$SCC
filteredNEI <- NEI[NEI$SCC %in% filteredSCC,]
filteredNEI$year <- as.factor(filteredNEI$year)
baltimore <- subset(filteredNEI, fips=="24510")
agg <- aggregate(Emissions~year, filteredNEI, sum)

png("plot5.png")
ggplot(data=agg, aes(y=Emissions/10^6, x=year,fill=year)) + 
  geom_bar(stat="identity") +
  ggtitle("Emissions from motor vehicle sources in Baltimore City")+
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "total PM2.5 Emissions (million Tons)")
dev.off()