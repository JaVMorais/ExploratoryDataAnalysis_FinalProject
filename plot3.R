library(dplyr)
library(ggplot2)
library(tidyr)


PM25_data <- readRDS("summarySCC_PM25.rds") %>%
    filter(fips=="24510") %>%
    mutate(
        year = factor(year),
        type = factor(type, unique(type))
        ) %>%
    group_by(type,year) %>%
    summarize(totalemissions = sum(Emissions)/10^3) %>%
    mutate(
        var_to_init = ave(totalemissions, type, FUN=function(x) 100*c(NA, tail(x,-1)/head(x,1)-1)),
        var_to_previous = ave(totalemissions, type, FUN=function(x) 100*c(NA, diff(x)/head(x,-1)))
    )%>%
    gather(
        key = measure, 
        value = value, 
        totalemissions:var_to_previous,
        na.rm = TRUE,
        factor_key = TRUE
    ) 


ggplot(PM25_data, aes(year,value, color=type, fill = type)) %>%
     + geom_bar(stat="identity",fill="white", position=position_dodge()) %>% 
     + geom_text(
        aes(x = year, y = value, label = round(value,2)),
        vjust=-0.3,
        size=2.5,
        inherit.aes = FALSE
    ) %>%
     + facet_grid(
         measure~type,
         scales = "free_y",
         labeller = labeller(
             measure = c(
                'totalemissions' = "PM2.5 (10^3 tons)",
                'var_to_init' = "Variation from 1999 (%)",
                'var_to_previous' = "3-year variation (%)"
                )
         )
    )  %>%
     #+ ylim(0,2.5) %>%
     + labs(x="Year",y="", title = "PM2.5 emissions by type", subtitle = "Baltimore City")%>% 
     + theme_bw(base_size = 11) %>%
     + theme(
         strip.background = element_blank(),
#         strip.text.x = element_blank(),
#         strip.text.y = element_blank(),
         legend.position = 'none'
     ) %>%
     ggsave(filename = "plot3.png", device = "png", width=8, height = 7)
