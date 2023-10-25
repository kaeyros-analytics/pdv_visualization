
tabthree_ui <- function(id) {
  
  ns <- NS(id)
  
  tabPanel(responsive = TRUE,
           
           strong("Gender"), #icon = icon("line-chart"),
           br(),
           
           br(),
           
           fluidRow(width = 12, responsive = TRUE,
                    
                    box(width = 6, responsive = TRUE,
                        
                        title = tags$span(style = "color: black; text-align: center; font-weight: bold;",
                                          "Number of participants by gender"),
                        #height = "400px",
                        solidHeader = TRUE, collapsible = TRUE,
                        #status = "success", # or status = "primary", "warning" , "success", "info", "danger"
                        #br(),
                        #plotly::plotlyOutput('plot3', height = "610px")
                        #shinycssloaders::withSpinner(DT::dataTableOutput(ns('service_type_table'), height = "523px")
                                                     #,type = 8, color = 'grey')
                        shinycssloaders::withSpinner(plotly::plotlyOutput(outputId = ns("service_type_table"), height = "500px"),
                                                     type = 8, color = 'grey')
                        
                    ), # end first box
                    
                    box(width = 6, responsive = TRUE, solidHeader = TRUE, collapsible = TRUE, 
                        #br(),
                        title = tags$span(align = "center", style = "color: black; font-weight: bold;", 
                                          "Age of participants by gender"), #status = "success",
                        
                        #plotly::plotlyOutput('plot4', height = "610px")
                        shinycssloaders::withSpinner(plotly::plotlyOutput(ns('top_service_type'), height = "500px"),
                                                     type = 8, color = 'grey')
                    )#,
                    
           ) # end second fluidRow
           
  ) # end tabPanel Sales growth
  
  
}
  
  