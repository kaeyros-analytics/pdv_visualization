
No_trans_ui <- function(id) {
  
  ns <- NS(id)
  shinycssloaders::withSpinner(plotly::plotlyOutput(outputId = ns("plotTransaction"), height = "500px"),
                               type = 8, color = 'grey')
} # end nbre_trans_ui

No_trans_server <- function(input, output, session) {
  
  output$plotTransaction <- renderPlotly({
    
    fig_presence <- plot_ly(df_presence, x = ~Date, y = ~n, type = 'scatter', mode = 'lines+markers', linetype = ~Sexe,
                   hovertext = paste("Date :",df_presence$Date,
                                     "<br>Sexe :", df_presence$Sexe,
                                     "<br> Number of person :", df_presence$n),
                   hoverinfo = 'text') %>%
      layout(title = "",  barmode="stack", bargap=0.3,
             legend = list(x = 100, y = 0.95, title=list(color= "blue", text='<b>Gender</b>')),
             uniformtext=list(minsize=15, mode='show'),
             xaxis = list(title = "<b> Date </b>", #font = list(size = 0),
                          #categoryorder = "total descending",
                          # change x-axix size
                          #barmode = 'group',
                          tickfont = list(size = 14),
                          tickformat="%d-%m-%Y",
                          # change x-title size
                          titlefont = list(size = 16), #type="date", tickformat="%Y%B",  tickformat = "%b-%Y",
                          tickangle= -45, tickvals = df_presence$Date),
             yaxis = list(title = "<b> Number of person </b>",
                          titlefont = list(size = 16),
                          #categoryorder = "total descending",
                          # change x-axix size
                          tickfont = list(size = 14))
             #tickvals = df_most_visited_service_month_year$most_visited_service)
             #hoverlabel=list(bgcolor="gainsboro")
             #width = 500, autosize=F,
             #bargap = 0.1, bargroupgap = 0.1,
      ) %>%
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
    
    return(fig_presence)
    
    
  }) # end output$revenueTime
  
  
} # end nbre_trans_server
