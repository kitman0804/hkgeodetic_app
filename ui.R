library(shiny)
library(shinydashboard)
library(leaflet)

#================================================================#
# ui
#================================================================#

header <- dashboardHeader(
  title = "Geodetic Datum Convertor v0.1.0"
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Convertor", tabName = "convertor"),
    menuItem("Appendix", tabName = "appendix")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "convertor",
      fluidRow(
        box(
          title = "HK80 Grid",
          solidHeader = TRUE,
          width = 4,
          status = "primary",
          textInput("hk80g_e", "Easting (m)", value = ""),
          textInput("hk80g_n", "Northing (m)", value = ""),
          actionButton("button_hk80g", "Convert", width = "100%")
        ),
        box(
          title = "HK80 Datum",
          solidHeader = TRUE,
          width = 4,
          status = "primary",
          textInput("hk80_lng", "Longitude (E)", value = ""),
          textInput("hk80_lat", "Latitude (N)", value = ""),
          actionButton("button_hk80", "Convert", width = "100%")
        ),
        box(
          title = "WGS84 Datum",
          solidHeader = TRUE,
          width = 4,
          status = "primary",
          textInput("wgs84_lng", "Longitude (E)", value = ""),
          textInput("wgs84_lat", "Latitude (N)", value = ""),
          actionButton("button_wgs84", "Convert", width = "100%")
        )
      ),
      fluidRow(
        box(
          title = "Map of Hong Kong",
          width = 12,
          leafletOutput("hkmap"),
          actionButton("button_reset", "Reset")
        )
      )
    ),
    tabItem(
      tabName = "appendix",
      includeMarkdown("appendix.md")
    )
  )
)


dashboardPage(header, sidebar, body, skin = "green")