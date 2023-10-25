
tabone_ui <- function(id) {
  ns <- NS(id)
  
  tabPanel(responsive = TRUE,
           
           strong("La Carte"), #icon = icon("line-chart"),
           br(),
           br(),
           # create the place and position for the graph
           fluidRow(width = 12, responsive = TRUE,
                    box(width = 12, responsive = TRUE,
                        
                        title = tags$span(style = "color: black; text-align: center; font-weight: bold;", "Attendance list per day"),
                        #title = "Transaction Volume Vs. Revenue over Time", 
                        #status= "info", #3D85C6
                        solidHeader = TRUE, collapsible = TRUE,  
                        #status = "success", # or status = "primary" , "warning" , "success", "info", "danger"
                        #br(),
                        #plotly::plotlyOutput('plot1', height = "610px") , height = "550px"
                        shinycssloaders::withSpinner(leaflet::leafletOutput(outputId = ns("map_plot"), height = "500px"),
                                                     type = 8, color = 'grey')
                        
                    ), # end first box oder  place for first graph
                    
                    #box(width = 6, responsive = TRUE,
                        
                        #title = strong(""),  solidHeader = F, #status = "success",
                        #title = "Number of  transactions",  solidHeader = TRUE, collapsible = TRUE, 
                        #title = tags$span(style = "color: black; text-align: center; font-weight: bold;", "Number of person present per day"), # #3D85C6 
                        #solidHeader = TRUE,
                        #collapsible = TRUE,
                        #status = "success", # or status = "primary" , "warning" , "success", "info", "danger"
                        #br(),
                        #plotly::plotlyOutput('plot1', height = "610px")
                        #shinycssloaders::withSpinner(plotly::plotlyOutput(outputId = ns("plotTransaction"), height = "500px"),
                         #                            type = 8, color = 'grey')
                        
                    #) # end first box oder place for second graph
                    

                    
           ) # end second fluidRow
           
  ) # end tabPanel Company
  
  
} # end tabone_ui

