
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
file.data <- paste(path_data, "/presence_worshop_sch_new122.xlsx", sep="")

# read data
df_workshop <- readxl::read_excel(file.data)

# Display the data frame where Presence != "NA" 
clean_df_workshop <- df_workshop %>% 
  filter(!is.na(Presence))


# count number of Male and Female per day

df_male_female <- clean_df_workshop %>%
  group_by(Date, Sexe) %>%
  count(Sexe)


df_presence_per_day <- clean_df_workshop %>%
  group_by(Date) %>%
  dplyr::count(Presence)


fig_presence_per_day <- plotly::plot_ly(df_presence_per_day, x = ~Date,
                                                   type = "bar", 
                                                   y = ~n, color = ~Presence,
                                                   text = df_presence_per_day$n, textposition = 'auto',
                                                   textfont = list(color = "black"),
                                                   colors = c("slateblue", "#008080"),
                                                   #text = ~most_visited_service, textposition = 'outside',
                                                   hovertext = paste("Date :",df_presence_per_day$Date,
                                                                     "<br>Attendance :", df_presence_per_day$Presence,
                                                                     "<br> Number of person :", df_presence_per_day$n),
                                                   hoverinfo = 'text') %>%
  layout(title = "Attendance list per day",  barmode="stack", bargap=0.3,
         legend = list(x = 100, y = 0.95, title=list(color= "blue", text='<b>Attendance</b>')),
         uniformtext=list(minsize=15, mode='show'),
         xaxis = list(title = "<b> Date </b>", #font = list(size = 0),
                      #categoryorder = "total descending",
                      # change x-axix size
                      tickfont = list(size = 14),
                      tickformat="%d-%m-%Y",
                      # change x-title size
                      titlefont = list(size = 16), #type="date", tickformat="%Y%B",  tickformat = "%b-%Y",
                      tickangle= -45, tickvals = df_presence_per_day$Date),
         yaxis = list(title = "<b> Count </b>",
                      titlefont = list(size = 16),
                      #categoryorder = "total descending",
                      # change x-axix size
                      tickfont = list(size = 14))
         #tickvals = df_most_visited_service_month_year$most_visited_service)
         #hoverlabel=list(bgcolor="gainsboro")
         #width = 500, autosize=F,
         #bargap = 0.1, bargroupgap = 0.1,
  ) %>%
  config(displayModeBar = F, 
         scrollZoom = T)

fig_presence_per_day

# count number of attendance per day
df_presence_per_sexe <- clean_df_workshop %>%
  filter(Presence == "present") %>%
  group_by(Date, Sexe) %>%
  dplyr::count(Presence)

df_presence_per_sexe <- as.data.frame(df_presence_per_sexe)

df_present <- df_presence_per_sexe %>%
  filter(Presence == "present")
df_present <- as.data.frame(df_present)

# count number of attendance per day
df_presence_all <- clean_df_workshop %>%
  filter(Presence == "present")  %>%
  group_by(Date) %>%
  dplyr::count(Presence)

# Create the variable Sexe and add the values All to the data frame  df_presence_all
df_presence_all$Sexe <- c("All", "All", "All")


df3 <- rbind(df_presence_all,df_presence_per_sexe)

df3 <- as.data.frame(df3)


fig <- plot_ly(df3, x = ~Date, y = ~n, type = 'scatter', mode = 'lines+markers', linetype = ~Sexe,
               hovertext = paste("Date :",df3$Date,
                                 "<br>Sexe :", df3$Sexe,
                                 "<br> Number of person :", df3$n),
               hoverinfo = 'text') %>%
  layout(title = "Number of person present per day",  barmode="stack", bargap=0.3,
         legend = list(x = 100, y = 0.95, title=list(color= "blue", text='<b>Sexe</b>')),
         uniformtext=list(minsize=15, mode='show'),
         xaxis = list(title = "<b> Date </b>", #font = list(size = 0),
                      #categoryorder = "total descending",
                      # change x-axix size
                      #barmode = 'group',
                      tickfont = list(size = 14),
                      tickformat="%d-%m-%Y",
                      # change x-title size
                      titlefont = list(size = 16), #type="date", tickformat="%Y%B",  tickformat = "%b-%Y",
                      tickangle= -45, tickvals = df_present$Date),
         yaxis = list(title = "<b> Count </b>",
                      titlefont = list(size = 16),
                      #categoryorder = "total descending",
                      # change x-axix size
                      tickfont = list(size = 14))
         #tickvals = df_most_visited_service_month_year$most_visited_service)
         #hoverlabel=list(bgcolor="gainsboro")
         #width = 500, autosize=F,
         #bargap = 0.1, bargroupgap = 0.1,
  ) %>%
  config(displayModeBar = F, 
         scrollZoom = T)

