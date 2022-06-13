library(dplyr)
library(ggplot2)
library(readr)
library(plotly)
library(DT)
library(hrbrthemes)

# Gráfico de barras apiladas
diamonds %>%
  ggplot(aes(x = cut, fill = clarity)) +
  geom_bar() +
  theme_minimal()

# Pendiente por errror
diamonds %>%
  ggplot(aes(x = cut, color = color)) +
  geom_bar() +
  theme_ft_rc() +
  scale_color_continuous(type = "gradient")

# ggplotly - Gráfico de barras apiladas de proporciones
ggplot2_barras_apiladas_proporcion <-
  diamonds %>%
  ggplot(aes(x = cut, fill = clarity)) +
  geom_bar(position = "fill") +
  ggtitle("Proporciones de claridad por tipo de corte de diamantes") +
  xlab("Corte") +
  ylab("Proporción") +
  labs(fill = "Claridad") +
  theme_minimal()

ggplotly(ggplot2_barras_apiladas_proporcion) %>% config(locale = 'es')


# Hecha por profesor
grafico_barras_agrupadas <-
  diamonds %>%
  ggplot(aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge") +
  theme_minimal()

ggplotly(grafico_barras_agrupadas)


# ggplotly - Gráfico de barras agrupadas
ggplot2_barras_agrupadas <-
  diamonds %>%
  ggplot(aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge") +
  ggtitle("Cantidad de diamantes por tipo de corte y claridad") +
  xlab("Corte") +
  ylab("Cantidad") +
  labs(fill = "Claridad") +
  theme_minimal()

ggplotly(ggplot2_barras_agrupadas) %>% config(locale = 'es')

# Histogramas
# ggplotly - histograma
ggplot2_histograma_diamantes_precio <-
  diamonds %>%
  ggplot(aes(x = price)) +
  geom_histogram(bins = 20) + # cantidad de barras (bins) +  
  ggtitle("Distribución del precio de diamantes") +
  xlab("Precio (dólares estadounidenses)") +
  ylab("Frecuencia") +
  theme_minimal()

ggplotly(ggplot2_histograma_diamantes_precio) %>% config(locale = 'es')  

# Hecha por profesor

histograma <-
diamonds %>%
  ggplot(aes(x = price)) +
  geom_histogram(bins = 10)

ggplotly(histograma)

# segundo ejemplo

histograma <-
  diamonds %>%
  ggplot(aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

ggplotly(histograma)

# ggplotly - histograma
ggplot2_histograma_diamantes_precio <-
  diamonds %>%
  ggplot(aes(x = price)) +
  geom_histogram(bins = 20) + # cantidad de barras (bins) +  
  ggtitle("Distribución del precio de diamantes") +
  xlab("Precio (dólares estadounidenses)") +
  ylab("Frecuencia") +
  theme_minimal()

ggplotly(ggplot2_histograma_diamantes_precio) %>% config(locale = 'es') 


# Variables categoricas

# ggplotly - histograma con distribución de dos valores de una variable
ggplot2_histograma_diamantes_precio_claridad <-
  diamonds %>%
  filter(clarity == "SI2" | clarity == "VS1") %>%
  ggplot(aes(x = price, fill = clarity)) +
  geom_histogram(position = "identity", alpha = 0.4) + # ancho de las barras
  ggtitle("Distribución del precio de diamantes de claridad 'SI2' y 'VS1'") +
  xlab("Precio (dólares estadounidenses)") +
  ylab("Frecuencia") +
  theme_minimal()

ggplotly(ggplot2_histograma_diamantes_precio_claridad) %>% config(locale = 'es')


# hecha pot profesor
histograma_dos_variables <-
diamonds %>%
  filter(clarity == "SI2" | clarity == "VS1") %>%
  ggplot(aes(x = price, fill = clarity)) +
  geom_histogram(position = "identity", alpha = 0.4)

ggplotly(histograma_dos_variables)

# diagramas de caja
# ggplot2 - diagrama de caja
ggplot2_diagrama_caja_mtcars_mpg <-
  mtcars %>%
  ggplot(aes(y = mpg)) +
  geom_boxplot() +
  ylab("Rendimiento (millas por galón de combustible)") +  
  theme_minimal()

ggplotly(ggplot2_diagrama_caja_mtcars_mpg) %>% config(locale = 'es')  

#hecho por profesor

diagrama_caja_mpg <-
  mtcars %>%
  ggplot(aes(y = mpg)) +
  geom_boxplot()

ggplotly(diagrama_caja_mpg)

#Diagrama anterior categorizado por variable
# ggplot2 - diagrama de caja categorizado
ggplot2_diagrama_caja_mtcars_mpg_marchas <-
  mtcars %>%
  ggplot(aes(x = factor(gear), y = mpg)) +
  geom_boxplot() +
  xlab("Cantidad de marchas") +
  ylab("Rendimiento (millas por galón de combustible)") +
  theme_minimal()

ggplotly(ggplot2_diagrama_caja_mtcars_mpg_marchas) %>% config(locale = 'es')


# hecho por profesor

mtcars %>%
  ggplot(aes(x = factor(am), y = mpg)) +
  geom_boxplot()

# Gráficos de pastel
## El paste = contatena dos hileras

n <- nrow(diamonds)

diamonds_cut <-
  diamonds %>%
  group_by(cut) %>%
  summarise(cut_count = n(), cut_pct = round(cut_count/n * 100, digits = 1))

# ggplot2 - gráfico de pastel
diamonds_cut %>%
  ggplot(aes(x = factor(1), y = cut_pct, fill = cut)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  geom_text(aes(label = paste(cut_pct, "%")), position = position_stack(vjust=0.5)) +
  scale_fill_brewer(palette = "BrBg") +
  theme_void()

# ggplot2 - gráfico de pastel
diamonds_cut %>%
  plot_ly(
    labels = ~ cut,
    values = ~ cut_count,
    type = 'pie',
    textposition = 'inside',
    textinfo = 'label+percent',
    hoverinfo = 'text',
    text = ~ paste(cut_count, ' diamantes')
  ) %>%
  layout(title = 'Proporciones de tipos de corte de diamantes') %>%
  config(locale = 'es')

# Facets
# facet_wrap() (divide el grafico con una sola variable)
diamonds %>%
  ggplot(aes(x = carat, y = price)) +
  geom_point() +
  xlab("Peso (quilates)") +
  ylab("Precio (dólares estadounidenses)") +
  facet_wrap(~ cut, nrow = 2)

#Hecho por profesor
diamonds %>%
  ggplot(aes(x = carat, y = price)) +
  geom_point() +
  facet_wrap(~ cut, ncol = 2, nrow = 3)

#facet_grid()
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price)) + 
  xlab("Peso (quilates)") +
  ylab("Precio (dólares estadounidenses)") +  
  facet_grid(cut ~ clarity)

#






