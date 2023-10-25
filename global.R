
# setting system local encoding
Sys.setlocale("LC_ALL", "English_United States.932") # this works perfectly ---> für japanese characters

# setting some options
options(stringsAsFactors = FALSE)
options(Encoding = "latin1")

# Loading required libraries
library(rJava)
library(shiny)
#library(sf)
library(shinyWidgets)
library(stringr)
library(leaflet)
library(plotly)
library(dplyr)
#library(DT)
#library(shinycssloaders)
library(lubridate)
library(rintrojs)
library(readxl)
library(shinyjs)
library(openxlsx)
library(readxl)
library(sp)
library(maps)
library(maptools)
#library(shinydashboard)
#library(shinythemes)
library(shiny.react)
library(shiny.router)


# Constructing path of relevant directories
root <- getwd()
path_helpers <- paste(root, "/R", sep="")
path_data <- paste(path_helpers, "/", "data", sep="")
#path_data <- paste(root, "/", "data", sep="")
#path_helpers <- paste(root, "/codes/helpers", sep="")
#path_meta <- paste(root, "/", "meta", sep="")

# data path

file.data1 <- paste(path_data, "/Cashback_BAVARIA__Fridge_inventory_Jul_2023_corrected_new1.xlsx", sep="")
df_bavaria1 <- readxl::read_excel(file.data1)

#file.data <- paste(path_data, "/Cashback_BAVARIA _Fridge inventory_Jul_2023_updated.xlsx", sep="")
#df_bavaria <- readxl::read_excel(file.data)

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

# UI (input) modules
eval(parse('./R/modules/pdv_daterange_filter.R', encoding="UTF-8"))
eval(parse('./R/modules/pdv_contry_filter.R', encoding="UTF-8"))
eval(parse('./R/modules/pdv_city_filter.R', encoding="UTF-8"))

eval(parse('./R/modules/map_sales_amount.R', encoding="UTF-8"))


