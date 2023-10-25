
library(shiny)
library(tidyverse)
library(plotly)
library(here)
library("readxl")
library(dplyr)
library(stringr)


# Constructing path of relevant directories
root <- getwd()
path_helpers <- paste(root, "/R", sep="")
path_data <- paste(path_helpers, "/", "Data", sep="")
#path_data <- paste(root, "/", "data", sep="")
#path_helpers <- paste(root, "/codes/helpers", sep="")
#path_meta <- paste(root, "/", "meta", sep="")

# data path
file.data <- paste(path_data, "/presence_worshop_sch1.xlsx", sep="")

# read data
df_workshop <- readxl::read_excel(file.data)

# Remove columns "N°"
clean_df_workshop <- df_workshop %>% 
  select(-c("N°"))


# Display the data frame where Observations == "NA" 
#clean_df_workshop_na <- clean_df_workshop %>% 
#  filter(is.na(Observations))

# Display the data frame where Observations != "NA" 
#clean_df_workshop <- clean_df_workshop %>% 
#  filter(!is.na(Observations))

# Replace REFUSE in column Observations with ACCEPTÉ and ACCEPTE WITH ACCEPTÉ
clean_df_workshop <- clean_df_workshop %>%
  mutate(Observations = case_when(Observations == 'REFUSE' ~ 'ACCEPTÉ',
                                  Observations == 'ACCEPTE' ~ 'ACCEPTÉ'))

# Replace missing values with 'REFUSÉ' in Observations column
clean_df_workshop$Observations <- clean_df_workshop$Observations %>% replace_na('REFUSÉ')
#table(clean_df_workshop$Observations,useNA = 'ifany')

clean_df_workshop <- clean_df_workshop %>%
  mutate(`Condition requise` = ifelse(`Condition requise` == "Master 2", "Master II", "Master II")
  )

# Replace DOCTORAT in column Diplôme le plus élevé du candidat with Doctorat and ACCEPTE WITH ACCEPTÉ
#clean_df_workshop <- clean_df_workshop %>%
#  mutate(Observations = case_when(`Condition requise` == 'master 2' ~ 'Master II'))

#clean_df_workshop %>% 
#  mutate(across('Condition requise', str_replace, 'master 2', 'Master II'))
                                  

# create a new data frame
# we have to the columns "Present_01", "Present_02", "Present_03" to one column presence and "Day_01" Day_02",                           
# "Day_03" to another column date

#create data frame with 0 rows and 5 columns
df <- data.frame(matrix(ncol = 12, nrow = 3*nrow(clean_df_workshop)))

#provide column names
colnames(df) <- c("Nom du candidat", "Date de naissance", "Age", "Sexe", "Diplôme le plus élevé du candidat", 
                  "Condition requise", "Domaine d'étude", "Institut de provenance", "Contact",
                  "Observations", "Date", "Presence")


df$`Nom du candidat` <- rep(clean_df_workshop$`Nom du candidat`, 3)
df$`Date de naissance` <- rep(clean_df_workshop$`date de naissance`, 3)
df$`Age` <- rep(clean_df_workshop$`Age`, 3)
df$`Sexe` <- rep(clean_df_workshop$`Sexe`, 3)
df$`Diplôme le plus élevé du candidat` <- rep(clean_df_workshop$`Diplôme le plus élevé du candidat`, 3)
df$`Condition requise` <- rep(clean_df_workshop$`Condition requise`, 3)
df$`Domaine d'étude` <- rep(clean_df_workshop$`Domaine d'étude`, 3)
df$`Institut de provenance` <- rep(clean_df_workshop$`institut de provenance`, 3)
df$`Contact` <- rep(clean_df_workshop$`Contact`, 3)
df$`Observations` <- rep(clean_df_workshop$`Observations`, 3)
df$`Date` <- c(clean_df_workshop$`Day_01`, clean_df_workshop$`Day_02`, clean_df_workshop$`Day_03`)
# Remove All Whitespaces
df$Date <- as.Date(gsub(" ", "", df$Date))
df$`Presence` <- c(clean_df_workshop$`Present_01`, clean_df_workshop$`Present_02`, clean_df_workshop$`Present_03`)

