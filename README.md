# Project-Insect-Canivore 🐞

## Contributors
Bao Tran, Chloe Fausett, Kiet Vu

---
## Introduction
We analyze the lady data collection process of this project. 

---
## Dictionary 📖
The columns that were used are: 
1. id: the unique id of a record.
2. scientificName: the scientific name of a species.
3. State: the name of a state where a sample was recorded.
4. recordedBy: the name of a person who recorded the sample.
5. year: the year in which the sample was recorded.

---
## Cleaning Process 🧹
1. Remove duplicate records:
```
df %>%
  dplyr::distinct(id)
```

2. Clean the state column:
- All the abbreviations were changed to be the full name of the state. 
```
df$stateProvince[df$stateProvince == "IL"] <- "Illinois"
df$stateProvince[df$stateProvince == "IA"] <- "Iowa"
df$stateProvince[df$stateProvince == "Ia"] <- "Iowa"
df$stateProvince[df$stateProvince == "Il"] <- "Illinois"
```

3. Year column:
- Use the year of the eventDate column if the year column has a blank value.
- The year column was updated to be numeric.
```
df$eventDate <- as.Date(df$eventDate, "%m/%d/%Y")
df$year[is.na(df$year)] <- substring(df$eventDate[is.na(df$year)], 1, 4)
df$year <- as.numeric(df$year)
```

4. Scientific name:
- For the scientificName column, if there was blanks it was changed to reflect unknown. 
```
df$scientificName[is.na(df$scientificName)] <- "Unknown"
```

5. Renamed the stateProvince column to be State. Then selected the columns that we wanted to work with:
```
df_ladybug <- df %>%
  dplyr::rename("State" = "stateProvince") %>%
  dplyr::select("id", "scientificName", "State", "recordedBy", "year")
```

6. Export to CSV file:
```
write.csv(df_ladybug, "/Users/baodinhgiatran/Documents/GitHub/entomophobia/Project-Insect-Canivore/data/clean_data.csv", row.names = FALSE)
```

---
## Data Analysis
1. Number of records over decade:
<div align = "center">
<img src = "https://github.com/team-entomophobia/Project-Insect-Canivore/blob/5a943e651d62531178c24cd69b40f846fac4c731/chart_image/bar_graph_by_decade.png" width = "600")>
</div>

- As shown by the graph, most of the data was recorded recently. Eventhough there are some samples recorded in the 20th century, they are much less than the recent ones.
- We found this information was interesting because it seems like the project started a while ago and has been updating so far. However, we think a spike in the number of records in the 2020s may make the outcome subjective to the time.

2. Number of ladybugs by state:
<div align = "center">
<img src = "https://github.com/team-entomophobia/Project-Insect-Canivore/blob/f8411075098096cd18844fb21e4455b73dacfed0/chart_image/bar_chart_by_state.png" width = "600")>
</div>

- This graph is interesting as it illustrates how significant the number of ladybugs found in Illinois and Iowa is compared to that of other states.
- This outcome is understandable as our college is in between Illinois and Iowa. Therefore, it is more convenience for researchers to collect the data of this area than others.

3.  Number of ladybugs by scientific name:
<div align = "center">
<img src = "https://github.com/team-entomophobia/Project-Insect-Canivore/blob/bd0a483726bc3e71d7e46ceb4c920ab7b67d65a3/chart_image/bar_chart_scientific_name.png" width = "700")>
</div>

- According to the graph, _harmonia axyridis_ and _coleomegilla maculata_ are the specicies recorded the most. 
- Most of the species in this project can be found in Illinois and Iowa. However, some species such as _hyperaspis undulata_ or _anatis mali_ can be found in certain states such as Kansas or Minnesota.
