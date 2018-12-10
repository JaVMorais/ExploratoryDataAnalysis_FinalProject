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
png("plot1.png")

par(bg = "transparent")

#-------------------------
#
#       Reading data and calculating total emissions
#
#-------------------------
PM25_data <- readRDS("summarySCC_PM25.rds") %>%
    group_by(year) %>%
    summarize(totalemissions = sum(Emissions)/10^6)  # value of emissions in 10^6 tons

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
        ylab = "PM2.5  (10^6 tons)", 
        main = "Total PM2.5 emissions in USA")


# Close graphics device
dev.off()