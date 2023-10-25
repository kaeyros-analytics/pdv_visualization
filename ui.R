
# Html template used to render UI
ui <- htmlTemplate("www/index.html",
                   daterangeid = daterange_ui("pdv"),
                   countryid = contry_ui("pdv"),
                   cityid = city_ui("pdv"),
                   map = map_ui("pdv")#,
                   #daterange_tab_ui("tab")
                   
                   #var3_selectclientid = tab3_client_id_ui("tab3"),
                   #var3_selectmachineid = tab3_machine_id_ui("tab3"),
                   #var3_selectdate = tab3_daterange_ui("tab3"),
                   #var3_select_calculate_button  = tab3_calculate_button_ui("tab3"),
                   #plot_dynamic_inflation = plot_dynamic_inflation_ui("tab3"),
                   #plot_dynamic_cons_conf = plot_dynamic_cons_conf_ui("tab3"),
                   #plot_dynamic_DEU_dmd = plot_dynamic_DEU_dmd_ui("tab3"),
                   #plot_dynamic_DEU_prd = plot_dynamic_DEU_prd_ui("tab3")
                   
                   
                   
                   

) #  end ui