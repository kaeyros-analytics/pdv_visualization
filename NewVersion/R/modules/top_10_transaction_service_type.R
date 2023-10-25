
top_service_type_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(plotly::plotlyOutput(outputId = ns("top_service_type"), height = "500px"),
                               type = 8, color = 'grey')
} # end top_service_type_ui

top_service_type_server <- function(input, output, session) {
  
  output$top_service_type <- renderPlotly({
    
    #fig_age <- plotly::plot_ly(df_age, x = ~ age_char, y = ~ n, color = ~Sexe, type = "bar",
                               #text = df_age$n, textposition = "auto", textfont = list(color = 'rgb(0,0,0)'))
    
    fig_age_group_sexe <- plotly::plot_ly(df_age_group_gender, x = ~ Age , y = ~ group_age, color = ~Sexe, type = "bar",
                                          orientation = 'h',
                                          # rotate label
                                          textangle = 360,
                                          #colors = c("#c27ba0", "#7B68EE"),
                                          colors = c("darkgreen", "darkblue"),
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
                          standoff = 100L,
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
    
    return(fig_age_group_sexe)
    
    
  }) # end output$top_service_type
  
} # end top_service_type_server