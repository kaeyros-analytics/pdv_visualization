
server <- function(input, output, session) {
  
  
    callModule(transaction_server, id = "company")

    # agent growth
     
    #callModule(table_agent_server, id = "growth")
    #callModule(top_agent_server, id = "growth")
    
    # Sales growth
    
    callModule(table_trans_service_type_server, id = "sales_growth")
    callModule(top_service_type_server, id = "sales_growth")
    
    # Oprational Dashbord
    callModule(trans_service_title_server, id = "operational")
    callModule(trans_service_type_server, id = "operational")
    
    
   
    
    
} # end server