fig  


# Display table with the package DT
#betterDates2 <- lubridate::dmy(clean_df_workshop$`Date de naissance`)


DT::datatable(df_workshop, 
          extensions = 'Buttons', rownames = TRUE, class = 'cell-border stripe', filter = 'top',
          caption = htmltools::tags$caption(
            style = 'caption-side: bottom; text-align: center;',
            #'Tabelle: ', htmltools::strong('Liste de candidature du Workshop du 27.09 - 29.09.2023')
          ),
          #colnames = c('Nr.' = 1, 'Ebene' = 2, 'Pflege 2019' = 3, 'Pflege 2020' = 4),
          # Change button download color
          # callback=JS('$("button.buttons-copy").css("background","red"); 
          #     $("button.buttons-collection").css("background","green"); 
          #     return table;'),
          # https://stackoverflow.com/questions/55931341/using-icons-for-shiny-renderdatatable-extension-buttons
          #
          options = list(dom = 'Bfrtip', # remove the box search on the top right side and the show entries on the top left side
                         searchHighlight = TRUE,
                         #buttons = c('csv', 'excel', 'pdf'),
                         buttons = 
                           list(list(
                             extend = "collection", 
                             buttons = list(
                               # Add a title of each format style
                               list(extend = "csv", title = "Liste de candidature du Workshop du 27.09 - 29.09.2023",
                                    exportOptions = list(
                                      modifier = list(page = "all")
                                    )),
                               list(extend = "excel", title = "Liste de candidature du Workshop du 27.09 - 29.09.2023",
                                    exportOptions = list(
                                      modifier = list(page = "all")
                                    )),
                               list(extend = "pdf", title = "Liste de candidature du Workshop du 27.09 - 29.09.2023",
                                    exportOptions = list(
                                      modifier = list(page = "all")
                                    ))),
                             #text = '<span class="glyphicon glyphicon-download-alt"></span>'
                             #text = '<span class="glyphicon glyphicon-download-alt"></span>'
                             #text =  '<i class="fa fa-download"></i>'
                              text = "Download",
                             title = NULL
                           )),
                         searching = TRUE,
                         # mark = list(accuracy = "exactly"),
                         deferRender = TRUE,
                         scrollY = 180,
                         scroller = TRUE, # remove the number of pages at the bottom with scroller = TRUE
                         # search = list(regex = FALSE, caseInsensitive = TRUE, search=''),
                         lengthMenu = list(c(5, 150, -1), c('5', '150', 'All')),
                          pageLength = nrow(df_workshop), #lengthMenu = c(10,20,30,40,50),
                         # autoWidth = FALSE,
                         # darkcyan dodgerblue
                         initComplete = JS("function(settings, json) {", "$(this.api().table().header()).css({'background-color': '#008B8B',
                                                   'color': 'white'});", "}"),
                         
                         # here center all the variables
                         columnDefs = list(list(className = 'dt-center', targets = c(0, 1, 2, 3)), 
                                           # here hide the the fourth variable
                                           list(visible=FALSE, targets=0)) # end columnDefs
                         #columnDefs = list(list(visible=FALSE, targets=2))
          ) # end option list
)


# Count number of person per gender

df_gender <- clean_df_workshop %>% 
  filter(Presence == "present",
         Date == "2023-09-27") %>%
  group_by(Sexe) %>%
  count(Sexe)

fig_piechart <- plotly::plot_ly(df_gender)%>%
  add_pie(df_gender,labels=~factor(Sexe),values=~n,
          text = ~n,
          #text = n,
          #labels=~factor(Sexe),
          marker = list(colors = c('#6B8E23', '#1F77B4')),
          #textinfo="label+percent",
          type='pie',hole=0.6,
          hovertext = paste("Gender :",df_gender$Sexe,
                            #"<br>Sexe :", df_gender$n,
                            "<br> Number of person :", df_gender$n),
          hoverinfo = 'text')%>%
  layout(title = "",
         legend = list(x = 100, y = 0.95, title=list(text='<b>Gender</b>'))) %>%
  config(displayModeBar = T, displaylogo = FALSE, modeBarButtonsToRemove = list(
    'sendDataToCloud',
    #'toImage',
    #'autoScale2d',
    'toggleSpikelines',
    'resetScale2d',
    'lasso2d',
    'zoom2d',
    'pan2d',
    'select2d'#,
    #'hoverClosestCartesian'#,
    #'hoverCompareCartesian'
  ),
  scrollZoom = T)
         
