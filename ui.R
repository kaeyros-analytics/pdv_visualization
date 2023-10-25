
# Html template used to render UI
ui <- htmlTemplate("www/index.html",
                   daterangeid = daterange_ui("pdv"),
                   countryid = contry_ui("pdv"),
                   cityid = city_ui("pdv"),
                   map = map_ui("pdv")#,
                   #daterange_tab_ui("tab")
                   
                   
                   

) #  end ui