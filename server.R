am
function(input, output, session) {
  
  #daterange <- callModule(daterange_server, id = "daterange")
  #country <- callModule(contry_server, id = "country", daterange)
  #city <- callModule(city_server, id = "city", country)
  callModule(map_server, id = "pdv")
  
  

}
