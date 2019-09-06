library(ggplot2)
library(dplyr)
# Read emissions data
pm25 <- readRDS("../data/exploratory/summarySCC_PM25.rds", refhook = NULL)
SCC <- readRDS("../data/exploratory/Source_Classification_Code.rds")

# Process data into total emissions per coal
veh <- SCC %>% filter( grepl('Veh', EI.Sector))
filtered <- pm25 %>% filter( SCC  %in% veh$SCC )  %>% filter( fips=="24510" | fips=="06037" )  %>% mutate( county = case_when(fips =="24510" ~ paste("Baltimore City", fips, sep = " - "), fips == "06037"~ paste("Los Angeles County", fips, sep = " - ")))
grouped_by_year <- filtered %>% group_by(year, county) %>% summarise(total_emissions = sum(Emissions))

# Graph total emissions of coal per year 
par(mfcol = c(1,1))
ggplot(data = grouped_by_year, aes (x = year, y = total_emissions) ) + geom_line(aes(color = county)) + facet_grid(rows = vars(county) ) + theme_bw() 
ggsave("plot6.png", width = 5, height = 5)
#dev.copy(png, file="plot6.png")
dev.off()
