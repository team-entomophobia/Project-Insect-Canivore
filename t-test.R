library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(ggplot2)
library(reshape)

#setup directory and working file
rm(list = ls())
setwd("/Users/baodinhgiatran/Documents/GitHub/entomophobia/Project-Insect-Canivore/")
df <- read.csv("data/clean_data.csv")

#count number of records per year
df_per_year <- df %>%
  count(year, sort = TRUE)

#t-test with null hypothesis is that the mean number of records per year is 17
t.test(df_per_year$n, mu=17)