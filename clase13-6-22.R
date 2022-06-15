library(sf)
library(dplyr)
library(leaflet)
library(ggplot2)
library(plotly)
library(DT)
library(readr)
library(terra)

# Lectura y visualización de datos geoespaciales de cantones

# Lectura
cantones <-
  st_read(
    dsn = "C:/Users/gf0604-1/datos geoespaciales/clse 13-6-22/cantones.geojson",
    quiet = TRUE
  ) %>%
  st_transform(4326) # transformación a WGS84

# Visualización en un mapa
plot(
  cantones$geometry,
  extent = st_bbox(c(xmin = -86.0, xmax = -82.3, ymin = 8.0, ymax = 11.3)),
  main = "Cantones de Costa Rica",
  axes = TRUE,
  graticule = TRUE
)



#CLASE 15-06-22


# Casos positivos de covid-19 en antones de Costa Rica

# Lectura, transformación y visualización de casos positivos acumulados de covid-19 en cantones de Costa Rica

# Carga
covid_cantonal_positivos <-
  read_delim(file = "C:/Users/gf0604-1/datos geoespaciales/clse 13-6-22/05_30_22_CSV_POSITIVOS.csv",
             locale = locale(encoding = "WINDOWS-1252"), # para desplegar correctamente acentos y otros caracteres
             col_select = c("cod_provin", "provincia", "cod_canton", "canton", "30/05/2022"))

# Transformación
covid_cantonal_positivos <-
  covid_cantonal_positivos %>%
  rename(positivos = '30/05/2022') %>% # renombramiento de columna
  filter(!is.na(canton) & canton != "Otros") # borrado de filas con valor NA u "Otros" en la columna canton

# Visualización en una tabla
covid_cantonal_positivos %>%
  datatable(options = list(
    pageLength = 5,
    language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json')
  ))

#Introducción
# Funciones básicas para manejo de objetos tipo data.frame y sf

# Clase de cantones
class(cantones)

# Dimensiones (cantidad de filas y de columnas)
dim(cantones)

# Cantidad de filas (i.e. observaciones)
nrow(cantones)

# Cantidad de columnas (i.e. variables)
ncol(cantones)

# Nombres de las columnas
names(cantones)

# Estructura del conjunto de datos
glimpse(cantones)

# Ejemplos de uso de st_drop_geometry()

# Remoción de la columna de geometría
cantones_df <- st_drop_geometry(cantones)

# Nombres de las columnas (nótese que ya no está la columna de geometría)
names(cantones_df)

# Clase de df_cantones (nótese como no se muestra ya la clase sf)
class(cantones_df)

# Tamaño del conjunto de datos original (tipo sf)
print(object.size(cantones), units="Kb")

# Tamaño del conjunto de datos sin geometrías (tipo data.frame)
print(object.size(cantones_df), units="Kb")

# Ejemplos de uso del argumento drop

# Sin drop = TRUE
cantones[1:10, c("canton", "area")]

# Con drop = TRUE
cantones[1:10, c("canton", "area"), drop=TRUE]

#Creación de subconjuntos
# Ejemplos de uso de la notación []

# Subconjunto especificado por posiciones de filas
cantones[1:10, ]

# Subconjunto especificado por posiciones de columnas
cantones[, 8:10]

# Subconjunto especificado por nombres de columnas
cantones[, c("canton", "area", "provincia")]

# Ejemplos de uso de la notación $

# Cantones de la provincia de Cartago
cantones[cantones$provincia == "Cartago", c("canton", "provincia"), drop = TRUE]

# Ejemplos de uso de subset()

# Cantones con área >= 2000 km2
subset(cantones[, c("canton", "area"), drop = TRUE],
       area >= 2000)
# Ejemplos de uso de dplyr::select()

# Selección de columnas
cantones %>%
  dplyr::select(canton, provincia) # se especifica el nombre del paquete para evitar un conflicto con raster::select

# Selección y cambio de nombre de columnas
cantones %>%
  dplyr::select(canton, area_km2 = area, provincia)

# Ejemplos de uso de slice()

