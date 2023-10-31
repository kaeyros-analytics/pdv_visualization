
trans_service_type_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(DT::dataTableOutput(outputId = ns("plot_type"), height = "500px"),
                               type = 8, color = 'grey')
} # end trans_service_type_ui

trans_service_type_server <- function(input, output, session) {
  
  output$plot_type <- DT::renderDataTable({
    top_ten_owner <- df_bavaria1 %>%
      filter(Date >= '2021-01-01' & Date <= '2023-07-28') %>% 
      group_by(OwnerName, PdvCity, PdvCategory) %>%
      summarise(sum_SalesAmount = sum(SalesAmount)) %>%
      mutate(SalesAmount1 = paste(formatC(sum_SalesAmount, format = "d",big.mark = "."), "€")) %>%
      arrange(desc(sum_SalesAmount))
    
    top_ten_owner1 <- head(top_ten_owner, 10)
    
    
    DT::datatable(top_ten_owner1,
                  extensions = 'Scroller', rownames = TRUE, class = 'cell-border stripe', filter = 'top',
                  colnames = c('Nr.' = 1, 'Propriétaire' = 2, 'Ville' = 3, 'Pvd Category' = 4, 'Transaction volume' = 6),
                  options = list(dom = 't', # remove the box search on the top right side and the show entries on the top left side
                                 searchHighlight = TRUE,
                                 # mark = list(accuracy = "exactly"),
                                 # deferRender = TRUE,
                                 # scrollY = 195,
                                 #scroller = TRUE, # remove the number of pages at the bottom with scroller = TRUE
                                 # search = list(regex = FALSE, caseInsensitive = TRUE, search=''),
                                 # #lengthMenu = list(c(5, 150, -1), c('5', '150', 'All')),
                                 # pageLength = 100, #lengthMenu = c(10,20,30,40,50),
                                 # autoWidth = FALSE,
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