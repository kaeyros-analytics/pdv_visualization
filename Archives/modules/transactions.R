
transaction_ui <- function(id) {
  ns <- NS(id)
  shinycssloaders::withSpinner(leaflet::leafletOutput(outputId = ns("map_plot"), height = "500px"),
                               type = 8, color = 'grey')
} # end transaction_ui

transaction_server <- function(input, output, session) {
  
  
  output$map_plot <- renderLeaflet({
    # https://stackoverflow.com/questions/33041266/r-rworldmap-map-issue-and-leaflet-application
    # generate the wordl map
    world <- maps::map("world", fill=TRUE, plot=FALSE)
    world_map <- maptools::map2SpatialPolygons(world, sub(":.*$", "", world$names))
    world_map <- sp::SpatialPolygonsDataFrame(world_map,
                                              data.frame(country=names(world_map), 
                                                         stringsAsFactors=FALSE), 
                                              FALSE)
    
    choosen_countries <- c("Cameroon", "Gabon")
    
    #cnt4 <- c(unique(df_bavaria$PdvCountry))
    
    target_map <- subset(world_map, country %in% choosen_countries)
    
    
    df_bavaria_map <- df_bavaria1 %>% 
      #filter(between(Date, as.Date('2022-01-20'), as.Date('2022-02-20'))) %>% 
      filter(Date >= '2021-01-01' & Date <= '2022-04-28') %>% 
      #filter(Date >= input$daterange[1] & Date <= input$daterange[2]) %>% 
      group_by(PdvCountry, PdvCity, PdvDistrict, OwnerPhone, Date_de_fin_de_contrat, GPSLatitude, 
               GPSLongitude, categories_contrat, PdvName) %>% 
      summarise(sum_SalesAmount = sum(SalesAmount)) %>% 
      mutate(sum_SalesAmount_eur = paste(formatC(sum_SalesAmount, format = "d",big.mark = "."), "€"))
    
    # add pop up
    polygon_popup <- paste0("<strong>",df_bavaria_map$PdvName,"</strong>", "<br>",
                            "<strong>Pays: </strong>", df_bavaria_map$PdvCountry, "<br>",
                            "<strong>Ville: </strong>", df_bavaria_map$PdvCity, "<br>",
                            "<strong>Quartier: </strong>", df_bavaria_map$PdvDistrict, "<br>",
                            "<strong>Tel Propriétaire: </strong>","+", df_bavaria_map$OwnerPhone, "<br>",
                            "<strong>Montant ventes: </strong>", df_bavaria_map$sum_SalesAmount_eur, "<br>",
                            "<strong>Fin du contrat: </strong>",  format(df_bavaria_map$Date_de_fin_de_contrat, "%d-%m-%Y"))%>% 
      lapply(htmltools::HTML)
    
    # add markers colors
    icons <- awesomeIcons(icon = "ios-close",
                          iconColor = "black",
                          library = "ion",
                          markerColor = df_bavaria_map$categories_contrat)
    
    fig_map <- leaflet(data = target_map) %>% 
      #setView(11, 49,  zoom = 9) %>%
      addTiles() %>% 
      addPolygons(weight=1) #%>%
    #https://stackoverflow.com/questions/31406598/leaflet-in-r-setview-based-on-range-of-latitude-and-longitude-from-dataset
    #fitBounds(lng1 = min(df_bavaria$GPSLongitude), 
    #          lat1 = min(df_bavaria$GPSLatitude), 
    #          lng2 = max(df_bavaria$GPSLongitude), 
    #          lat2 = max(df_bavaria$GPSLatitude))
    
    fig_map <- fig_map %>% 
      addAwesomeMarkers(
        data = df_bavaria_map,
        lng = ~ GPSLongitude, lat = ~ GPSLatitude,
        popup = polygon_popup, label = polygon_popup,
        icon =  icons,
        labelOptions = labelOptions(noHide = F,
                                    style = list(
                                      "color" = "#00308F",
                                      "font-size" = "12px"))) 
    return(fig_map)
  }) # end output$revenueTime
  
} # end transaction_server


