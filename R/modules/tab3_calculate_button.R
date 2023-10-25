

#---------------------
# CREATE UI FUNCTION
#---------------------
tab3_calculate_button_ui <- function(id) {
  
  # NS(): Assign module elements to a unique namespace
  # `NS(id)` returns a namespace function, which was save as `ns` and will
  # invoke later.
  
  ns <- NS(id)
  tagList(
    tags$div(
      #class = "selectButton",
      actionButton(inputId = ns("actionFilter3"), title="", label="Calculate" )
      
    )
    
  ) # end taList
  
} # end tab3_calculate_button_ui