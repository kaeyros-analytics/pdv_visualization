
tab_map_ui <- function(id) {
  
  ns <- NS(id)
  
  tabPanel(responsive = TRUE,
           
           strong("Map"), icon = icon("map"),
           br(),
           fluidRow(width = 12, responsive = TRUE,
                    
                    column(width = 4,
                           tagList(
                             dateRangeInput(inputId = ns("daterange"), "Choisir une date",
                                            start = as.Date("2021-01-01"),
                                            #end = as.Date("2023-12-31"),
                                            end = Sys.Date(),
                                            min    = min(df_bavaria1$Date),
                                            max    = max(df_bavaria1$Date),
                                            format = "dd-mm-yyyy",
                                            separator = " - ")
                           ), # end taList
                           br(),
                           ),
                    # column(width = 4, responsive = TRUE,
                    #        br(),
                    #        tagList(actionButton (inputId = ns("clicks"), label = "Update Histogram", width = "300"))
                    #        
                    # ), # end first column for filter Artifact1
                    
           ), # end first fluidRow
           br(),
           
           fluidRow(width = 12, responsive = TRUE,
                    
                    box(width = 12, responsive = TRUE,
                        
                        title = tags$span(style = "color: black; text-align: center; font-weight: bold;",""),
                        #height = "400px",
                        solidHeader = TRUE, collapsible = TRUE,
                        #status = "success", # or status = "primary", "warning" , "success", "info", "danger"
                        #br(),
                        shinycssloaders::withSpinner(leaflet::leafletOutput(outputId = ns("map_plot"), height = "500px"),
                                                     type = 8, color = 'grey')
                        
                    ), # end first box 
                    
           ) # end second fluidRow
           
  ) # end tabPanel Agent growth
  
} # end tab_map_ui