#-------------------------
#
#       Packages required
#
#-------------------------
library(dplyr)

#-------------------------
#
#       Loading graphics devide
#
#-------------------------
png("plot2.png")

par(bg = "transparent")

#-------------------------
#
#       Reading data and calculating total emissions
#
#-------------------------
PM25_data <- readRDS("summarySCC_PM25.rds") %>%
    filter(fips=="24510") %>%  # selecting Baltimore City
    group_by(year) %>%
    summarize(totalemissions = sum(Emissions)/10^3) # value of emissions in 10^3 tons

#-------------------------
#
#       Plotting
#
#-------------------------
barplot(PM25_data$totalemissions, 
        names.arg = PM25_data$year, 
        col="blue", 
        space = .3, 
        xlab = "Year", 
        ylab = "PM2.5  (10^3 tons)", 
        main = "Total PM2.5 emissions in Baltimore City")


# Close graphics device
dev.off()