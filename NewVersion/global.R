
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
# Constructing path of relevant directories
root <- getwd()
path_helpers <- paste(root, "/R", sep="")
path_data <- paste(path_helpers, "/", "Data", sep="")
#path_data <- paste(root, "/", "data", sep="")
#path_helpers <- paste(root, "/codes/helpers", sep="")
#path_meta <- paste(root, "/", "meta", sep="")

# data path
file.data <- paste(path_data, "/presence_worshop_sch_new123.xlsx", sep="")
file.data2 <- paste(path_data, "/df_age_group_gender.csv", sep="")
file.data3 <- paste(path_data, "/workshop_expectations.xlsx", sep="")

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

# read data
df_age_group_gender <- read.csv(file.data2)

df_expectations <- readxl::read_excel(file.data3)

df_workshop <- readxl::read_excel(file.data)

df_workshop$`Date de naissance` <-  as.Date(df_workshop$`Date de naissance`)
df_workshop$Date <-  as.Date(df_workshop$Date)

# Display the data frame where Presence != "NA" 
clean_df_workshop <- df_workshop %>% 
  filter(!is.na(Presence))

# count number of attendance per day
df_presence_per_sexe <- clean_df_workshop %>%
  filter(Presence == "present") %>%
  group_by(Date, Sexe) %>%
  dplyr::count(Presence)
df_presence_per_sexe <- as.data.frame(df_presence_per_sexe)

# count number of attendance per day
df_presence_all <- clean_df_workshop %>%
  filter(Presence == "present")  %>%
  group_by(Date) %>%
  dplyr::count(Presence)

# Create the variable Sexe and add the values All to the data frame  df_presence_all
df_presence_all$Sexe <- c("All", "All", "All")

df_presence <- rbind(df_presence_all,df_presence_per_sexe)

df_presence <- as.data.frame(df_presence)

#Change the column name - `Domaine d'étude` to Domaine_detude
df_etude <- clean_df_workshop %>% 
  rename("Domaine_detude" = `Domaine d'étude`)
#table(df_etude$Domaine_detude,useNA = 'ifany')



# UI (Tabs) modules
eval(parse('./R/modules/tab_company.R', encoding="UTF-8"))
#eval(parse('./R/modules/tab_attendace.R', encoding="UTF-8"))
eval(parse('./R/modules/tab_growth.R', encoding="UTF-8"))
eval(parse('./R/modules/tab_sales_growth.R', encoding="UTF-8"))
eval(parse('./R/modules/tab_operational.R', encoding="UTF-8"))

# Plot modules
#eval(parse('./R/modules/Nber_of_success_billers.R', encoding="UTF-8"))
eval(parse('./R/modules/transactions.R', encoding="UTF-8"))
eval(parse('./R/modules/Nber_of_transactions.R', encoding="UTF-8"))
eval(parse('./R/modules/table_top_service_type.R', encoding="UTF-8"))
eval(parse('./R/modules/top_10_transaction_service_type.R', encoding="UTF-8"))
eval(parse('./R/modules/transaction_service_title.R', encoding="UTF-8"))
eval(parse('./R/modules/transaction_service_type.R', encoding="UTF-8"))

# table modules
eval(parse('./R/modules/table_top_agent.R', encoding="UTF-8"))