library(ggplot2)
library(dplyr)
# Read emissions data
pm25 <- readRDS("../data/exploratory/summarySCC_PM25.rds", refhook = NULL)
SCC <- readRDS("../data/exploratory/Source_Classification_Code.rds")

# Process data into total emissions per coal
veh <- SCC %>% filter( grepl('Veh', EI.Sector))
filtered <- pm25 %>% filter( SCC  %in% veh$SCC )  %>% filter( fips=="24510" )
grouped_by_year <- filtered %>% group_by(year) %>% summarise(total_emissions = sum(Emissions))

# Graph total emissions of coal per year 
par(mfcol = c(1,1))
plot(grouped_by_year$year, grouped_by_year$total_emissions, xlab = "Years", ylab = "Total Emissions (tons)", main = "PM2.5 motor vehicle sources in Baltimore City", type = "b")
dev.copy(png, file="plot5.png")
dev.off()
