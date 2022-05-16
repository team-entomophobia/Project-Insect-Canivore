library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(ggplot2)

rm(list = ls())
setwd("/Users/baodinhgiatran/Documents/GitHub/entomophobia/Project-Insect-Canivore/")
df <- read.csv("data/clean_data.csv")


#Make years into decades
df_decades <- df
df_decades$year <-substring(df_decades$year, 1,3)
df_decades$year <- paste(df_decades$year, "0s", sep = "")

df_decades_count <- df_decades %>%
  count(year)

#line graph of number of ladybugs within certain decades
ggplot(data = df_decades_count, aes(x=year, y = n, group = 1)) +
  geom_line(color = "#FFCC33") + ylim(0,500)+
  ggtitle("Number of Ladybugs recorded by Decades")+
  labs(x = "Decades", y = "Number of Ladybugs")+ geom_point(color = "#003366")+
  theme_minimal()

#bar graph for how many butterflies within states
df_state <- df %>%
  count(State)

ggplot(df_state, aes(x=State, y=n)) +
  geom_bar(stat = "identity", fill = "#003366")  + ylim(0,400)+
  geom_text(aes(label=n), vjust=-0.3, size=3.5)+
  xlab("States") + 
  ylab("Number of Ladybugs Found") + 
  ggtitle("Number of Ladybugs Found by State") +
  theme_minimal() 

#bar graph showing number of butterflies by scientific name
df_name <- df %>%
  group_by(State) %>%
  count(scientificName)

ggplot(df_name, aes(fill = State, y = n, x = scientificName)) +
  geom_bar(position = "stack", stat = "identity") + coord_flip()+
  ggtitle("Number of Ladybugs recorded by Scientific Name and State") + ylim(0, 180)+
  labs(x = "Scientific Name", y = "Number of Ladybugs") +
  theme(axis.text = element_text(angle = 0, vjust = 1, hjust = 1),
        panel.background = element_rect(fill = "#FFFFFF", linetype = "solid"),
        panel.grid.major = element_line(size = 0.1, linetype = 'solid',
                                        colour = "black"))
