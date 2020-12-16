library(dplyr)
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

png(filename = 'plot2.png')
colors <- c(rgb(111/255, 151/255, 214/255,1),rgb(157/255, 111/255, 214/255,1),rgb(111/255, 214/255, 164/255,1),rgb(214/255, 183/255, 111/255,1))
baltimore.emissions <- summarise(group_by(filter(NEI,fips =='24510'),year),Emissions = sum(Emissions))

#View(baltimore.emissions)
#str(baltimore.emissions)
x2 <-barplot(height = baltimore.emissions$Emissions/1000,names.arg = baltimore.emissions$year,
             xlab = 'years',ylab='total PM2.5 emissions in kilotons',ylim = c(0,4),
             main = 'Total PM2.5 emissions in Baltimore City,Maryland in kilotons',col = colors)
text(x = x2, y = round(baltimore.emissions$Emissions/1000,2),label=round(baltimore.emissions$Emissions/1000,2),pos=3,col='black')
dev.off()