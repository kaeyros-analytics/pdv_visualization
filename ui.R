


title <- tags$a(href='https://www.google.com',
                                tags$img(src="Bavaria-Logo.svg", height = '60', width = '90', style = 'margin-right: 10px; 
                                         margin-top: -3px'),
                                'Bavaria Dashboard', target="_blank")


ui <- dashboardPage(skin = "blue",
                    
                    # ----------------
                    # DASHBOARDHEADER
                    # ----------------
                    
                    
                    dashboardHeader(title = "PDV Dashboard", titleWidth = '500'), # end dashboardHeader
                    
                    # -----------------
                    # DASHBOARDSIDEBAR
                    # -----------------
                    
                    dashboardSidebar(disable = TRUE), # end dashboardSidebar (disable = TRUE means no display sidebar)
                    
                    
                    # --------------
                    # DASHBOARDBODY
                    # --------------
                    
                    
                    dashboardBody(
                      
                      tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Georgia", Times, "Times New Roman", serif;
        font-weight: bold;
        font-size: 24px;
      }
      
      /* body change background color*/
      .content-wrapper, .right-side {
      background-color: aliceblue;
      
      }
      
    '))), ## end title size and format  #F5F5F5 rgb(228, 247, 235)
                      
                      # fixed header
                      tags$script(HTML("$('body').addClass('fixed');")),
                      
                      # tags$head(
                      #   tags$link(
                      #     rel = "stylesheet",
                      #     type = "text/css",
                      #     href = "www/css/body.css"),
                      # )
                      
                      #shinythemes::themeSelector()
                      theme = shinythemes::shinytheme("readable"),
                      br(),
                      
                      tabsetPanel(
                        
                        tab_map_ui("map"),
                        tab_volume_vente_ui("volume_vente"),
                        tab_vente_category_ui("vente_category"),

                      )  # end tabsetPanel
                    )  # end dashboardBody
) # end dashboardPage