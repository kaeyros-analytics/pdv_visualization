
#---------------------
# CREATE UI FUNCTION
#---------------------
tab3_machine_id_ui <- function(id) {
  
  # NS(): Assign module elements to a unique namespace
  # `NS(id)` returns a namespace function, which was save as `ns` and will
  # invoke later.
  
  ns <- NS(id)
  tagList(
    selectInput(inputId = ns("selected_contry"), "",
                #choices = unique(sort(df_bavaria1$PdvCountry)),
                choices = c("All", unique(sort(df_bavaria1$PdvCountry))),
                selected = 1,
                selectize = TRUE)
  ) # end taList
  
} # end tab3_machine_id_ui