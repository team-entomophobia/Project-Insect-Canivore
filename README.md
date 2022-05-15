# Project-Insect-Canivore

# Cleaning Process
The stateProvidence column was cleaned. So all the abbreviations were changed to be the full name of the state. 
```
df$stateProvince[df$stateProvince == "IL"] <- "Illinois"
df$stateProvince[df$stateProvince == "IA"] <- "Iowa"
df$stateProvince[df$stateProvince == "Ia"] <- "Iowa"
df$stateProvince[df$stateProvince == "Il"] <- "Illinois"
```

Next the year column was updated to be numeric.
```
df$year <- as.numeric(df$year)
```

For the scientificName column, if there was blanks it was changed to reflect unknown. 
```
df$scientificName[is.na(df$scientificName)] <- "Unknown"
```

Then renamed the stateProvince column and scientificName to be State and Scientific Name. Then selected the columns that we wanted to work with.
```
df_ladybug <- df %>%
  dplyr::rename("State" = "stateProvince",
                "Scientific Name" = "scientificName") %>%
  dplyr::select("Scientific Name", "State", "year")
```


