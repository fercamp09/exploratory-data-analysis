library(ggplot2)
library(dplyr)
# Read emissions data
pm25 <- readRDS("../data/exploratory/summarySCC_PM25.rds", refhook = NULL)
SCC <- readRDS("../data/exploratory/Source_Classification_Code.rds")

# Process data into total emissions per coal
coal <- SCC %>% filter( grepl('Coal', EI.Sector))
filtered <- pm25 %>% filter( SCC  %in% coal$SCC )
grouped_by_year <- filtered %>% group_by(year) %>% summarise(total_emissions = sum(Emissions))

# Graph total emissions of coal per year 
par(mfcol = c(1,1))
plot(grouped_by_year$year, grouped_by_year$total_emissions, xlab = "Years", ylab = "Total Emissions (tons)", main = "PM2.5 coal combustion related sources across the United States", type = "b")
dev.copy(png, file="plot4.png")
dev.off()
