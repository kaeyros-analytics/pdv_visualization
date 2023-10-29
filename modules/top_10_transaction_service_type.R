
top_service_type_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(plotly::plotlyOutput(outputId = ns("top_service_type"), height = "500px"),
                               type = 8, color = 'grey')
} # end top_service_type_ui

top_service_type_server <- function(input, output, session) {
  
  output$top_service_type <- renderPlotly({
    
    df_bavaria_test2 <- df_bavaria1 %>% 
      #filter(between(Date, as.Date('2022-01-20'), as.Date('2022-02-20'))) %>% 
      filter(Date >= '2022-05-01' & Date <= '2023-07-28') %>% 
      group_by(PdvCity, Date) %>% 
      summarise(sum_SalesAmount = sum(SalesAmount))
    
    
    fig_presence2 <- plot_ly(df_bavaria_test2, x = ~Date, y = ~sum_SalesAmount, type = 'scatter', mode = 'lines+markers',
                            linetype = ~PdvCity,
                            hovertext = paste("Date :",df_bavaria_test2$Date,
                                              "<br>Pays :", df_bavaria_test2$PdvCity,
                                              "<br> Volume des ventes :", paste(formatC(df_bavaria_test2$sum_SalesAmount, format = "d",big.mark = "."), "€")),
                            hoverinfo = 'text') %>%
      layout(title = "",  barmode="stack", bargap=0.3,
             legend = list(x = 100, y = 0.95, title=list(color= "blue", text='<b>Ville</b>')),
             uniformtext=list(minsize=15, mode='show'),
             xaxis = list(title = "<b> Date </b>", #font = list(size = 0),
                          #categoryorder = "total descending",
                          # change x-axix size
                          #barmode = 'group',
                          # adjust tick frequency' for date x-axis with tickmode and nticks 
                          tickmode = "auto", # adjust tick frequency' for date x-axis automatically
                          #nticks = 9,# give number of frequency
                          tickfont = list(size = 14),
                          tickformat="%d-%m-%Y",
                          # change x-title size
                          titlefont = list(size = 16), #type="date", tickformat="%Y%B",  tickformat = "%b-%Y",
                          tickangle= -45, tickvals = df_bavaria_test2$Date),
             yaxis = list(title = "<b> Volume des ventes </b>",
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
    
    return(fig_presence2)
    
    
  }) # end output$top_service_type
  
} # end top_service_type_server