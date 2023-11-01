
tab_volume_vente_ui <- function(id) {
  
  ns <- NS(id)
  
  tabPanel(responsive = TRUE,
           
           strong("Volume de vente Pays/Ville"), icon = icon("line-chart"),
           br(),
           fluidRow(width = 12, responsive = TRUE,
                    
                    column(width = 4,
                           tagList(
                             dateRangeInput(inputId = ns("daterange1"), "Choisir une date",
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
                    column(width = 4, responsive = TRUE,
                           tagList( selectInput(inputId = ns("pdvcountry"), label = "Choisir un pays",
                                                choices = c("All", sort(as.character(unique(df_bavaria1$PdvCountry)))),
                                                selected = "All"))
                          
                           
                    ), # end column for filter country
                    column(width = 4, responsive = TRUE,
                           #br(),
                           tagList(selectInput(inputId = ns("pdvcity"), label = "Choisir un ville",
                                               choices = c("All", sort(as.character(unique(df_bavaria1$PdvCity)))),
                                               selected = "All"))
                           
                           
                    ), # end column for filter country
                    
                    # column(width = 4, responsive = TRUE,
                    #        br(),
                    #        tagList(actionButton (inputId = ns("clicks"), label = "Update Histogram", width = "300"))
                    #        
                    # ), # end first column for filter Artifact1
                    
           ), # end first fluidRo
           #br(),
           
           fluidRow(width = 12, responsive = TRUE,
                    
                    tagList(                    box(width = 6, responsive = TRUE,
                                                    
                                                    title = tags$span(style = "color: black; text-align: center; font-weight: bold;",
                                                                      "Volume des ventes par pays"),
                                                    #height = "400px",
                                                    solidHeader = TRUE, collapsible = TRUE,
                                                    #status = "success", # or status = "primary", "warning" , "success", "info", "danger"
                                                    #br(),
                                                    #plotly::plotlyOutput('plot3', height = "610px")
                                                    #shinycssloaders::withSpinner(DT::dataTableOutput(ns('service_type_table'), height = "523px")
                                                    #,type = 8, color = 'grey')
                                                    shinycssloaders::withSpinner(plotly::plotlyOutput(outputId = ns("volume_vente_pays"), height = "500px"),
                                                                                 type = 8, color = 'grey')
                                                    
                    ), # end first box
                    
                    box(width = 6, responsive = TRUE, solidHeader = TRUE, collapsible = TRUE, 
                        #br(),
                        title = tags$span(align = "center", style = "color: black; font-weight: bold;", 
                                          "Volume des ventes par ville"), #status = "success",
                        
                        #plotly::plotlyOutput('plot4', height = "610px")
                        shinycssloaders::withSpinner(plotly::plotlyOutput(ns('volume_vente_ville'), height = "500px"),
                                                     type = 8, color = 'grey')
                    )
                    ) # endg  tagList
                    
           ) # end second fluidRow
           
  ) # end tabPanel Sales growth
  
  
}

tab_volume_vente_server <- function(input, output, session) {
  
  observeEvent(input$pdvcountry,{
    
    if(input$pdvcountry == "All"){
      choice = c("All")
      
    } else {
      choice=unique(df_bavaria1$PdvCity[df_bavaria1$PdvCountry==input$pdvcountry])
    }
    
    updateSelectInput(session,'pdvcity',
                      choices = choice,
                      selected = choice[1])
  }) 
  
}