# extract only the integer part from the values
df$`Age` <- as.integer(df$`Age`)

# Convert First letter of every word to Uppercase
df$`Nom du candidat` <- stringr::str_to_title(df$`Nom du candidat`)


colnames(df)
colnames(clean_df_workshop)
nrow(clean_df_workshop)

str(clean_df_workshop)
test <- c(clean_df_workshop$`Nom du candidat`, clean_df_workshop$`Nom du candidat`, clean_df_workshop$`Nom du candidat`)

test1 <- rep(clean_df_workshop$`Nom du candidat`, 3)

date1 <- c(clean_df_workshop$Day_01, clean_df_workshop$Day_02, clean_df_workshop$Day_03)

colnames(clean_df_workshop)


dat22 <- df_workshop %>%
  mutate(Observations = case_when(Observations == 'REFUSE' ~ 'ACCEPTE',
         Observations == 'ACCEPTE' ~ 'ACCEPTE'))
                         

dat33 <- df %>%
  mutate(
    `Condition requise` = ifelse(`Condition requise` == "Master 2", "Master II", "Master II")
  )

#replace missing values with 'single' in status column
#dat33$Observations %>% replace_na('none')
dat33$Observations <- dat33$Observations %>% replace_na('REFUSÉ')

table(dat33$Observations,useNA = 'ifany')

# data table fromthe data workshop expectations

df_workshop_expectations <- df_expectations

# https://stackoverflow.com/questions/37158678/capitalize-with-dplyr
df_workshop_expectations %>%
  mutate(Noms = sub("(.)", "\\U\\1", Noms, perl=TRUE))

# https://stackoverflow.com/questions/38963805/using-dplyr-and-tidyr-within-a-function-to-capitalize-first-and-last-names-in-a
df_workshop_expectations <- df_workshop_expectations %>%
  mutate(Domaines = sub("(.)", "\\U\\1", Domaines, perl=TRUE))

df_workshop_expectations <- df_workshop_expectations %>%
  mutate(Attentes = sub("(.)", "\\U\\1", Attentes, perl=TRUE))

library("writexl")
write_xlsx(df_workshop_expectations,"C:Users\Gleyne Monthe\Desktop\git_test\DataDrivenWorkshop\R\Data\workshop_expectations.xlsx")

write.csv(df_workshop_expectations,'C:Users\Gleyne Monthe\Desktop\git_test\DataDrivenWorkshop\R\Data\workshop_expectations.csv', row.names=FALSE)


"C:\Users\Gleyne Monthe\Desktop\git_test\DataDrivenWorkshop\R\Data\workshop_expectations.csv"

#############################################################################################

# https://www.kaggle.com/datasets/imdevskp/ebola-outbreak-20142016-complete-dataset?resource=download
ebola_data <- readr::read_csv(here::here("R/Data/ebola_2014_2016_clean.csv"))
ebola_data <- as.data.frame(ebola_data)

length(unique(ebola_data$Country))

new_ebola_data <- ebola_data %>% 
  mutate(month_ = lubridate::month(Date),
         year_ = lubridate::year(Date),
         day_ = lubridate::day(Date)) # %>%

# Calculate number of suspected cases per country
#ddf_nr_suspected_cases <- ebola_data %>%
#  dplyr::group_by(Country) %>%
#  summarise(`Cumulative no. of confirmed, probable and suspected cases` = n())

# Calculate number of suspected cases per country
df_sum_suspected_cases <- new_ebola_data %>%
  dplyr::group_by(Country) %>%
  dplyr::summarise(suspected_cases = sum(`Cumulative no. of confirmed, probable and suspected cases`, na.rm = TRUE))

