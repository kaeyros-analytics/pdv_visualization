

# CREATE UI FUNCTION
#---------------------
city_ui <- function(id) {
  
  # NS(): Assign module elements to a unique namespace
  # `NS(id)` returns a namespace function, which was save as `ns` and will
  # invoke later.
  
  ns <- NS(id)
  tagList(
    selectInput(inputId = ns("selected_city"), "",
                #choices = unique(sort(df_bavaria1$PdvCountry)),
                choices = c("All", unique(sort(df_bavaria1$PdvCity))),
                selected = 1,
                selectize = TRUE)
  ) # end taList
  
} # end client_Id_ui

city_server <- function(input, output, session, country) {
  
  
  city = reactive(input$selected_city)
  
}