fig_piechart


# replace NA with Unknown in subjects column 
df_age <- clean_df_workshop %>%
  mutate(age_char = as.character(clean_df_workshop$Age) %>% replace_na('Unknown'))

# count number of participants by gender
df_age <- df_age %>%
  filter(Presence == "present",
         Date == "2023-09-27") %>%
  group_by(age_char, Sexe) %>%
  count(age_char)

  
  fig_age <- plotly::plot_ly(df_age, x = ~ n, y = ~ age_char, color = ~Sexe, type = "bar",
                  orientation = 'h',
                  # https://stackoverflow.com/questions/67520000/rotate-text-ange-in-plotly-bar-chart
                  # rotate label
                  textangle = 360,
                  colors = c("#c27ba0", "#7B68EE"),
                  #colors = c("#556B2F", "#7B68EE"),
                  text = df_age$n, textposition = "auto", textfont = list(color = 'white'),
                  hovertext = paste("Gender :",df_age$Sexe,
                                    "<br>Age :", df_age$age_char,
                                    "<br> Number :", df_age$n),
                  hoverinfo = 'text')%>%
    layout(title = "",  #bargap=0.3,  #barmode="stack",
           legend = list(x = 100, y = 0.95, title=list(color= "blue", text='<b>Gender</b>')),
           uniformtext=list(minsize=15, mode='show'),
           xaxis = list(title = "<b> Number </b>", #font = list(size = 0),
                        #categoryorder = "total descending",
                        # change x-axix size
                        tickfont = list(size = 14),
                        #tickformat="%d-%m-%Y",
                        # change x-title size
                        titlefont = list(size = 16) #type="date", tickformat="%Y%B",  tickformat = "%b-%Y",
                        ),
           yaxis = list(title = "<b> Age </b>",
                        titlefont = list(size = 16),
                        #categoryorder = "total descending",
                        # change x-axix size
                        tickfont = list(size = 14)),
           margin = list(pad = 1)
           #margin = list(l = 150, r = 20, b = 10, t = 10, pad = 0)
           #tickvals = df_most_visited_service_month_year$most_visited_service)
           #hoverlabel=list(bgcolor="gainsboro")
           #width = 500, autosize=F,
           #bargap = 0.1, bargroupgap = 0.1,
    )%>%
    config(displayModeBar = T, displaylogo = FALSE, modeBarButtonsToRemove = list(
      'sendDataToCloud',
      #'toImage',
      #'autoScale2d',
      'toggleSpikelines',
      'resetScale2d',
      'lasso2d',
      'zoom2d',
      'pan2d',
      'select2d'#,
      #'hoverClosestCartesian'#,
      #'hoverCompareCartesian'
    ),
    scrollZoom = T)
  fig_age
  
  fig_age <- plotly::plot_ly(df_age, x = ~ n, y = ~ age_char, color = ~Sexe, type = "bar",
                             orientation = 'h',
                             # rotate label
                             textangle = 360,
                             #colors = c("#c27ba0", "#7B68EE"),
                             colors = c("darkblue", "darkgreen"),
                             text = df_age$n, textposition = "auto", textfont = list(color = 'white'),
                             hovertext = paste("Gender :",df_age$Sexe,
                                               "<br>Age :", df_age$age_char,
                                               "<br> Number of person :", df_age$n),
                             hoverinfo = 'text')%>%
    layout(title = "",  #bargap=0.3,  #barmode="stack",
           legend = list(x = 100, y = 0.95, title=list(color= "blue", text='<b>Gender</b>')),
           uniformtext=list(minsize=15, mode='show'),
           xaxis = list(title = "<b> Number of person </b>", #font = list(size = 0),
                        #categoryorder = "total descending",
                        # change x-axix size
                        tickfont = list(size = 14),
                        #tickformat="%d-%m-%Y",
                        # change x-title size
                        titlefont = list(size = 16) #type="date", tickformat="%Y%B",  tickformat = "%b-%Y",
           ),
           yaxis = list(title = "<b> Age </b>",
                        titlefont = list(size = 16),
                        #categoryorder = "total descending",
                        # change x-axix size
                        tickfont = list(size = 14)),
           margin = list(pad = 1)
           #margin = list(l = 150, r = 20, b = 10, t = 10, pad = 0)
           #tickvals = df_most_visited_service_month_year$most_visited_service)
           #hoverlabel=list(bgcolor="gainsboro")
           #width = 500, autosize=F,
           #bargap = 0.1, bargroupgap = 0.1,
    )%>%
    config(displayModeBar = T, displaylogo = FALSE, modeBarButtonsToRemove = list(
      'sendDataToCloud',
      #'toImage',
      #'autoScale2d',
      'toggleSpikelines',
      'resetScale2d',
      'lasso2d',
      'zoom2d',
      'pan2d',
      'select2d'#,
      #'hoverClosestCartesian'#,
      #'hoverCompareCartesian'
    ),
    scrollZoom = T)
  
  return(fig_age)
  
  ## Categorize age
  
  df_age <- df_age %>%
    filter(Presence == "present",
           Date == "2023-09-27") %>%
    group_by(age_char, Sexe) %>%
    count(age_char)
  