# Subconjunto especificado mediante un rango de filas
cantones %>%
  slice(1:10)
# El método filter()

# Androides de "La Guerra de las Galaxias"
starwars %>%
  filter(species == "Droid")

# El operador pipe (%>%)

# Encadenamiento de funciones mediante pipes (%>%)

starwars %>%
  filter(species == "Human") %>%
  dplyr::select(name, homeworld, species) %>%
  slice(1:10)

# Una alternativa al uso de pipes es el “anidamiento” (nesting) de las funciones:

# Anidamiento de funciones
slice(
  dplyr::select(
    filter(
      starwars,
      species=="Human"
    ),
    name, homeworld, species
  ),
  1:10
)

# Ejercicio

cantones_puntarenas_guanacaste <-
  cantones %>%
  filter((provincia == "Puntarenas" | provincia == "Guanacaste") & area >= 2000) %>%
  dplyr::select("provincia","canton","area")

#Agregación de datos
##La función aggregate() de stats

# Ejemplos de uso de stats::agregate()

# Suma de áreas de cantones por provincia
aggregate(
  data = cantones, 
  area ~ provincia, 
  FUN = sum, 
  na.rm = TRUE
)

##El método aggregate() de sf

# Ejemplos de uso de sf::agregate()

# Suma de áreas de cantones por provincia
aggregate(
  cantones["area"], 
  by = list(cantones$provincia), 
  FUN = sum, 
  na.rm = TRUE
)

##El método summarise() de dplyr

# Ejemplos de uso de de summarise()

# Suma de áreas de cantones por provincia
cantones %>%
  group_by(provincia) %>%
  summarise(area_km2 = sum(area, na.rm = TRUE))

# Ejemplo de renombramiento de variables con summarise()

# Suma total de las áreas de cantones
cantones %>%
  summarize(area_km2 = sum(area, na.rm = TRUE),
            cantidad_cantones = n())

# Área y cantidad de cantones de las tres provincias más grandes
cantones %>%
  st_drop_geometry() %>%  
  dplyr::select(area, provincia) %>%
  group_by(provincia) %>%
  summarise(area = sum(area, na.rm = TRUE),
            cantidad_cantones = n()) %>%
  arrange(desc(area)) %>%
  top_n(n = 3, wt = area)

## Ejercicio: mediante summarize(), y otras funciones de dplyr, despliegue el área y la cantidad de cantones de las dos provincias más pequeñas.

cantones %>%
  st_drop_geometry() %>%  
  dplyr::select(area, provincia) %>%
  group_by(provincia) %>%
  summarise(area = sum(area, na.rm = TRUE),
            cantidad_cantones = n()) %>%
  arrange(desc(area)) %>%
  top_n(n = -2, wt = area)

##Cruce de datos

## El método left_join()

# Ejemplos de uso de left_join()

# "Join" de los datos geoespaciales de cantones con los de casos positivos de covid. 
# Ambas tablas comparten la columna cod_canton.
covid_cantonal_positivos_geoespacial <- left_join(cantones, covid_cantonal_positivos)

# Visualización en un mapa generado con plot()
plot(
  covid_cantonal_positivos_geoespacial["positivos"],
  extent = st_bbox(c(xmin = -86.0, xmax = -82.3, ymin = 8.0, ymax = 11.3)),
  main = "Casos positivos de covid-19 en cantones de Costa Rica",
  axes = TRUE,
  graticule = TRUE
)

# Mapa leaflet de casos positivos de covid en cantones

# OPCIONAL: simplificación de geometrías
covid_cantonal_positivos_geoespacial <-
  covid_cantonal_positivos_geoespacial %>%
  st_transform(5367) %>%
  st_simplify(dTolerance = 100) %>%
  st_transform(4326)

# Paleta de colores
colores <-
  colorNumeric(palette = "YlOrBr",
               domain = covid_cantonal_positivos_geoespacial$positivos,
               na.color = "transparent")

