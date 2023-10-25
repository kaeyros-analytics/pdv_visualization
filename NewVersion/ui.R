
ui <- dashboardPage(skin = "black",
    
    # ----------------
    # DASHBOARDHEADER
    # ----------------
    
    
    dashboardHeader(title = "Data Driven Workshop", titleWidth = '450'), # end dashboardHeader
    
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
          
            tabone_ui("company"),
            #tabfive_ui("external_company"),
            #tabtwo_ui("growth"),
            tabthree_ui("sales_growth"),
            tabfour_ui("operational")
        )  # end tabsetPanel
    )  # end dashboardBody
) # end dashboardPage