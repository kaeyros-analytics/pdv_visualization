

tab_vente_category_ui <- function(id) {
  
  ns <- NS(id)
  
  tabPanel(responsive = TRUE,
           
           strong("Volume des ventes par Categorie"), icon = icon("bar-chart-o"),
           br(),
           fluidRow(width = 12, responsive = TRUE,
                    
                    column(width = 4,
                           tagList(
                             dateRangeInput(inputId = ns("daterange2"), "Choisir une date",
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
                           #br(),
                           tagList(
                             selectInput(inputId = ns("pdvcountry2"), label = "Choisir un pays",
                                         choices = c("All", sort(unique(df_bavaria1$PdvCountry))),
                                         selected = "All")
                           )
                           
                    ), # end column for filter country
                    column(width = 4, responsive = TRUE,
                           #br(),
                           tagList(
                             selectInput(inputId = ns("pdvcity2"), label = "Choisir un ville",
                                         choices = c("All", sort(unique(df_bavaria1$PdvCity))),
                                         selected = "All")
                           )
                    ), # end column for filter country
                    
                    # column(width = 4, responsive = TRUE,
                    #        br(),
                    #        tagList(actionButton (inputId = ns("clicks"), label = "Update Histogram", width = "300"))
                    #        
                    # ), # end first column for filter Artifact1
                    
           ), # end first fluidRo
           
           fluidRow(width = 12, responsive = TRUE,
                    tagList(
                      box(width = 6, responsive = TRUE, solidHeader = TRUE, collapsible = TRUE,
                          br(),
                          title = tags$span(align = "center", style = "color: black; font-weight: bold;", 
                                            "Volume des ventes par categorie"),
                          br(),
                          #plotly::plotlyOutput('plot3', height = "610px")
                          shinycssloaders::withSpinner(plotly::plotlyOutput(ns('vente_category'), height = "500px")
                                                       ,type = 8, color = 'grey')
                          
                      ), # end first box
                      
                      box(width = 6, responsive = TRUE, solidHeader = TRUE, collapsible = TRUE,
                          br(),
                          title = tags$span(align = "center", style = "color: black; font-weight: bold;", 
                                            "Top 10 Volume des ventes par vategorie par propriétaire"),
                          br(),
                          #plotly::plotlyOutput('plot4', height = "610px")
                          shinycssloaders::withSpinner(DT::dataTableOutput(ns('top10_category'), height = "500px"),
                                                       type = 8, color = 'grey'))
                    )
                    
           )  # end second fluidRow
  )  # end tabPanel Operational
  
  
} # end tabfour_ui