# Mapa
leaflet() %>%
  setView(# centro y nivel inicial de acercamiento
    lng = -84.19452,
    lat = 9.572735,
    zoom = 7) %>%
  addTiles(group = "OpenStreetMap") %>% # capa base
  addProviderTiles(provider = providers$Esri.WorldImagery, group = "ESRI") %>%
  addProviderTiles(provider = providers$Stamen.Toner) %>%
  addPolygons(
    # capa de polígonos
    data = covid_cantonal_positivos_geoespacial,
    fillColor = ~ colores(covid_cantonal_positivos_geoespacial$positivos),
    fillOpacity = 0.7,
    color = "black",
    stroke = TRUE,
    weight = 1.0,
    popup = paste(
      # ventana emergente
      paste(
        "<strong>Cantón:</strong>",
        covid_cantonal_positivos_geoespacial$canton
      ),
      paste(
        "<strong>Casos positivos de covid:</strong>",
        covid_cantonal_positivos_geoespacial$positivos
      ),
      sep = '<br/>'
    ),
    group = "Casos positivos de covid"
  ) %>%
  addLayersControl(
    # control de capas
    baseGroups = c("OpenStreetMap"),
    overlayGroups = c("Casos positivos de COVID")
  ) %>%
  addLegend(
    # leyenda
    position = "bottomleft",
    pal = colores,
    values = covid_cantonal_positivos_geoespacial$positivos,
    group = "Casos positivos de COVID",
    title = "Cantidad de casos"
  )

#Datos raster

#Manejo de datos de atributos con el paquete terra

# Creación de un objeto SpatRaster
elevacion <- rast(
  nrows = 6,
  ncols = 6,
  resolution = 0.5,
  xmin = -1.5,
  xmax = 1.5,
  ymin = -1.5,
  ymax = 1.5,
  vals = 1:36
)

# Mapeo
plot(elevacion)


# Tipos de granos
grano_tipo <- c("arcilla", "limo", "arena")

# Lista de granos generada aleatoriamente
lista_granos <- sample(grano_tipo, 36, replace = TRUE)
lista_granos

# Factor de tipos de granos
grano_factor <- factor(lista_granos, levels = grano_tipo)

# Objeto SpatRaster de tipos de granos
grano <- rast(
  nrows = 6,
  ncols = 6,
  resolution = 0.5,
  xmin = -1.5,
  xmax = 1.5,
  ymin = -1.5,
  ymax = 1.5,
  vals = grano_factor
)

# Mapeo
plot(grano)

# Especificación del directorio de trabajo (debe ser una ruta existente)
setwd("C:/Users/gf0604-1/datos geoespaciales/clase15-6-22")

# Escritura de los objetos raster
writeRaster(elevacion, "C:/Users/gf0604-1/datos geoespaciales/clase15-6-22/elevacion.asc")
writeRaster(grano, "C:/Users/gf0604-1/datos geoespaciales/clase15-6-22/grano.tif")

# Consulta de la RAT
levels(grano)

# Nuevo factor
levels(grano) = data.frame(value = c(0, 1, 2), wetness = c("mojado", "húmedo", "seco"))

# Consulta de la RAT
levels(grano)

# Creación de subconjuntos

# Celda en la fila 1, columna 1
elevacion[1, 1]

elevacion[]

# Celda con ID = 1
elevacion[1]

# Valores de un objeto raster
values(elevacion)

# Modificación de una celda
elevacion[1, 1] = 0

# Consulta de todos los valores del raster (equivalente a values())
elevacion[]

# Modificación de rangos de celdas
elevacion[1, c(1, 2)] = 0

elevacion[1, 1:6] = 0
elevacion[2, 1:6] = 10
elevacion[3, 1:6] = 15
elevacion[4, 1:6] = 15
elevacion[5, 1:6] = 20
elevacion[6, 1:6] = 35

# Consulta de los valores
elevacion[]

# Resumen y sumarización de información

# Información general
elevacion

# Resumen de un raster de una capa
summary(elevacion)

# Desviación estándar
global(elevacion, sd)

# Tabla de frecuencias
freq(grano)

# Histograma
hist(elevacion)


# Densidad
density(elevacion)
