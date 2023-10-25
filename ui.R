
# Html template used to render UI
ui <- htmlTemplate("www/index.html",
                   daterangeid = daterange_ui("daterange"),
                    countryid = contry_ui("country"),
                   cityid = city_ui("city")
                   

) #  end ui