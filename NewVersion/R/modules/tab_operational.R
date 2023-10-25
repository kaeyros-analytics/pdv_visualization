
tabfour_ui <- function(id) {
  
  ns <- NS(id)
  
  tabPanel(responsive = TRUE,
           
           strong("Volume des ventes par Categorie"), #icon = icon("line-chart"),
           br(),
           br(),
           
           fluidRow(width = 12, responsive = TRUE,
                    
                    box(width = 6, responsive = TRUE, solidHeader = TRUE, collapsible = TRUE,
                        br(),
                        title = tags$span(align = "center", style = "color: black; font-weight: bold;", 
                                          "Volume des vente par categorie"),
                        br(),
                        #plotly::plotlyOutput('plot3', height = "610px")
                        shinycssloaders::withSpinner(plotly::plotlyOutput(ns('plot_title'), height = "500px")
                                                     ,type = 8, color = 'grey')
                        
                    ), # end first box
                    
                    box(width = 6, responsive = TRUE, solidHeader = TRUE, collapsible = TRUE,
                        br(),
                        title = tags$span(align = "center", style = "color: black; font-weight: bold;", 
                                          "Top 10 Volume des ventes par par propriétaire"),
                        br(),
                        #plotly::plotlyOutput('plot4', height = "610px")
                        shinycssloaders::withSpinner(DT::dataTableOutput(ns('plot_type'), height = "500px"),
                                                     type = 8, color = 'grey'))
           )  # end second fluidRow
  )  # end tabPanel Operational
  
  
} # end tabfour_ui
  
  

