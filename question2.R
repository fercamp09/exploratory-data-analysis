library(dplyr)
# Read emissions data
pm25 <- readRDS("../data/exploratory/summarySCC_PM25.rds", refhook = NULL)
head(pm25)
# Process data into total emissions per year 1999, 2002, 2005 and 2008
filtered <- pm25 %>% filter( fips=="24510" )
grouped_by_year <- filtered %>% group_by(year) %>% summarise(total_emissions = sum(Emissions))

# Graph total emissions per year
par(mfcol = c(1,1))
plot(grouped_by_year$year, grouped_by_year$total_emissions, xlab = "Years", ylab = "Total Emissions (tons)", main = "PM2.5 emissions in Baltimore City, Maryland", type = "b")
dev.copy(png, file="plot2.png")
dev.off()

