

volume_vente_pays_type_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(plotly::plotlyOutput(ns('volume_vente_pays'), height = "523px"), type = 8, color = 'grey')
} # end table_trans_service_type_ui


volume_vente_pays_server <- function(input, output, session) {
  
  output$volume_vente_pays <- renderPlotly({
    # Count number of person per gender
    if(input$pdvcountry == "All"){ df_bavaria_test2 <- df_bavaria1 %>% 
      #filter(between(Date, as.Date('2022-01-20'), as.Date('2022-02-20'))) %>% 
      filter(Date >= input$daterange1[1] & Date <= input$daterange1[2]) %>% 
      group_by(PdvCountry, Date) %>% 
      summarise(sum_SalesAmount = sum(SalesAmount))
    } else{
      f_bavaria_test2 <- df_bavaria1 %>%
        #filter(between(Date, as.Date('2022-01-20'), as.Date('2022-02-20'))) %>%
        filter(Date >= input$daterange1[1] & Date <= input$daterange1[2]) %>%
        filter(PdvCountry == input$pdvcountry) %>%
        group_by(PdvCountry, Date) %>%
        summarise(sum_SalesAmount = sum(SalesAmount))
      
    }
    
    #df_bavaria_test2 <- as.data.frame(df_bavaria_test2)
    
    #col <- c('#6A5ACD','#3CB371')
    fig_presence <- plot_ly(df_bavaria_test2, x = ~Date, y = ~sum_SalesAmount, type = 'scatter', 
                            mode = 'lines+markers', linetype = ~PdvCountry,
                            #line=list(color=col), marker=list(color=col), 
                            hovertext = paste("Date :",df_bavaria_test2$Date,
                                              "<br>Pays :", df_bavaria_test2$PdvCountry,
                                              "<br> Volume des ventes :", paste(formatC(df_bavaria_test2$sum_SalesAmount, format = "d",big.mark = "."), "€")),
                            hoverinfo = 'text') %>%
      layout(title = "",  barmode="stack", bargap=0.3,
             legend = list(x = 100, y = 0.95, title=list(color= "blue", text='<b>Pays</b>')),
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
    
    
    return(fig_presence)
  }) #end output$service_type_table
  
} # end table_trans_service_type_server