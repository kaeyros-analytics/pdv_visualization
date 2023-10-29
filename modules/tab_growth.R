tabtwo_ui <- function(id) {
  
  ns <- NS(id)
  
  tabPanel(responsive = TRUE,
           
           strong("List of participants"), #icon = icon("line-chart"),
           br(),
  
           br(),
           
           fluidRow(width = 12, responsive = TRUE,
                    
                    box(width = 12, responsive = TRUE,
                        
                        title = tags$span(style = "color: black; text-align: center; font-weight: bold;",""),
                        #height = "400px",
                        solidHeader = TRUE, collapsible = TRUE,
                        #status = "success", # or status = "primary", "warning" , "success", "info", "danger"
                        #br(),
                        #plotly::plotlyOutput('plot3', height = "610px")
                        shinycssloaders::withSpinner(DT::dataTableOutput(ns('agent_table'), height = "523px")
                                                     ,type = 8, color = 'grey'))
                    
                    
           ) # end second fluidRow
           
  ) # end tabPanel Agent growth
  
} # end tabtwo_ui
  

