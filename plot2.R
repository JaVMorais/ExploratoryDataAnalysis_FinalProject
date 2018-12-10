library(dplyr)

png("plot2.png")

par(bg = "transparent")

PM25_data <- readRDS("summarySCC_PM25.rds") %>%
    filter(fips=="24510") %>%
    group_by(year) %>%
    summarize(totalemissions = sum(Emissions)/10^3)

barplot(PM25_data$totalemissions, 
        names.arg = PM25_data$year, 
        col="blue", 
        space = .3, 
        xlab = "Year", 
        ylab = "PM2.5  (10^3 tons)", 
        main = "Total PM2.5 emissions in Baltimore City")


# Close graphics device
dev.off()