# Calculate number of suspected cases per country and date
#df_nr_suspected_cases_date <- new_ebola_data %>%
#  dplyr::group_by(Country, year_) %>%
#  summarise(`Cumulative no. of confirmed, probable and suspected cases` = n())

# Calculate number of suspected cases per country and year
df_sum_suspected_cases_date <- new_ebola_data %>%
  dplyr::group_by(Country, year_) %>%
  dplyr::summarise(suspected_cases = sum(`Cumulative no. of confirmed, probable and suspected cases`, na.rm = TRUE))

# Calculate number of suspected cases per country
Deaths_df_nr_suspected <- new_ebola_data %>%
  dplyr::group_by(Country) %>%
  dplyr::summarise(suspected_deaths = sum(`Cumulative no. of confirmed, probable and suspected deaths`, na.rm = TRUE))
#summarise(`Cumulative no. of confirmed, probable and suspected deaths` = n())

# Calculate number of suspected deaths per country and year
Deaths_df_nr_suspected_date <- new_ebola_data %>%
  dplyr::group_by(Country, year_) %>%
  dplyr::summarise(suspected_deaths = sum(`Cumulative no. of confirmed, probable and suspected deaths`, na.rm = TRUE))
#summarise(`Cumulative no. of confirmed, probable and suspected deaths` = n())


# Calculate number of suspected deaths, suspected deaths and suspected recover per country and year
df_suspected_cases_deaths_per_year <- new_ebola_data %>%
  dplyr::group_by(Country, year_) %>%
  dplyr::summarise(suspected_cases = sum(`Cumulative no. of confirmed, probable and suspected cases`, na.rm = TRUE),
                   suspected_deaths = sum(`Cumulative no. of confirmed, probable and suspected deaths`, na.rm = TRUE))%>%
  dplyr::mutate(suspected_recover = suspected_cases - suspected_deaths) %>%
  arrange(desc(suspected_cases))

fig1 <- plotly::plot_ly(data = data_cases_deaths, type = "scatter", mode = "lines") %>%
  add_trace(x = ~Date, y = ~suspected_cases, name = "Cases", mode = 'lines+markers',
            line = list(color = '#7B68EE', width = 3.5), marker=list(color = '#7B68EE', width = 9),
            hovertext = paste("Date :", data_cases_deaths$Date,
                              "<br>Suspected cases :",formatC(data_cases_deaths$suspected_cases, format = "d",
                                                              big.mark = "."), ""),
            hoverinfo = 'text') %>%
  add_trace(x = ~Date, y = ~suspected_deaths, name = "Deaths",yaxis = "y2", 
            mode = 'lines+markers',line=list(color = '#3CB371', width = 3.5), 
            marker=list(color = '#3CB371', width = 9),
            hovertext = paste("Date :", data_cases_deaths$Date,
                              "<br>Suspected deaths :", formatC(data_cases_deaths$suspected_deaths, format = "d", 
                                                                big.mark = "."), ""),
            hoverinfo = 'text') %>%
  layout(title = "",# hovermode = "x unified",
         uniformtext=list(minsize=15, mode='show'),
         xaxis = list(title = "<b> Date </b>",type="date", tickformat="%Y-%m-%d", tickangle= -45,
                      tickvals = data_cases_deaths$Date,
                      tickfont = list(size = 14),
                      titlefont = list(size = 16)),
         yaxis = list(title = "<b> Ebola suspeted cases </b>", titlefont = list(color = "#7B68EE", size = 17),
                      #titlefont = list(size = 18),
                      tickfont = list(size = 14)),
         yaxis2 = list(title = "<b> Ebola suspected deaths </b>", titlefont = list(color = "#3CB371", size = 17),
                       tickfont = list(size = 14),
                       #titlefont = list(size = 18),
                       overlaying = "y",
                       side = "right"),#) %>%
         #legend = list(orientation = 'v', xanchor = "center")
         #legend = list(x = 0.1, y = 0.9)
         legend = list(x = 100, y = 0.97)) %>%
  config(displayModeBar = F, scrollZoom = T)
