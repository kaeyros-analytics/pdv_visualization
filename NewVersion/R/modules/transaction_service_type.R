
trans_service_type_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(plotly::plotlyOutput(outputId = ns("plot_type"), height = "500px"),
                               type = 8, color = 'grey')
} # end trans_service_type_ui

trans_service_type_server <- function(input, output, session) {
  
  output$plot_type <- renderPlotly({
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
                                    marker = list(color = "darkgreen"),
                                    #colors = c("#7B68EE"),
                                    #colors = c("#556B2F", "#7B68EE"),
                                    # rotate label
                                    textangle = 360,
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
                          #autorange="reversed", 
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
    
    return(fig_institut)
    
    
  }) # end output$plot_type
  
} # end trans_service_type_server