# Exploratory Data Analysis Course Project - Codebook

This is the codebook for the final project of the 'Exploratory Data Analysis' course of the Data Science specialization in Coursera.
The codebook is divided into three main sections: _Original Data_, _Final Data_, and _Processing the data_.

## Original Data

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

The data for this assignment are available as a .zip file <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip">here</a> [29MB]. The zip file contains two files:

* PM2.5 Emissions Data (\color{red}{\verb|summarySCC_PM25.rds|}summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year.

* Source Classification Code Table (\color{red}{\verb|Source_Classification_Code.rds|}Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

The file 'summarySCC_PM25.rds' has 6 variables:

1. __fips__: A five-digit number (represented as a string) indicating the U.S. county. 
2. __SCC__: The name of the source as indicated by a digit string (see source code classification table)
3. __Pollutant__: A string indicating the pollutant
4. __Emissions__: Amount of PM2.5 emitted, in tons
5. __type__: The type of source (point, non-point, on-road, or non-road)
6. __year__: The year of emissions recorded


__Note__

The first two digits of the fips county code designate the state (or equivalent territory) of the county. A list of the 2-digits fips state code, with  the respective 2-letter abbreviature and  state name can be found <a href="https://www2.census.gov/geo/docs/reference/state.txt">here</a>. An extended list which includes the fips codes for the Outlying Areas of the United States, the Freely Associated States and the Individual Minor Outlying Island Territories can also be found <a href="https://www.census.gov/geo/reference/ansi_statetables.html">here</a>.
While separating the list of fips numbers by state (first 2 digits of the county fips code), a few anomalies were detected:

1. __County fips code 00000__: This code is used to represent the USA as a whole unit. However, only values from 2002 and 2005 are present and therefore this data is filtered out.
2. __No county fips code (NA)__: It is not clear to which territory this data corresponds and therefore this data is filtered out.
3. __State fips code 85__: There is no state corresponding to this code, even in the extended territory list. Therefore this data is filtered out.
4. __State fips code "TR"__: There is no state corresponding to this code, even in the extended territory list. Therefore this data is filtered out.

The definition of 'motor vehicle' according to <a href="https://en.wikipedia.org/wiki/Motor_vehicle">Wikipedia</a> is _a self-propelled vehicle, commonly wheeled, that does not operate on rails (such as trains or trams) and is used for the transportation of people or cargo_. As such, we consider that a given source (SCC) refers to a 'motor vehicle' if:

1. __'Data.Categorry'__ == __'Onroad'__
2. __'Data.Categorry'__ == __'Nonroad'__ and __'SCC.Level.Four'__ !=
    
    * __'All'__ [1]
    * __'Total'__ [2]
    * __'Tampers/Rammers'__ [10]
    * __'Paving Equipment'__ [15]
    * __'Surfacing Equipment'__ [16]
    * __'Signal Boards/Light Plants'__ [17]
    * __'Concrete/Industrial Saws'__ [21]
    * __'Crushing/Processing Equipment'__ [26]
    * __'Other Construction Equipment'__ [35]
    * __'Other General Industrial Equipment'__ [39]
    * __'Other Material Handling Equipment'__ [40]
    * __'AC\\\\Refrigeration'__ [41]
    * __'Lawn Mowers (Residential)'__ [43]
    * __'Lawn Mowers (Commercial)'__ [44]
    * __'Chain Saws < 6 HP (Residential)'__ [47]
    * __'Chain Saws < 6 HP (Commercial)'__ [48]
    * __'Trimmers/Edgers/Brush Cutters (Residential)'__ [49]
    * __'Trimmers/Edgers/Brush Cutters (Commercial)'__ [50]
    * __'Snowblowers (Residential)'__ [53]
    * __'Shredders < 6 HP (Residential)'__ [59]
    * __'Shredders < 6 HP (Commercial)'__ [60]
    * __'Commercial Turf Equipment'__ [67]
    * __'Turf Equipment (Commercial)'__ [68]
    * __'Other Lawn and Garden Equipment (Residential)'__ [69]
    * __'Other Lawn and Garden Equipment (Commercial)'__[70]
    * __'Hydro-power Units'__ [79]
    * __'Other Agricultural Equipment'__ [80]
    * __'Irrigation Sets'__ [81]
    * __'Generator Sets'__ [82]
    * __'Pumps'__ [83]
    * __'Air Compressors'__ [84]
    * __'Gas Compressors'__ [85]
    * __'Welders'__ [86]
    * __'Pressure Washers'__ [87]
    * __'Chain Saws : 6 HP'__ [88]
    * __'Shredders : 6 HP'__ [89]
    * __'Other Underground Mining Equipment'__ [92]
    * __'Other Oil Field Equipment'__ [93]

## Final Data

### Structure

### Files

## Processing the data

