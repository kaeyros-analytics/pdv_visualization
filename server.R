

server <- function(input, output, session) {
  
  
  callModule(map_server, id = "map")
  callModule(tab_volume_vente_server, id = "volume_vente")
  callModule(volume_vente_pays_server, id = "volume_vente")
  callModule(volume_vente_ville_server, id = "volume_vente")
  callModule(tab_vente_category_server, id = "vente_category")
  callModule(volume_vente_category_server, id = "vente_category")
  callModule(top10_vente_category_server, id = "vente_category")
  

} # end server