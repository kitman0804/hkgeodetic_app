library(shiny)
library(shinydashboard)
library(leaflet)

#================================================================#
# server
#================================================================#
server <- function(input, output, session) {
  
  source("hkgeodetic/convert.R", local = TRUE)
  
  observeEvent(input$button_hk80g, {
    hk80g_e <- as.numeric(input$hk80g_e)
    hk80g_n <- as.numeric(input$hk80g_n)
    hk80 <- convert_hk80g_wgs84(E = hk80g_e, N = hk80g_n)
    updateTextInput(session, "hk80_lng", value = hk80[["lng"]])
    updateTextInput(session, "hk80_lat", value = hk80[["lat"]])
    updateTextInput(session, "wgs84_lng", value = hk80[["lng"]] + 8.8/60^2)
    updateTextInput(session, "wgs84_lat", value = hk80[["lat"]] - 5.5/60^2)
  })
  
  observeEvent(input$button_hk80, {
    hk80_lng <- as.numeric(input$hk80_lng)
    hk80_lat <- as.numeric(input$hk80_lat)
    hk80g_e <- "under development"
    hk80g_n <- "under development"
    updateTextInput(session, "hk80g_e", value = hk80g_e)
    updateTextInput(session, "hk80g_n", value = hk80g_n)
    updateTextInput(session, "wgs84_lng", value = hk80_lng + 8.8/60^2)
    updateTextInput(session, "wgs84_lat", value = hk80_lat - 5.5/60^2)
  })
  
  observeEvent(input$button_wgs84, {
    wgs84_lng <- as.numeric(input$wgs84_lng)
    wgs84_lat <- as.numeric(input$wgs84_lat)
    hk80g_e <- "under construction"
    hk80g_n <- "under construction"
    updateTextInput(session, "hk80g_e", value = hk80g_e)
    updateTextInput(session, "hk80g_n", value = hk80g_n)
    updateTextInput(session, "hk80_lng", value = wgs84_lng - 8.8/60^2)
    updateTextInput(session, "hk80_lat", value = wgs84_lat + 5.5/60^2)
  })
  
  observeEvent(input$button_reset, {
    updateTextInput(session, "hk80g_lng", value = "")
    updateTextInput(session, "hk80g_lat", value = "")
    updateTextInput(session, "hk80_lng", value = "")
    updateTextInput(session, "hk80_lat", value = "")
    updateTextInput(session, "wgs84_lng", value = "")
    updateTextInput(session, "wgs84_lat", value = "")
  })
  
  # Leaflet map
  hkbasemap <- reactive({
    bg <- leaflet() %>%
      setView(lng = 114.15, lat = 22.35, zoom = 10) %>%
      addTiles(group = "OSM (default)") %>%
      addProviderTiles("Stamen.TonerLite", group = "Stamen.TonerLite") %>%
      addProviderTiles("CartoDB.Positron", group = "CartoDB.Positron") %>%
      addLayersControl(
        baseGroups = c("OSM (default)", "Stamen.TonerLite", "CartoDB.Positron"),
        # overlayGroups = c("Quakes", "Outline"),
        options = layersControlOptions(collapsed = FALSE)
      )
    if (input$wgs84_lng == "" | input$wgs84_lat == "") return(bg)
    wgs84_lng <- input$wgs84_lng
    wgs84_lat <- input$wgs84_lat
    bg <- bg %>%
      addMarkers(lng = wgs84_lng, lat = wgs84_lat)
    return(bg)
  })
  
  output$hkmap <- renderLeaflet({
    hkbasemap()
  })
}



shinyServer(server)