am
function(input, output, session) {
  
  callModule(daterange_server, id = "daterange")
  callModule(contry_server, id = "country")
  callModule(city_server, id = "city")
  

}
