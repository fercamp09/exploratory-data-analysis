library(ggplot2)
library(dplyr)
# Read emissions data
pm25 <- readRDS("../data/exploratory/summarySCC_PM25.rds", refhook = NULL)
head(pm25)
# Process data into total emissions per year 1999, 2002, 2005 and 2008
filtered <- pm25 %>% filter( fips=="24510" )
grouped_by_type_year <- filtered %>% group_by(type, year) %>% summarise(total_emissions = sum(Emissions))

# Graph total emissions per year
par(mfcol = c(1,1))
ggplot(data = grouped_by_type_year, aes (x = year, y = total_emissions )) + geom_line(aes(color = type)) + facet_grid(rows = vars(type) ) + theme_bw()
ggsave("plot3.png", width = 5, height = 5)
dev.off()


