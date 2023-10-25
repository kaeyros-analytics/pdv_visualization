
trans_service_title_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(plotly::plotlyOutput(outputId = ns("plot_title"), height = "500px"),
                               type = 8, color = 'grey')
} # end trans_service_title_ui


trans_service_title_server <- function(input, output, session) {
  
  output$plot_title <- renderPlotly({
    
    
    #replace missing values with 'Unknown' in Domaine_detude column
    df_etude$Domaine_detude <- df_etude$Domaine_detude %>% replace_na('Unknown')
    
    # count number of participants by gender
    df_etude <- df_etude %>%
      filter(#Presence == "present",
        Date == "2023-09-27") %>%
      group_by(Domaine_detude) %>%
      count(Domaine_detude)
    
    fig_etude <- plotly::plot_ly(df_etude, x = ~ n, y = ~ Domaine_detude, type = "bar",
                                 orientation = 'h',
                                 # rotate label
                                 textangle = 360,
                                 marker = list(color = "darkblue"),
                                 #marker = list(color = "#483D8B"),
                                 #colors = c("#c27ba0", "#7B68EE"),
                                 #colors = c("#556B2F", "#7B68EE"),
                                 text = df_etude$n, textposition = "auto", textfont = list(color = 'white'),
                                 hovertext = paste("Sector :",df_etude$Domaine_detude,
                                                   #"<br>Age :", df_age$age_char,
                                                   "<br> Number of persone :", df_etude$n),
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
             yaxis = list(title = "<b> Sector </b>",
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
    
    return(fig_etude)
    
  }) # end output$plot_title
  
}