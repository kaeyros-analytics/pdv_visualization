# 1. loading required libraries ----
library(shiny)
library(tidyverse)
library(plotly)
library(here)
library(readxl)
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

# 2. loading and preparing input data (Bavaria) ----

# Constructing path of relevant directories
root <- getwd()
path_data <- paste(root, "/", "data", sep="")

file.data1 <- paste(path_data, 
  "/Cashback_BAVARIA__Fridge_inventory_Jul_2023_corrected.xlsx", sep="")
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


# 3. loading required modules ----

# UI (Tabs) modules
eval(parse('./modules/tab_company.R', encoding="UTF-8"))
#eval(parse('./modules/tab_attendace.R', encoding="UTF-8"))
eval(parse('./modules/tab_growth.R', encoding="UTF-8"))
eval(parse('./modules/tab_sales_growth.R', encoding="UTF-8"))
eval(parse('./modules/tab_operational.R', encoding="UTF-8"))

# Plot modules
#eval(parse('./modules/Nber_of_success_billers.R', encoding="UTF-8"))
eval(parse('./modules/transactions.R', encoding="UTF-8"))
eval(parse('./modules/Nber_of_transactions.R', encoding="UTF-8"))
eval(parse('./modules/table_top_service_type.R', encoding="UTF-8"))
eval(parse('./modules/top_10_transaction_service_type.R', encoding="UTF-8"))
eval(parse('./modules/transaction_service_title.R', encoding="UTF-8"))
eval(parse('./modules/transaction_service_type.R', encoding="UTF-8"))

# table modules
eval(parse('./modules/table_top_agent.R', encoding="UTF-8"))

