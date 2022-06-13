library(sf)
library(dplyr)
library(leaflet)
library(terra)
library(DT)

##Datos raster

# Lectura de una capa raster de altitud
altitud <-
  rast(
    "C:/Users/gf0604-1/datos geoespaciales/altitud.tif"
  )

# Clase del objeto altitud
class(altitud)

# InformaciÃ³n general sobre el objeto altitud
altitud

# CRS del objeto altitud
crs(altitud)

# AsignaciÃ³n de un CRS a una copia del objeto altitud
altitud_crtm05 <- altitud
crs(altitud_crtm05) <- "EPSG:5367"

# Consulta
crs(altitud_crtm05)

##plot() - mapeo
### Mapa de la capa de altitud
plot(altitud)

# Primera capa del mapa (raster)
plot(
  altitud,
  main = "Registros de presencia de felinos en Costa Rica",
  axes = TRUE,
  reset = FALSE
)

# Segunda capa (vectorial)
plot(felinos$geometry,
     add = TRUE,     
     pch = 16,
     col = "blue")

#writeRaster() - escritura de datos

# Especificación del directorio de trabajo (debe utilizarse una ruta existente)

# Escritura del objeto altitud

writeRaster(altitud, "C:/Users/gf0604-1/datos geoespaciales/clase 08-06-22/altitud.asc")

# Cantidad de filas de un objeto SpatRaster
nrow(altitud)

# Cantidad de columnas de un objeto SpatRaster
ncol(altitud)

# Resolución de un objeto SpatRaster
res(altitud)

##Mapeo de objetos SpatRaster con otros paquetes

###leaflet
# Instalación de raster
install.packages("raster")

# Carga de raster
library(raster)

# Conversión del objeto altitud a la clase RasterLayer
altitud <- raster(altitud)

# Mapa leaflet básico con capas de altitud, provincias y registros de presencia de felinos
leaflet() %>%
  addTiles() %>%
  addRasterImage( # capa raster
    altitud, 
    opacity = 0.6
  ) %>%    
  addPolygons(
    data = provincias,
    color = "black",
    fillColor = "transparent",
    stroke = TRUE,
    weight = 1.0,
  ) %>%
  addCircleMarkers(
    data = felinos,
    stroke = F,
    radius = 4,
    fillColor = 'blue',
    fillOpacity = 1
  )










