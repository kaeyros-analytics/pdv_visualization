
top10_vente_category_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(DT::dataTableOutput(outputId = ns("top10_category"), height = "500px"),
                               type = 8, color = 'grey')
} # end trans_service_type_ui

top10_vente_category_server <- function(input, output, session) {
  
  output$top10_category <- DT::renderDataTable({
    # top_ten_owner <- df_bavaria1 %>%
    #   #filter(Date >= '2021-01-01' & Date <= '2023-07-28') %>% 
    #   filter(Date >= input$daterange2[1] & Date <= input$daterange2[2]) %>% 
    #   group_by(OwnerName, PdvCity, PdvCategory) %>%
    #   summarise(sum_SalesAmount = sum(SalesAmount)) %>%
    #   mutate(SalesAmount1 = paste(formatC(sum_SalesAmount, format = "d",big.mark = "."), "€")) %>%
    #   arrange(desc(sum_SalesAmount))
    
    
    if(input$pdvcity2 == "All"){
      top_ten_owner <- df_bavaria1 %>%
        #filter(Date >= '2021-01-01' & Date <= '2023-07-28') %>% 
        filter(Date >= input$daterange2[1] & Date <= input$daterange2[2]) %>% 
        group_by(OwnerName, PdvCity, PdvCategory) %>%
        summarise(sum_SalesAmount = sum(SalesAmount)) %>%
        mutate(SalesAmount1 = paste(formatC(sum_SalesAmount, format = "d",big.mark = "."), "€")) %>%
        arrange(desc(sum_SalesAmount))
      
    } else{
      top_ten_owner <- df_bavaria1 %>%
        #filter(Date >= '2021-01-01' & Date <= '2023-07-28') %>% 
        filter(Date >= input$daterange2[1] & Date <= input$daterange2[2]) %>% 
        filter(PdvCity == input$pdvcity2) %>% 
        group_by(OwnerName, PdvCity, PdvCategory) %>%
        summarise(sum_SalesAmount = sum(SalesAmount)) %>%
        mutate(SalesAmount1 = paste(formatC(sum_SalesAmount, format = "d",big.mark = "."), "€")) %>%
        arrange(desc(sum_SalesAmount))
    }
    
    top_ten_owner1 <- head(top_ten_owner, 10)
    
    
    DT::datatable(top_ten_owner1, 
                  extensions = 'Buttons', rownames = TRUE, class = 'cell-border stripe', filter = 'top',
                  colnames = c('Nr.' = 1, 'Propriétaire' = 2, 'Ville' = 3, 'Pvd Category' = 4, 'Transaction volume' = 6),
                  caption = htmltools::tags$caption(
                    style = 'caption-side: bottom; text-align: center;',
                    'Tabelle: ', htmltools::strong('Top 10 des meilleurs ventes par categprie')
                  ),
                  #colnames = c('Nr.' = 1, 'Ebene' = 2, 'Pflege 2019' = 3, 'Pflege 2020' = 4),
                  # Change button download color
                  # callback=JS('$("button.buttons-copy").css("background","red"); 
                  #     $("button.buttons-collection").css("background","green"); 
                  #     return table;'),
                  # https://stackoverflow.com/questions/55931341/using-icons-for-shiny-renderdatatable-extension-buttons
                  #
                  options = list(dom = 'Brtip', # remove the box search on the top right side and the show entries on the top left side
                                 #searchHighlight = TRUE,
                                 #buttons = c('csv', 'excel', 'pdf'),
                                 buttons = 
                                   list(list(
                                     extend = "collection", 
                                     buttons = list(
                                       # Add a title of each format style
                                       list(extend = "excel", title = "",
                                            exportOptions = list(
                                              modifier = list(page = "all")
                                            ))),
                                     #text = '<span class="glyphicon glyphicon-download-alt"></span>'
                                     #text = '<span class="glyphicon glyphicon-download-alt"></span>'
                                     #text =  '<i class="fa fa-download"></i>'
                                     text = "Download"
                                   )),
                                 searching = TRUE,
                                 # mark = list(accuracy = "exactly"),
                                 #deferRender = TRUE,
                                 scrollY = 420,
                                 #scroller = TRUE, # remove the number of pages at the bottom with scroller = TRUE
                                 # search = list(regex = FALSE, caseInsensitive = TRUE, search=''),
                                 # #lengthMenu = list(c(5, 150, -1), c('5', '150', 'All')),
                                 #pageLength = nrow(top_ten_owner1), #lengthMenu = c(10,20,30,40,50),
                                 # autoWidth = FALSE,
                                 # darkcyan dodgerblue
                                 initComplete = JS("function(settings, json) {", "$(this.api().table().header()).css({'background-color': '#4682B4',
                                                   'color': '#fff'});", "}"),
                                 
                                 # here center all the variables
                                 columnDefs = list(list(className = 'dt-center', targets = c(0, 1, 2, 3, 5)), 
                                                   # here hide the the fourth variable
                                                   list(visible=FALSE, targets=4)) # end columnDefs
                                 #columnDefs = list(list(visible=FALSE, targets=2))
                  ) # end option list
    )
    
  }) # end output$plot_type
  
} # end trans_service_type_server