
table_agent_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(DT::dataTableOutput(ns('agent_table'), height = "523px"), type = 8, color = 'grey')
} # end table_agent_ui

table_agent_server <- function(input, output, session) {
  
  # Calculate the transaction volume from each agent 
  
  output$agent_table <- DT::renderDataTable({
    
    DT::datatable(df_workshop, 
                  extensions = 'Buttons', rownames = TRUE, class = 'cell-border stripe', filter = 'top',
                  caption = htmltools::tags$caption(
                    style = 'caption-side: bottom; text-align: center;',
                    'Tabelle: ', htmltools::strong('Application list for the data driven workshop 27.09 - 29.09.2023')
                  ),
                  #colnames = c('Nr.' = 1, 'Ebene' = 2, 'Pflege 2019' = 3, 'Pflege 2020' = 4),
                  # Change button download color
                  # callback=JS('$("button.buttons-copy").css("background","red"); 
                  #     $("button.buttons-collection").css("background","green"); 
                  #     return table;'),
                  # https://stackoverflow.com/questions/55931341/using-icons-for-shiny-renderdatatable-extension-buttons
                  #
                  options = list(dom = 'Bfrtip', # remove the box search on the top right side and the show entries on the top left side
                                 searchHighlight = TRUE,
                                 #buttons = c('csv', 'excel', 'pdf'),
                                 buttons = 
                                   list(list(
                                     extend = "collection", 
                                     buttons = list(
                                       # Add a title of each format style
                                       list(extend = "excel", title = "Application list for the data driven workshop 27.09 - 29.09.2023",
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
                                 scrollY = 300,
                                 #scroller = TRUE, # remove the number of pages at the bottom with scroller = TRUE
                                 # search = list(regex = FALSE, caseInsensitive = TRUE, search=''),
                                 # #lengthMenu = list(c(5, 150, -1), c('5', '150', 'All')),
                                  pageLength = nrow(df_workshop), #lengthMenu = c(10,20,30,40,50),
                                 # autoWidth = FALSE,
                                 # darkcyan dodgerblue
                                 initComplete = JS("function(settings, json) {", "$(this.api().table().header()).css({'background-color': '#008B8B',
                                                   'color': 'white'});", "}"),
                                 
                                 # here center all the variables
                                 columnDefs = list(list(className = 'dt-center', targets = c(0, 1, 2, 3)), 
                                                   # here hide the the fourth variable
                                                   list(visible=FALSE, targets=0)) # end columnDefs
                                 #columnDefs = list(list(visible=FALSE, targets=2))
                  ) # end option list
    )
  })
  
  
} # end table_agent_server