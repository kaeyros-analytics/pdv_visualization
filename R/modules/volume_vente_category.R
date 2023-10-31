

volume_vente_category_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(plotly::plotlyOutput(outputId = ns("vente_category"), height = "500px"),
                               type = 8, color = 'grey')
} # end trans_service_title_ui


volume_vente_category_server <- function(input, output, session) {
  
  output$vente_category <- renderPlotly({

    
    #table(df_bavaria1$PdvCategory, useNA = "ifany")
    
    if(input$pdvcountry2 == "All"){
      df_bavaria_category <- df_bavaria1 %>% 
        #filter(PdvCountry == "Cameroun") %>% 
        #filter(Date >= '2021-01-01' & Date <= '2023-07-28') %>% 
        filter(Date >= input$daterange2[1] & Date <= input$daterange2[2]) %>% 
        group_by(PdvCategory) %>% 
        summarise(sum_SalesAmount = sum(SalesAmount))
      
    } else{
      df_bavaria_category <- df_bavaria1 %>% 
        filter(PdvCountry == input$pdvcountry2) %>% 
                 #filter(Date >= '2021-01-01' & Date <= '2023-07-28') %>% 
                 filter(Date >= input$daterange2[1] & Date <= input$daterange2[2]) %>% 
                 group_by(PdvCategory) %>% 
                 summarise(sum_SalesAmount = sum(SalesAmount))
    }
    
    internal_fig_billers <- plotly::plot_ly(df_bavaria_category, x =~PdvCategory, y =~sum_SalesAmount, type = 'bar',
                                            #mode = "text", 
                                            #textangle = 360, extposition = 'outside'
                                            text = ~paste(formatC(sum_SalesAmount, format = "d",big.mark = "."),"€"), textposition = 'outside',
                                            #textfont = list(size = 5),
                                            hovertext = paste("Date :", df_bavaria_category$PdvCategory,
                                                              "<br>Volume des ventes :", paste(formatC(df_bavaria_category$sum_SalesAmount, format = "d",big.mark = "."), "€")),
                                            hoverinfo = 'text',
                                            marker = list(color = "darkviolet",
                                                          line = list(color = "white",  width = 1.5))) %>%
      layout(title = "",
             uniformtext=list(minsize=12, mode='show'),
             xaxis = list(title = "<b> PDV Category </b>", #font = list(size = 0),
                          # change x-axix size
                          tickfont = list(size = 14),
                          # change x-title size
                          titlefont = list(size = 16),
                          #type="date", tickformat= "%Y-%m-%d", 
                          tickangle= -45, df_bavaria_category$PdvCategory),
             yaxis = list(title = "<b> Volume de vente </b>",
                          titlefont = list(size = 16),
                          # change x-axix size
                          tickfont = list(size = 14))
             # tickvals = internal_number_of_billers$mav_number_billers)
             #hoverlabel=list(bgcolor="gainsboro")
             #width = 500, autosize=F,
             #bargap = 0.1, bargroupgap = 0.1,
      ) %>%
      config(displayModeBar = F, 
             scrollZoom = T)
    
    return(internal_fig_billers)
    
  }) # end output$plot_title
  
}