library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)

rm(list = ls())
setwd("/Users/chloefausett/Library/Mobile Documents/com~apple~CloudDocs/Documents/DATA 332/Project-Insect-Carnivore-main")
df <- read_xlsx("data/Copy of Scan Ladybug Data.xlsx")

df %>%
  dplyr::distinct(id)

#Clean state column
df$stateProvince[df$stateProvince == "IL"] <- "Illinois"
df$stateProvince[df$stateProvince == "IA"] <- "Iowa"
df$stateProvince[df$stateProvince == "Ia"] <- "Iowa"
df$stateProvince[df$stateProvince == "Il"] <- "Illinois"

#Clean the year
df$year[is.na(df$year)] <- 0
df$year <- as.numeric(df$year)

#Clean Scientific Name
df$scientificName[is.na(df$scientificName)] <- "Unknown"
df$scientificName <- toupper(df$scientificName)

#Selecting Columns that are going to be used
df_ladybug <- df %>%
  dplyr::rename("State" = "stateProvince",
                "Scientific Name" = "scientificName") %>%
  dplyr::select("Scientific Name", "State", "year")

#Write into CSV file
write.csv(df_ladybug, "/Users/chloefausett/Documents/GitHub/team-entomophobia/Project-Insect-Canivore/data/testing.csv", row.names = FALSE)
