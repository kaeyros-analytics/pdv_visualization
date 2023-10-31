
library(shiny)
library(tidyverse)
library(plotly)
library(here)
library("readxl")
library(dplyr)
library(stringr)
library(shinydashboard)
library(DT)
library(rsconnect)
library(sp)
library(maps)
library(maptools)
library(leaflet)
library(lubridate)
library(shinythemes)

# Constructing path of relevant directories
root <- getwd()
path_helpers <- paste(root, "/R", sep="")
path_data <- paste(path_helpers, "/", "Data", sep="")

file.data1 <- paste(path_data, "/Cashback_BAVARIA__Fridge_inventory_Jul_2023_corrected_new1.xlsx", sep="")
df_bavaria1 <- readxl::read_excel(file.data1)

# Convert GPSLatitude, GPSLongitude and GPSAccuracy to numeric
df_bavaria1$GPSLatitude <- as.numeric(df_bavaria1$GPSLatitude)
df_bavaria1$GPSLongitude <- as.numeric(df_bavaria1$GPSLongitude)
df_bavaria1$GPSAccuracy <- as.numeric(df_bavaria1$GPSAccuracy)

# select only the date
df_bavaria1$Date <- as.Date(df_bavaria1$StatusDate, format = "%d-%m-%y")

# Create the variable categories_contrat
df_bavaria1 <- df_bavaria1 %>%
  mutate(categories_contrat =case_when(
    difftime(df_bavaria1$Date_de_fin_de_contrat, today(), units = "days") <= 7 ~ "brown1",
    difftime(df_bavaria1$Date_de_fin_de_contrat, today(), units = "days") > 7 & 
      difftime(df_bavaria1$Date_de_fin_de_contrat, today(), units = "days") <= 30 ~ "orange",
    difftime(df_bavaria1$Date_de_fin_de_contrat, today(), units = "days") > 30 ~ "darkgreen"
  ))


# UI (Tabs) modules
eval(parse('./R/modules/tab_map.R', encoding="UTF-8"))
eval(parse('./R/modules/tab_volume_vente.R', encoding="UTF-8"))
eval(parse('./R/modules/tab_vente_category.R', encoding="UTF-8"))

# Display modules
eval(parse('./R/modules/map_plot.R', encoding="UTF-8"))
eval(parse('./R/modules/volume_vente_pays.R', encoding="UTF-8"))
eval(parse('./R/modules/volume_vente_ville.R', encoding="UTF-8"))
eval(parse('./R/modules/volume_vente_category.R', encoding="UTF-8"))
eval(parse('./R/modules/top10_vente_category.R', encoding="UTF-8"))







