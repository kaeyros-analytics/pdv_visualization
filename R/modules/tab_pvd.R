

#---------------------
# CREATE UI FUNCTION
#---------------------
daterange_tab_ui <- function(id) {
  
  # NS(): Assign module elements to a unique namespace
  # `NS(id)` returns a namespace function, which was save as `ns` and will
  # invoke later.
  
  ns <- NS(id)
  tagList(
    dateRangeInput(inputId = ns("daterange"), "Start_Period",
                   start = as.Date("2021-01-01"),
                   #start  = min(df_testdata$date),
                   #end    = max(df_testdata$date),
                   end = as.Date("2023-12-31"),
                   min    = min(df_bavaria1$Date),
                   max    = max(df_bavaria1$Date),
                   
                   format = "dd-mm-yyyy",
                   separator = " - ")
  ) # end taList
  
} # end daterange_ui

daterange_tab_server <- function(input, output, session, daterange) {
  #daterange = reactive(input$daterange)
  
}