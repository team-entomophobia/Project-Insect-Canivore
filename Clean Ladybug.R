library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)

rm(list = ls())
setwd("//Users/baodinhgiatran/Documents/GitHub/entomophobia/Project-Insect-Canivore")
df <- read.csv("data/Scan Ladybug Data.csv")

#remove duplicates
df %>%
  dplyr::distinct(id)

#Clean state column
df$stateProvince[df$stateProvince == "IL"] <- "Illinois"
df$stateProvince[df$stateProvince == "IA"] <- "Iowa"
df$stateProvince[df$stateProvince == "Ia"] <- "Iowa"
df$stateProvince[df$stateProvince == "Il"] <- "Illinois"

#Clean the year
df$eventDate <- as.Date(df$eventDate, "%m/%d/%Y")
df$year[is.na(df$year)] <- substring(df$eventDate[is.na(df$year)], 1, 4)
df$year <- as.numeric(df$year)

#Clean Scientific Name
df$scientificName[df$scientificName == ""] <- "Unknown"
df$scientificName <- toupper(df$scientificName)

#Selecting Columns that are going to be used
df_ladybug <- df %>%
  dplyr::rename("State" = "stateProvince") %>%
  dplyr::select("id", "scientificName", "State", "recordedBy", "year")

#Write into CSV file
write.csv(df_ladybug, "/Users/baodinhgiatran/Documents/GitHub/entomophobia/Project-Insect-Canivore/data/clean_data.csv", row.names = FALSE)
