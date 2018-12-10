## Peer-graded Assignment:<br> Exploratory Data Aalysis Course Project


These are my files for the final assignment of the course 'Exploratory Data Aalysis' of the Data Science Specialization.

### Introduction

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. 

For each of the following questions/tasks make a single plot using any plotting system unless specified.

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
3. Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen greater changes over time in motor vehcle emissions?

This repo contains:

* Six scripts 'plot#.R' (#=1,...,6) that produce the respective plot 'plot#.png'.
* Six .png files 'plot#.png' (#=1,...,6) with the plot for each of the si questions of the assignment.
* A codebook 'CodeBook.md'.

## Scripts

Apart from the base R, the scripts bellow use (at least one of) the following packages:

* dplyr
* ggplot2
* tidyr


1. __'plot1.R'__ - sums all the emissions for each year and produces a bar plot with 'total emissions' vs 'year' using the base plot system.
2. __'plot2.R'__ - filters the data using the fips code of Baltimore city, sums all the emissions for each year and produces a bar plot with 'total emissions' vs 'year' using the base plot system.
3. __'plot3.R'__ - filters the data using the fips code of Baltimore city and sums all the emissions for each year and type. For each year and type calculates the relative variation with respect to the initial value ('Vatiation from 1999 (\%)') and to the previous year ('3 year variation (\%)'). Finally, the script produces a bar plot with 'total emissions', 'Vatiation from 1999 (\%)' and '3 year variation (\%)' vs 'year' using the ggplot2 plot system.
4. __'plot4.R'__ - extracts the state identifier from the 2 initial digits of the fips code and sums all the emissions for each year and state. Emissions for which a state cannot be assigned based on the fips code are grouped in _'state'=='NA_. The total emissions per year are calculated and appended to the dataframe with a 'state' identifier 'USA'.  Finally, the script produces a grid of bar plots with 'total emissions' vs 'year' per state using the ggplot2 plot system. 
5. __'plot5.R'__ - filters the data using the fips code of Baltimore city and the list of emission sources in order to select only 'motor vehicles' according to criteria defined in the CodeBook. The total emissions per year are calculated  and as well as the relative variation with respect to the initial value ('Vatiation from 1999 (\%)') and to the previous year ('3 year variation (\%)'). Finally, the script produces a bar plot with 'total emissions', 'Vatiation from 1999 (\%)' and '3 year variation (\%)' vs 'year' using the ggplot2 plot system.
6. __'plot6.R'__ - filters the data using the fips code of Baltimore city and Los Angeles County and the list of emission sources in order to select only 'motor vehicles' according to criteria defined in the CodeBook. The total emissions per year are calculated  and as well as the relative variation with respect to the initial value ('Vatiation from 1999 (\%)') and to the previous year ('3 year variation (\%)'). Finally, the script produces a bar plot with 'total emissions', 'Vatiation from 1999 (\%)' and '3 year variation (\%)' vs 'year' using the ggplot2 plot system.