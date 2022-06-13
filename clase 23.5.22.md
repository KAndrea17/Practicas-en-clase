# TEMA NUEVO-Paquetes de R para graficación estadística

library(ggplot2)
library(plotly)

library(readr)
library(dplyr)


# mtcars
# Instalación del paquete DT
install.packages("DT")

library(DT)

datatable(mtcars)

## # Transformación de datos de mtcars

mtcars <-
  mtcars %>%
  select(mpg, cyl, disp, hp, wt)

# Visualización de datos de mtcars en formato tabular
mtcars %>%
  datatable(options = list(
    pageLength = 5,
    language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json')
  ))

### covid-19

covid_nacional <-
read_delim(file = C:\Users\gf0604-1\R\23-5-22 casos covid nacional/05_17_22_CSV_GENERAL)










