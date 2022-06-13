# Graficación

library(readr)
library(dplyr)
library(DT)

library(ggplot2)
library(plotly)

## conjuntos de datos

mtcars <- datasets::mtcars

#mtcars

mtcars <-
  mtcars %>%
  select(mpg, cyl, disp, hp, wt, am) %>%
  mutate(am_name = ifelse(am == 0, "automatico", "manual"))


mtcars %>%
  datatable(options = list(
    pageLength = 5,
    language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json')
  ))

### covid-19
## importación de datos

covid_nacional <-
  read_delim(
    file = "C:/Users/gf0604-1/05_17_22_CSV_POSITIVOS.csv",
    delim = ";",
    col_select = c("FECHA", "positivos", "fallecidos", "RECUPERADOS", "activos")
  )

# Importación de casos positivos de covid-19 por cantón
covid_cantonal_positivos <-
  read_delim(
    file = "C:\Users\gf0604-1/05_17_22_CSV_POSITIVOS.csv",
    delim = ";",
    locale = locale(encoding = "WINDOWS-1252"), # esto es para resolver el problema con las tildes
    col_select = c("canton", "17/05/2022")
  )

## transformación de datos
covid_nacional <-
  covid_nacional %>%
  select(fecha = FECHA,
         positivos,
         fallecidos,
         recuperados = RECUPERADOS,
         activos) %>%
  mutate(fecha = as.Date(fecha, format = "%d/%m/%Y"))

## Visualización de datos nacionales de covid-19 en formato tabular

covid_nacional %>%
  datatable(options = list(
    pageLength = 5,
    language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json')
  ))

# Transformación de casos positivos de covid-19 por cantón
covid_cantonal_positivos <-
  covid_cantonal_positivos %>%
  rename(positivos = '24/05/2022')

# Visualización de casos positivos de covid-19 por cantón en formato tabular
covid_cantonal_positivos %>%
  datatable(options = list(
    pageLength = 20,
    language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json')
  ))

# Ejemplos de gráficos
## Gráficos de dispersión (scatterplot)

### graphics

# graphics - gráfico de dispersión
plot(
  x = mtcars$wt,
  y = mtcars$mpg,
  main = "Peso vs. rendimiento de automóviles",
  xlab = "Peso (miles de libras)",
  ylab = "Rendimiento (millas por galón de combustible)",
  col = mtcars$cyl
)


#### ggplot2

# ggplot2 - gráfico de dispersión
ggplot2_mtcars_dispersion <-
  mtcars %>%
  ggplot(aes(x = wt, y = mpg)) +
  geom_point(aes(color = factor(cyl))) +
  ggtitle("Peso vs. rendimiento de automóviles") +
  xlab("Peso (miles de libras)") +
  ylab("Rendimiento (millas por galón de combustible)") +
  labs(color = "Cilindros")

ggplot2_mtcars_dispersion


#### plotly

# plotly - gráfico de dispersión
mtcars %>%
  plot_ly(x = ~ wt,
          y = ~ mpg,
          color = ~ factor(cyl)) %>% layout(
            title = "Peso vs. rendimiento de automóviles",
            xaxis = list(title = "Peso (miles de libras)"),
            yaxis = list(title = "Rendimiento (millas por galón de combustible)")
          ) %>% layout(legend = list(title = list(text = "Cilindros"))) %>% config(locale = 'es')

#### ggplotly

# ggplotly - gráfico de dispersión
ggplotly(ggplot2_mtcars_dispersion) %>% config(locale = 'es')

# Gráficos de línea

# graphics - gráfico de línea






















