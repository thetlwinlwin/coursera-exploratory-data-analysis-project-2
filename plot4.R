library(dplyr)
library(ggplot2)
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

data_comb_coal_short_nm <- SCC[grepl("coal|comb",SCC$Short.Name, ignore.case=TRUE),]
scc_list <- data_comb_coal_short_nm[grepl("coal",data_comb_coal_short_nm$SCC.Level.Four, ignore.case=TRUE),]

filteredSCC <- SCC[scc_list$SCC,]$SCC
filteredNEI <- NEI[NEI$SCC %in% filteredSCC,]
filteredNEI$year <- as.factor(filteredNEI$year)
agg <- aggregate(Emissions~year, filteredNEI, sum)


png("plot4.png")
ggplot(data=agg, aes(y=Emissions/10^6, x=year,fill=year)) + 
  geom_bar(stat="identity") +
  ggtitle("Emissions from coal combustion-related sources")+
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "PM2.5 Emissions (million Tons)")+
  scale_y_continuous(breaks=seq(0,0.6,by=0.1), limits=c(0,0.6)) 
dev.off()