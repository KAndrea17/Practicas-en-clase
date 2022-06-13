# Introduccion al manejo de datos geoespaciales en R

library(sf)
library(dplyr)
library(leaflet)

## Lectura de una capa vectorial (GeoJSON) de provincias de Costa Rica
provincias <-
  st_read("C:/Users/gf0604-1/datos geoespaciales/provincias.geojson")

felinos <-
  st_read(
    "C:/Users/gf0604-1/datos geoespaciales/felinos.csv",
    options = c(
      "X_POSSIBLE_NAMES=decimalLongitude", # columna de longitud decimal
      "Y_POSSIBLE_NAMES=decimalLatitude"   # columna de latitud decimal
    ),
    quiet = TRUE
  )


class(provincias)
class(felinos)

st_crs(provincias)

st_crs(felinos)

## Asignación de un CRS al objeto felinos
st_crs(felinos) <- 4326

## Transformación del CRS del objeto provincias a WGS84 (EPSG = 4326)
provincias <-
  provincias %>%
  st_transform(4326)

#plot() - mapeo

# Mapeo de las geometrías del objeto provincias
plot(provincias$geometry)

plot(provincias)

plot(provincias$area)

plot(provincias$geometry)

# Mapeo con argumentos adicionales de plot()
plot(
  provincias$geometry,
  extent = st_bbox(c(xmin = -86.0, xmax = -82.3, ymin = 8.0, ymax = 11.3)),
  main = "Provincias de Costa Rica",
  axes = TRUE,
  graticule = TRUE
)

# Primera capa del mapa
plot(
  provincias$geometry,
  extent = st_bbox(c(xmin = -86.0, xmax = -82.3, ymin = 8.0, ymax = 11.3)),
  main = "Registros de presencia de felinos en Costa Rica",
  axes = TRUE,
  graticule = TRUE,
  reset = FALSE
)

# Segunda capa
plot(felinos$geometry,
     add = TRUE,     
     pch = 25,  #(esta opcion cambia la geometría)#
     col = "orange")

## st_write() - escritura de datos

st_write(provincias, "C:/Users/gf0604-1/datos geoespaciales/provincias.gpkg")


st_write(felinos, "C:/Users/gf0604-1/datos geoespaciales/felinos.shp")

##Mapeo de objetos sf con otros paquetes
### leaflet

install.packages("leaflet")
install.packages("terra")
install.packages("raster")
summary(felinos$geometry)

library(leaflet)

####Ejemplos
#funcion signo de mas y menos y mapa mundial#

leaflet() %>%
  addProviderTiles(providers$Esri.WorldImagery)

# Mapa leaflet básico de provincias y registros de presencia de felinos
leaflet() %>%
  addTiles() %>% # capa base de OSM
  addPolygons( # capa de provincias (polígonos)
    data = provincias,
    color = "black",
    fillColor = "transparent",
    stroke = TRUE,
    weight = 1.0,
  ) %>%  
  addCircleMarkers( # capa de registros de presencia (puntos)
    data = felinos,
    stroke = F,
    radius = 4,
    fillColor = 'blue',
    fillOpacity = 1
  )
