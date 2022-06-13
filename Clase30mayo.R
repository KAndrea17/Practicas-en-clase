library(dplyr)
library(ggplot2)
library(readr)
library(plotly)
library(DT)
library(hrbrthemes)

## Graficos de dispersion-Repaso
mtcars <-
  mtcars %>%
  mutate(am_name = ifelse(am == 0, "automatic", "manual"))

mtcars %>%
  ggplot(mapping = aes(x = wt, y = mpg, color = am_name)) +
  geom_point()

mtcars %>%
  ggplot(aes(x = wt , y = mpg, color = factor(gear))) +
  geom_point()

Grafico_mtcars <-
  mtcars%>%
  ggplot(aes(x = wt, y = mpg, color = am_name)) +
  geom_point(aes(text = rownames(mtcars)))

ggplotly(Grafico_mtcars)


mpg %>%
  ggplot(aes(x = displ, y = hwy)) +
  geom_point()

mpg %>%
  ggplot(aes(x = displ, y = cty)) +
  geom_point()


mpg %>%
  ggplot() +
  geom_point(aes(x = displ, y = hwy, color = class))

mpg %>%
  ggplot() +
  geom_point(aes(x = displ, y = hwy, color = trans))


### Graficos de Barras

diamonds %>%
  ggplot(aes(x = cut)) +
  geom_bar() +
  theme_ipsum_es()

# Gráfico de barras simples con valores de conteo

ggplot2_barras_conteo <-
  diamonds %>%
  ggplot(aes(x = cut)) +
  geom_bar() +
  ggtitle("Cantidad de diamantes por tipo de corte") +
  xlab("Corte") +
  ylab("Cantidad") +
  theme_minimal()

ggplotly(ggplot2_barras_conteo) %>% config(locale = 'es')



#Gráfico de barras simples con valores proporcionales

ggplot2_barras_proporcion <-
  diamonds %>%
  ggplot(aes(x = cut, y = stat(prop), group = 1)) +
  geom_bar() +
  ggtitle("Proporciones de tipos de corte de diamantes") +
  xlab("Corte") +
  ylab("Proporción") +
  theme_minimal()

ggplotly(ggplot2_barras_proporcion) %>% config(locale = 'es')


# Precio promedio de diamantes por tipo de corte
diamonds %>%
  group_by(clarity) %>%
  summarise(
    price_avg = mean(price, na.rm = TRUE),
    n = n()
  )

#tamaño y precio
diamonds %>%
  ggplot(aes(x =carat, y = price)) +
  geom_point()

# comportamiento por peso
diamonds %>%
  ggplot(aes(x = x, y = price)) +
  geom_point()

#tamaño 
diamonds %>%
  ggplot(aes(x = y, y = price)) +
  geom_point()

#profundidad 
diamonds %>%
  ggplot(aes(x = z, y = price)) +
  geom_point()

# Gráfico de barras simples con promedio de una variable
ggplot2_barras_promedio <-
  diamonds %>%
  ggplot(aes(x = cut, y = price)) +
  geom_bar(stat = "summary", fun.y = "mean") +
  ggtitle("Precio promedio de diamantes por tipo de corte") +
  xlab("Corte") +
  ylab("Precio promedio (dólares estadounidenses)") +
  theme_minimal()

ggplotly(ggplot2_barras_promedio) %>% config(locale = 'es')



#Barras sin transformaciones estadísticas
# Importación de casos positivos de covid-19 por cantón
covid_cantonal_positivos <-
  read_delim(
    file = "C:/Users/gf0604-1/05_24_22_CSV_POSITIVOS.csv",
    delim = ";",
    locale = locale(encoding = "WINDOWS-1252"), # esto es para resolver el problema con las tildes
    col_select = c("canton", "24/05/2022")
  )

# Transformación de casos positivos de covid-19 por cantón
covid_cantonal_positivos <-
  covid_cantonal_positivos %>%
  rename(positivos = '24/05/2022') %>% # renombramiento de columna
  filter(!is.na(canton) & canton != "Otros") # borrado de filas con valor NA u "Otros" en la columna canton

#Barras sin transformaciones estadísticas
# ggplotly - Gráfico de barras simples con valores de "identity"
ggplot2_barras_identity <-
  covid_cantonal_positivos %>%
  slice_max(positivos, n = 15) %>% # se seleccionan los 15 cantones con mayor cantidad de casos
  ggplot(aes(x = reorder(canton, positivos), y = positivos)) +
  geom_bar(stat = "identity") +
  ggtitle("Cantidad de casos positivos de covid-19 por cantón") +
  xlab("Cantón") +
  ylab("Casos positivos") +
  coord_flip() + # se invierten los ejes para generar barras horizontales
  theme_minimal()

ggplotly(ggplot2_barras_identity) %>% config(locale = 'es')


#hecho por profesor

grafico_cantones_positivo <-
covid_cantonal_positivos %>%
  slice_max(positivos, n = 30) %>% 
  ggplot(aes(x = reorder(canton, positivos), y = positivos)) +
  geom_bar(stat = "identity") + 
  coord_flip() 
ggplotly(grafico_cantonal_positivos)

  






















