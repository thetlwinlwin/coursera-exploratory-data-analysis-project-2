library(dplyr)
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

total.emissions <- summarise(group_by(NEI,year),Emissions = sum(Emissions))
#str(total.emissions)
#View(total.emissions)
png(filename = 'plot1.png')
colors <- c(rgb(111/255, 151/255, 214/255,1),rgb(157/255, 111/255, 214/255,1),rgb(111/255, 214/255, 164/255,1),rgb(214/255, 183/255, 111/255,1))
x1 <- barplot(height = total.emissions$Emissions/1000, names.arg = total.emissions$year,
            xlab = 'years',ylab='total PM2.5 emission in kilotons',
            ylim=c(0,8000),main = 'Total PM2.5 emissions at various years in kilotons',col=colors)

text(x = x1, y = round(total.emissions$Emissions/1000,2),
     labels=round(total.emissions$Emissions/1000,2), pos = 3, cex = 0.9, col = "black")
dev.off()