library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)

rm(list = ls())
setwd("/Users/chloefausett/Library/Mobile Documents/com~apple~CloudDocs/Documents/DATA 332/Project-Insect-Carnivore-main")
df <- read.csv("data/testing.csv")

#Make years into decades
df_decades <- df
df_decades$year <-substring(df_decades$year, 1,3)
df_decades$year <- paste(df_decades$year, "0s", sep = "")

df_decades_count <- df_decades %>%
  count(year)

#line graph of number of ladybugs within certain decades
ggplot(data = df_decades_count, aes(x=year, y = n, group = 1)) +
  geom_line(color = "#FFCC33") +
  ggtitle("Number of Ladybugs recorded by Decades")+
  labs(x = "Decades", y = "Number of Ladybugs")+ geom_point(color = "#003366")+
  theme_minimal()

#bar graph for how many butterflies within specific scientific name
df_name_count <- df %>%
  count(Scientific.Name)

ggplot(df_name_count, aes(x=Scientific.Name, y=n)) +
  geom_bar(stat = "identity") + 
  xlab("Scientific Name") + 
  ylab("Number of Ladybugs Found") + 
  ggtitle("Number of Ladybugs Found by Scientific Name") +
  theme(axis.text = element_text(angle = 45, vjust = 1, hjust = 1))

#bar graph showing
df_name <- df %>%
  group_by(State) %>%
  count(Scientific.Name)

ggplot(df_name, aes(fill = State, y = n, x = Scientific.Name)) +
  geom_bar(position = "stack", stat = "identity") +
  ggtitle("Number of Ladybugs recorded by Scientific Name and State") +
  labs(x = "Scientific Name", y = "Number of Ladybugs") +
  theme(axis.text = element_text(angle = 60, vjust = 1, hjust = 1))
