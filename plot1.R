library(dplyr)

png("plot1.png")

par(bg = "transparent")

PM25_data <- readRDS("summarySCC_PM25.rds") %>%
#    filter(!grepl("(^00)|(^85)|(^TR)|(^  )",fips)) %>% 
    group_by(year) %>%
    summarize(totalemissions = sum(Emissions)/10^6)

barplot(PM25_data$totalemissions, 
        names.arg = PM25_data$year, 
        col="blue", 
        space = .3, 
        xlab = "Year", 
        ylab = "PM2.5  (10^6 tons)", 
        main = "Total PM2.5 emissions in USA")


# Close graphics device
dev.off()