# https://rpubs.com/artyom/numintocat  
  library(Hmisc)
  
  df_group_age_female <- clean_df_workshop %>%
    filter(Date == "2023-09-27",
           Sexe == "F") 
  
  age_female <- df_group_age_female$Age
  summary(age_female)
  table(age_female, useNA = 'ifany')
  
  age_female_cat <- cut2(age_female, c(20, 25, 30, 35, 40))
  summary(age_female_cat)
  
  group_age_female <- as.character(c("[20,25)", "[25,30)", "[30,35)", "[35,40]", "Unknown"))
  age_female <- as.numeric(c(3, 2, 1, 0, 6))
  sexe_female <- rep("F", 5) 
   
   #create data frame with 0 rows and 5 columns
   df_age_female <- data.frame(matrix(ncol = 3, nrow = length(group_age_female)))
   
   #provide column names
   colnames(df_age_female) <- c("group_age", "Age", "Sexe")
   
   df_age_female$group_age <- group_age_female
   df_age_female$Age <- age_female
   df_age_female$Sexe <- sexe_female
  
  df_group_age_male <- clean_df_workshop %>%
    filter(Date == "2023-09-27",
           Sexe == "M") 
  
  age_male <- df_group_age_male$Age
  summary(age_male)
  table(age_male, useNA = 'ifany')
  
  age_male_cat <- cut2(age_male, c(20, 25, 30, 35, 40))
  summary(age_male_cat)
  
  group_age_male <- as.character(c("[20,25)", "[25,30)", "[30,35)", "[35,40]", "Unknown"))
  age_male <- as.numeric(c(3, 3, 4, 3, 9))
  sexe_male <- rep("M", 5) 
  
  #create data frame with 0 rows and 5 columns
  df_age_male <- data.frame(matrix(ncol = 3, nrow = length(group_age_male)))
  
  #provide column names
  colnames(df_age_male) <- c("group_age", "Age", "Sexe")
  
  df_age_male$group_age <- group_age_male
  df_age_male$Age <- age_male
  df_age_male$Sexe <- sexe_male
  
  # combine two data frames
  test <- rbind(df_age_female, df_age_male)
  #write.csv(test, "C:\\Users\\Gleyne Monthe\\Desktop\\git_test\\DataDrivenWorkshop\\R\\Data\\df_age_group_gender.csv", 
            #row.names=FALSE)
  
  fig_age_group_sexe <- plotly::plot_ly(df_age_group_gender, x = ~ Age , y = ~ group_age, color = ~Sexe, type = "bar",
                             orientation = 'h',
                             # rotate label
                             textangle = 360,
                             #colors = c("#c27ba0", "#7B68EE"),
                             colors = c("darkblue", "darkgreen"),
                             text = df_age_group_gender$Age , textposition = "auto", textfont = list(color = 'white'),
                             hovertext = paste("Gender :",df_age_group_gender$Sexe,
                                               "<br>Group age :", df_age_group_gender$group_age,
                                               "<br> Number of person :", df_age_group_gender$Age),
                             hoverinfo = 'text')%>%
    layout(title = "",  #bargap=0.3,  #barmode="stack",
           legend = list(x = 100, y = 0.95, title=list(color= "blue", text='<b>Gender</b>')),
           uniformtext=list(minsize=15, mode='show'),
           xaxis = list(title = "<b> Number of person </b>", #font = list(size = 0),
                        #categoryorder = "total descending",
                        # change x-axix size
                        tickfont = list(size = 14),
                        #tickformat="%d-%m-%Y",
                        # change x-title size
                        titlefont = list(size = 16) #type="date", tickformat="%Y%B",  tickformat = "%b-%Y",
           ),
           yaxis = list(title = "<b> Group age </b>",
                        titlefont = list(size = 16),
                        #categoryorder = "total descending",
                        # change x-axix size
                        tickfont = list(size = 14)),
           margin = list(pad = 1)
           #margin = list(l = 150, r = 20, b = 10, t = 10, pad = 0)
           #tickvals = df_most_visited_service_month_year$most_visited_service)
           #hoverlabel=list(bgcolor="gainsboro")
           #width = 500, autosize=F,
           #bargap = 0.1, bargroupgap = 0.1,
    )%>%
    config(displayModeBar = T, displaylogo = FALSE, modeBarButtonsToRemove = list(
      'sendDataToCloud',
      #'toImage',
      #'autoScale2d',
      'toggleSpikelines',
      'resetScale2d',
      'lasso2d',
      'zoom2d',
      'pan2d',
      'select2d'#,
      #'hoverClosestCartesian'#,
      #'hoverCompareCartesian'
    ),
    scrollZoom = T)
  
  fig_age_group_sexe
  
  
  
  ###############
  
  #create data frame with 0 rows and 5 columns
  df <- data.frame(matrix(ncol = 2, nrow = length(group_age)))
  
  #provide column names
  colnames(df) <- c("group_age", "age")
  
  df$group_age <- group_age
  df$age <- age
  
  
  
  df <- cbind(group_age, age)
  df1 <- as.data.frame(group_age, age)
  
  levels(ageee_cat) <- as.character(c("[20,25)", "[25,30)", "[30,35)", "[35,40]", "No available"))
  
  test <- ageee_cat
  
  str(test)
  
  df <- rbind(ageee_cat, ageee)
  df1 <- as.data.frame(df)
  
  
  
  set.seed(10)
  age_num <- sample(c(18:100), 1000, replace = TRUE) 
  summary(age_num)
  
  age_cat <- cut2(age_num, c(45, 60, 75, 90))
  summary(age_cat)
  
  
  
  
  #Change the column name - `Domaine d'étude` to Domaine_detude
  df_etude <- clean_df_workshop %>% 
    rename("Domaine_detude" = `Domaine d'étude`)
  #table(df_etude$Domaine_detude,useNA = 'ifany')
  
  #replace missing values with 'Unknown' in Domaine_detude column
  df_etude$Domaine_detude <- df_etude$Domaine_detude %>% replace_na('Unknown')
  
  # count number of participants by gender
  df_etude <- df_etude %>%
    filter(#Presence == "present",
           Date == "2023-09-27") %>%
    group_by(Domaine_detude) %>%
    count(Domaine_detude)
  
  #table(df_etude$Domaine_detude,useNA = 'ifany')
  
  fig_etude <- plotly::plot_ly(df_etude, x = ~ n, y = ~ Domaine_detude, type = "bar",
                             orientation = 'h',
                             # https://stackoverflow.com/questions/67520000/rotate-text-ange-in-plotly-bar-chart
                             # rotate label
                             textangle = 360,
                             marker = list(color = "#9370DB"),
                             #colors = c("#c27ba0", "#7B68EE"),
                             #colors = c("#556B2F", "#7B68EE"),
                             text = df_etude$n, textposition = "auto", textfont = list(color = 'white'),
                             hovertext = paste("Study :",df_etude$Domaine_detude,
                                               #"<br>Age :", df_age$age_char,
                                               "<br> Number of persone :", df_etude$n),
                             hoverinfo = 'text')%>%
    layout(title = "Number of participants per field of study",  #bargap=0.3,  #barmode="stack",
           #legend = list(x = 100, y = 0.95, title=list(color= "blue", text='<b>Gender</b>')),
           uniformtext=list(minsize=15, mode='show'),
           xaxis = list(title = "<b> Number of person </b>", #font = list(size = 0),
                        #categoryorder = "total descending",
                        # change x-axix size
                        tickfont = list(size = 14),
                        #tickformat="%d-%m-%Y",
                        # change x-title size
                        titlefont = list(size = 16) #type="date", tickformat="%Y%B",  tickformat = "%b-%Y",
           ),
           yaxis = list(title = "<b> Field of study </b>",
                        titlefont = list(size = 16),
                        #categoryorder = "total descending",
                        # change x-axix size
                        tickfont = list(size = 14)),
           margin = list(pad = 1)
           #margin = list(l = 150, r = 20, b = 10, t = 10, pad = 0)
           #tickvals = df_most_visited_service_month_year$most_visited_service)
           #hoverlabel=list(bgcolor="gainsboro")
           #width = 500, autosize=F,
           #bargap = 0.1, bargroupgap = 0.1,
    )%>%
    config(displayModeBar = T, displaylogo = FALSE, modeBarButtonsToRemove = list(
      'sendDataToCloud',
      #'toImage',
      #'autoScale2d',
      'toggleSpikelines',
      'resetScale2d',
      'lasso2d',
      'zoom2d',
      'pan2d',
      'select2d'#,
      #'hoverClosestCartesian'#,
      #'hoverCompareCartesian'
    ),
    scrollZoom = T)
  fig_etude
  
  #replace missing values with 'Unknown' in `Institut de provenance` column
  clean_df_workshop$`Institut de provenance` <- clean_df_workshop$`Institut de provenance` %>% replace_na('Unknown')
  #table(clean_df_workshop$`Institut de provenance`,useNA = 'ifany')
  
  # count number of participants by gender
  df_institut <- clean_df_workshop %>%
    filter(#Presence == "present",
      Date == "2023-09-27") %>%
    group_by(`Institut de provenance`) %>%
    count(`Institut de provenance`)
  
  fig_institut <- plotly::plot_ly(df_institut, x = ~ n, y = ~ `Institut de provenance`, type = "bar",
                               orientation = 'h',
                               # https://stackoverflow.com/questions/67520000/rotate-text-ange-in-plotly-bar-chart
                               # rotate label
                               textangle = 360,
                               marker = list(color = "#008000"),
                               #colors = c("#7B68EE"),
                               #colors = c("#556B2F", "#7B68EE"),
                               text = df_institut$n, textposition = "auto", textfont = list(color = 'white'),
                               hovertext = paste("University :",df_institut$`Institut de provenance`,
                                                 #"<br>Age :", df_age$age_char,
                                                 "<br> Number of persone :", df_institut$n),
                               hoverinfo = 'text')%>%
    layout(title = "",  #bargap=0.3,  #barmode="stack",
           #legend = list(x = 100, y = 0.95, title=list(color= "blue", text='<b>Gender</b>')),
           uniformtext=list(minsize=15, mode='show'),
           xaxis = list(title = "<b> Number of person </b>", #font = list(size = 0),
                        #categoryorder = "total descending",
                        # change x-axix size
                        tickfont = list(size = 14),
                        #tickformat="%d-%m-%Y",
                        # change x-title size
                        titlefont = list(size = 16) #type="date", tickformat="%Y%B",  tickformat = "%b-%Y",
           ),
           yaxis = list(title = "<b> University </b>",
                        titlefont = list(size = 16),
                        #categoryorder = "total descending",
                        # change x-axix size
                        tickfont = list(size = 14)),
           margin = list(pad = 1)
           #margin = list(l = 150, r = 20, b = 10, t = 10, pad = 0)
           #tickvals = df_most_visited_service_month_year$most_visited_service)
           #hoverlabel=list(bgcolor="gainsboro")
           #width = 500, autosize=F,
           #bargap = 0.1, bargroupgap = 0.1,
    )%>%
    config(displayModeBar = T, displaylogo = FALSE, modeBarButtonsToRemove = list(
      'sendDataToCloud',
      #'toImage',
      #'autoScale2d',
      'toggleSpikelines',
      'resetScale2d',
      'lasso2d',
      'zoom2d',
      'pan2d',
      'select2d'#,
      #'hoverClosestCartesian'#,
      #'hoverCompareCartesian'
    ),
    scrollZoom = T)
  fig_institut
  
 
  
   
  library(stringr)
  df_workshop_expectations <- df_workshop_expectations %>% 
    mutate(Noms = str_to_title(gsub(",", " ", Noms)))
  
  DT::datatable(df_workshop_expectations, 
                extensions = 'Buttons', rownames = TRUE, class = 'cell-border stripe', filter = 'top',
                caption = htmltools::tags$caption(
                  style = 'caption-side: bottom; text-align: center;',
                  #'Tabelle: ', htmltools::strong('Liste de candidature du Workshop du 27.09 - 29.09.2023')
                ),
                #colnames = c('Nr.' = 1, 'Ebene' = 2, 'Pflege 2019' = 3, 'Pflege 2020' = 4),
                # Change button download color
                # callback=JS('$("button.buttons-copy").css("background","red"); 
                #     $("button.buttons-collection").css("background","green"); 
                #     return table;'),
                # https://stackoverflow.com/questions/55931341/using-icons-for-shiny-renderdatatable-extension-buttons
                #
                options = list(dom = 'Bfrtip', # remove the box search on the top right side and the show entries on the top left side
                               searchHighlight = TRUE,
                               #buttons = c('csv', 'excel', 'pdf'),
                               buttons = 
                                 list(list(
                                   extend = "collection", 
                                   buttons = list(
                                     # Add a title of each format style
                                     list(extend = "csv", title = "Liste de candidature du Workshop du 27.09 - 29.09.2023",
                                          exportOptions = list(
                                            modifier = list(page = "all")
                                          )),
                                     list(extend = "excel", title = "Liste de candidature du Workshop du 27.09 - 29.09.2023",
                                          exportOptions = list(
                                            modifier = list(page = "all")
                                          )),
                                     list(extend = "pdf", title = "Liste de candidature du Workshop du 27.09 - 29.09.2023",
                                          exportOptions = list(
                                            modifier = list(page = "all")
                                          ))),
                                   #text = '<span class="glyphicon glyphicon-download-alt"></span>'
                                   #text = '<span class="glyphicon glyphicon-download-alt"></span>'
                                   #text =  '<i class="fa fa-download"></i>'
                                   text = "Download",
                                   title = NULL
                                 )),
                               searching = TRUE,
                               # mark = list(accuracy = "exactly"),
                               deferRender = TRUE,
                               scrollY = 50,
                               scroller = TRUE, # remove the number of pages at the bottom with scroller = TRUE
                               # search = list(regex = FALSE, caseInsensitive = TRUE, search=''),
                               lengthMenu = list(c(5, 150, -1), c('5', '150', 'All')),
                               pageLength = nrow(df_workshop), #lengthMenu = c(10,20,30,40,50),
                               # autoWidth = FALSE,
                               # darkcyan dodgerblue
                               initComplete = JS("function(settings, json) {", "$(this.api().table().header()).css({'background-color': '#008B8B',
                                                   'color': 'white'});", "}"),
                               
                               # here center all the variables
                               columnDefs = list(list(className = 'dt-center', targets = c(0, 1, 2, 3)), 
                                                 # here hide the the fourth variable
                                                 list(visible=FALSE, targets=0)) # end columnDefs
                               #columnDefs = list(list(visible=FALSE, targets=2))
                ) # end option list
  )
  
  
  
  
#######################################
df %>%
  mutate(name = factor(name, levels = c("SF_Zoo", "LA_Zoo", "DC_Zoo"))) %>%
  plotly::plot_ly(df_age1, x = ~ Animals, y = ~ value, color = ~name, type = "bar",
                  text = df$value, textposition = "auto", textfont = list(color = 'rgb(0,0,0)'))


df_age1 %>%
  plot_ly(
    x = ~Sexe,
    y = ~n,
    type = "bar",
    group = ~age_char
  )

unique(test)
#################################################################

df_presence_position <- clean_df_workshop %>%
  group_by(Date, Sexe, `Domaine d'étude`) %>%
  dplyr::count(Presence)



df_sexe_M <- df_workshop %>%
  filter(Sexe == "M")

df_workshop$Date <- as.Date(gsub(" ", "", df_workshop$Date))

df_mercredi <- df_workshop %>%
  filter(Date == " 2023-09-27")

table(df_mercredi$Presence,useNA = 'ifany')

table(df_mercredi$Sexe,useNA = 'ifany')

  df_workshop$Presence

