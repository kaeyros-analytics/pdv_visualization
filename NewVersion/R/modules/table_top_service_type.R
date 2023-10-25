
table_trans_service_type_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(plotly::plotlyOutput(ns('agent_table'), height = "523px"), type = 8, color = 'grey')
} # end table_trans_service_type_ui


table_trans_service_type_server <- function(input, output, session) {
  
  output$service_type_table <- renderPlotly({
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
              marker = list(colors = c('darkgreen', 'darkblue')),
              #marker = list(colors = c('#6B8E23', '#1F77B4')),
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
    
    return(fig_piechart)
  }) #end output$service_type_table
  
} # end table_trans_service_type_server