
server <- function(input, output, session) {
  
  
    callModule(transaction_server, id = "company")
    #callModule(No_trans_server, id = "company")
  
    #callModule(Nber_success_billers_server, id = "company")
    
    
    # Company external
    #callModule(external_transaction_server, id = "external_company")
    #callModule(No_billers_server, id = "external_company")
    #callModule(Nr_agents_server, id = "external_company")
    
    # agent growth
     
    callModule(table_agent_server, id = "growth")
    #callModule(top_agent_server, id = "growth")
    
    # Oprational Dashbord
    callModule(trans_service_title_server, id = "operational")
    callModule(trans_service_type_server, id = "operational")
    
    # Sales growth
    
    callModule(table_trans_service_type_server, id = "sales_growth")
    callModule(top_service_type_server, id = "sales_growth")
    # callModule(plot_qst_18_vs_11_server, id = "tab5_qst_18_10_and_18_11")
    # callModule(plot_qst_18_vs_12_server, id = "tab6_qst_18_12_and_18_13")
    # callModule(plot_qst_18_vs_13_server, id = "tab6_qst_18_12_and_18_13")
    # callModule(plot_qst_cluster_server, id = "tab7_cluster")
    
    
} # end server