fig1

# Calculate number of suspected deaths, suspected deaths and suspected recover per country and date
df_suspected_cases_deaths_per_day <- new_ebola_data %>%
  #filter(year_ >= '2014' & year_ <= '2016') %>%
  dplyr::filter(between(Date, as.Date('2014-08-29'), as.Date('2014-11-29'))) %>%
  dplyr::group_by(Date) %>%
  dplyr::summarise(suspected_cases = sum(`Cumulative no. of confirmed, probable and suspected cases`, na.rm = TRUE),
                   suspected_deaths = sum(`Cumulative no. of confirmed, probable and suspected deaths`, na.rm = TRUE))%>%
  dplyr::mutate(suspected_recover = suspected_cases - suspected_deaths) %>%
  ungroup()


fig2 <- plotly::plot_ly(data = data_cases_deaths, type = "scatter", mode = "lines") %>%
  add_trace(x = ~Date, y = ~suspected_cases, name = "Cases", mode = 'lines+markers',
            line = list(color = '#7B68EE', width = 3.5), marker=list(color = '#7B68EE', width = 9),
            hovertext = paste("Date :", data_cases_deaths$Date,
                              "<br>Suspected cases :",formatC(data_cases_deaths$suspected_cases, format = "d",
                                                              big.mark = "."), ""),
            hoverinfo = 'text') %>%
  add_trace(x = ~Date, y = ~suspected_deaths, name = "Deaths",yaxis = "y2", 
            mode = 'lines+markers',line=list(color = '#3CB371', width = 3.5), 
            marker=list(color = '#3CB371', width = 9),
            hovertext = paste("Date :", data_cases_deaths$Date,
                              "<br>Suspected deaths :", formatC(data_cases_deaths$suspected_deaths, format = "d", 
                                                                big.mark = "."), ""),
            hoverinfo = 'text') %>%
  layout(title = "",# hovermode = "x unified",
         uniformtext=list(minsize=15, mode='show'),
         xaxis = list(title = "<b> Date </b>",type="date", tickformat="%Y-%m-%d", tickangle= -45,
                      tickvals = data_cases_deaths$Date,
                      tickfont = list(size = 14),
                      titlefont = list(size = 16)),
         yaxis = list(title = "<b> Ebola suspeted cases </b>", titlefont = list(color = "#7B68EE", size = 17),
                      #titlefont = list(size = 18),
                      tickfont = list(size = 14)),
         yaxis2 = list(title = "<b> Ebola suspected deaths </b>", titlefont = list(color = "#3CB371", size = 17),
                       tickfont = list(size = 14),
                       #titlefont = list(size = 18),
                       overlaying = "y",
                       side = "right"),#) %>%
         #legend = list(orientation = 'v', xanchor = "center")
         #legend = list(x = 0.1, y = 0.9)
         legend = list(x = 100, y = 0.97)) %>%
  config(displayModeBar = F, scrollZoom = T)
fig2


  
#summarise(`Cumulative no. of confirmed, probable and suspected deaths` = n())

# https://www.kaggle.com/datasets/lydia70/malaria-in-africa
malaria_data <- readr::read_csv(here::here("R/Data/DatasetAfricaMalaria.csv"))
malaria_data <- as.data.frame(malaria_data)

length(unique(malaria_data$`Country Name`))

# https://www.kaggle.com/datasets/samuelkamau/kenyas-agricultural-production-1960-2022
kenyas_Agricultural_data <- readxl::read_excel(here::here("R/Data/Kenyas_Agricultural_Production.xlsx"))
kenyas_Agricultural_data <- as.data.frame(enyas_Agricultural_data)

length(unique(malaria_data$`Country Name`))

list.files(here::here("R/Modules")) %>%
  here::here("R/Modules", .) %>%
  purrr::walk(~source(.))