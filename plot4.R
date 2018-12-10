library(dplyr)
library(ggplot2)

SCC_coal <- readRDS("Source_Classification_Code.rds")  %>% 
    subset(
        subset = grepl("[Cc]oal",Short.Name),
        select = 1
    )

State_list <- read.table(
    "https://www2.census.gov/geo/docs/reference/state.txt", 
    header = TRUE, 
    sep = "|",
    colClasses = rep("character",4),
    col.names = c("fips","shortname","name","statens")
    ) %>%
    subset(select= c("fips","name"))

PM25_data <- readRDS("summarySCC_PM25.rds") %>%
    mutate(
        fips = ifelse(grepl("(^00)|(^85)|(^TR)|(^  )",fips),"other",fips)
    ) %>%
    filter(SCC %in% as.character(SCC_coal$SCC)) %>%
    mutate(
        Emissions = Emissions/10^3,
        state = substr(fips,1,2)
    ) %>%
    group_by(year,state) %>%
    summarize(
        totalemissions = sum(Emissions)
    ) %>%
    ungroup %>%
    mutate(
        state = as.character(State_list[
            match(state, State_list$fips),
            "name"
            ]
        )
    )


PM25_data_total <- PM25_data %>%
    group_by(year) %>%
    summarise(
        state = "USA",
        totalemissions = sum(totalemissions)
    ) %>%
    ungroup

PM25_data <- bind_rows(PM25_data, PM25_data_total) %>%
    group_by(state) %>%
    mutate(ave_emissions = mean(totalemissions)) %>% 
    arrange(desc(ave_emissions)) %>%
    ungroup %>%
    mutate(
        year = factor(year, sort(unique(year))),
        state = factor(state,unique(state))
        )

g <- ggplot(PM25_data, aes(year,totalemissions, color=state, fill = state))

(g + geom_bar(stat="identity",fill="white") +
    facet_wrap(state~., nrow = 11, scales = "free_y") +
    labs(x="Year",y="PM2.5 (10^3 tons)", title = "PM2.5 coal related emissions", subtitle = "USA by state") +
    theme_bw(base_size = 11) +
    theme(
        strip.background = element_blank(),
        strip.text.x = element_text(size = 8),
        strip.text.y = element_blank(),
        legend.position = 'none'
    )) %>%
    ggsave(filename = "plot4.png", device = "png", width=12, height = 10)