library(dplyr)
library(ggplot2)

filter_SCCL4 <- paste(
    "(All$)",
    "(Total$)",
    "(Equipment)",
    "(Saws)",
    "(^AC)",
    "(Tampers)",
    "(^Signal)",
    "(Lawn Mowers)",
    "(Trimmers/Edgers/Brush)",
    "(Snowblowers \\(Residential\\))",
    "(Shredders)",
    "(Hydro-power Units)",
    "(Sets)",
    "(Pumps)",
    "(Compressors)",
    "(Welders)",
    "(Pressure Washers)",
    sep ="|"
)

SCC_motorvehicles <- readRDS("Source_Classification_Code.rds")  %>% 
    subset(
        subset = (
            (Data.Category == "Onroad")|
                (
                    (Data.Category == "Nonroad") & 
                        !grepl(filter_SCCL4,SCC.Level.Four) 
                )
        ),
        select = 1
    )


PM25_data <- readRDS("summarySCC_PM25.rds") %>%
    filter(fips=="24510") %>%
    filter(SCC %in% as.character(SCC_motorvehicles$SCC)) %>%
    mutate(
        year = factor(year),
        Emissions = Emissions/10^2
    ) %>%
    group_by(year) %>%
    summarize(
        totalemissions = sum(Emissions)
    )%>%
    mutate(
        var_to_init = ave(totalemissions, FUN=function(x) 100*c(NA, tail(x,-1)/head(x,1)-1)),
        var_to_previous = ave(totalemissions, FUN=function(x) 100*c(NA, diff(x)/head(x,-1)))
    ) %>%
    gather(
        key = measure, 
        value = value, 
        totalemissions:var_to_previous,
        na.rm = TRUE
    ) 



g <- ggplot(PM25_data, aes(year,value,color="red", fill="red"))

(g + geom_bar(stat="identity", position=position_dodge()) +
        facet_grid(
            measure ~.,
            scales = "free_y",
            labeller = labeller(
                measure = c(
                    'totalemissions' = "PM2.5 (10^2 tons)",
                    'var_to_init' = "Variation from 1999 (%)",
                    'var_to_previous' = "3-year variation (%)"
                )
            )
        ) +
        labs(x="Year",y="", title = "PM2.5 emissions by motor vehicles", subtitle = "Baltimore City") +
        theme_bw(base_size = 11) +
        theme(
            strip.background = element_blank(),
            strip.text.y = element_text(size = 8),
            legend.position = 'none'
        )) %>%
    ggsave(filename = "plot5.png", device = "png", width=4, height = 7)