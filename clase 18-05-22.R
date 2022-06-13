# Tidyverse: colección de paquetes para ciencia de datos

## Gráficos de dispersión

# ggplot2
library(tidyverse)
library(palmerpenguins)

# Gráfico de dispersión de longitud del pico vs masa (peso)
ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g)) + 
  geom_point(size = 0.5) +
  geom_smooth(method = "lm") +
  ggtitle("Longitud del pico vs Masa (peso)") +
  xlab("Longitud del pico (mm)") +
  ylab("Masa (g)") +
  labs(color = "Especie", shape = "Especie")

## Gráfico de dispersión de longitud del pico vs masa (peso) por especie
ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species,
                 shape = species),
             size = 2) +
  geom_smooth(method = "lm", se = FALSE, aes(color = species)) +
  scale_color_manual(values = c("darkorange", "darkorchid", "cyan4")) +
  ggtitle("Longitud del pico vs. masa por especie") +
  xlab("Longitud del pico (mm)") +
  ylab("Masa (g)") +
  labs(color = "Especie", shape = "Especie")

### Nota: (aes-funcion para llamar linea) (ggtitle-para poner titulo) (xlab-eje x, ylab-eje y) (labs- etiqueta para cada color) (scale color manual-color por defecto)

# Histogramas. Este tipo de gráficos muestra distribuciones de variables.
## NOTA ( solo se solicita la variable de las x por ser un histograma, para y= la cantidad de pinguinos)

## Distribución de la variable de masa (peso)
ggplot(data = penguins, aes(x = body_mass_g)) +
  geom_histogram() +
  ggtitle("Distribución de la variable masa (peso)") +
  xlab("Masa (g)") +
  ylab("n")

## Distribución de la variable de masa (peso) por especie
ggplot(data = penguins, aes(x = body_mass_g)) +
  geom_histogram(aes(fill = species), alpha = 0.5, position = "identity") +
  scale_fill_manual(values = c("darkorange","darkorchid","cyan4")) +
  ggtitle("Distribución de la variable masa (peso) por especie") +
  xlab("Masa (g)") +
  ylab("n") +
  labs(fill = "Especie")

# Diagramas de caja
### Este tipo de gráficos muestra datos a través de sus cuartiles.

# Diagrama de caja de la variable masa (peso)
ggplot(data = penguins, aes(y = body_mass_g)) +
  geom_boxplot() +
  ylab("Masa (g)")

# Diagrama de caja de la variable masa (peso) por especie
ggplot(data = penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot(aes(color = species), width = 0.3, show.legend = FALSE) +
  scale_color_manual(values = c("darkorange","purple","cyan4")) +
  xlab("Especie") +
  ylab("Masa (g)")

# Datos tidy (organización de los datos en estructuras rectangulares de filas y columnas)

## Tibbles

### Clase del conjunto de datos penguins
class(penguins)

### Impresión del tibble penguins (funcion print-despliega solamente las 10 primeras filas del tibble y una cantidad limitada de columnas)
print(penguins)

### Impresión del tibble penguins con 15 filas y todas las columnas
print(penguins, n=15, width = Inf)

## Pipes (tuberías- (%>%) evita anidacion de funciones o llamar cada funcion cuando hay muchas)

# Cadena de "pipes" entre funciones de Tidyverse
## Nota-
penguins %>%
  dplyr::filter(species == "Gentoo") %>% # subconjunto de observaciones
  select(species, bill_length_mm, flipper_length_mm) # subconjunto de columnas

# Una alternativa a los pipes es la anidación de llamados a funciones(poner un funcion dentro de otra):
## Llamados anidados a funciones
select(filter(penguins, species == "Gentoo"),
       bill_length_mm,
       flipper_length_mm)

View(select(
  dplyr::filter(penguins, species == "Gentoo"),
  species,
  sex,
  island
))

# TEMA: dplyr: gramática para manipulación de datos
##Funciones
# Selección de las columnas de especie, longitud del pico y sexo
penguins %>%
  select(species, bill_length_mm, sex) 

# Selección y cambio de nombre de las columnas de especie, longitud del pico y sexo
  penguins %>%
    select(especie = species,
           longitud_pico_mm = bill_length_mm,
           sexo = sex)
  
# Selección de las columnas en el rango de species a flipper_length_mm
  penguins %>%
    select(species:flipper_length_mm)

## ejemplo de llamamientos
  Selet(penguins, species:sex) %>% View()
  
# Selección de las columnas numéricas
  penguins %>%
    select(where(is.numeric))

# filter()

# Filas de la especie 'Adelie' con longitud del pico mayor o igual a 45 mm
  penguins %>%
    filter(species == 'Adelie' & bill_length_mm >= 45)
  
# Filas de las especie 'Adelie' o 'Gentoo'
  penguins %>%
    filter(species == 'Adelie' | species == "Gentoo")
  
# Filas de especies diferentes a 'Chinstrap'
  penguins %>%
    filter(!(species == 'Chinstrap'))
  
# Filas con longitud del pico mayor o igual al promedio
  penguins %>%
    filter(bill_length_mm >= mean(bill_length_mm, na.rm = TRUE))
  
# Filas con longitud del pico mayor o igual al promedio
  #   El argumento lógico na.rm de mean() indica si los valores NA ("not available") 
  #   deben ser removidos antes del cálculo
  penguins %>%
    filter(bill_length_mm >= mean(bill_length_mm, na.rm = TRUE))

# Condiciones relacionadas con valores NA:
# Filas con valor NA en la columna sex
  penguins %>%
    select(species, island, sex) %>%
    filter(is.na(sex))
  
#La función drop_na() remueve las filas con valores NA en una o varias columnas.
# Filas con valor diferente a NA en la columna sex
  penguins %>%
    select(species,
           bill_length_mm,
           bill_depth_mm,
           flipper_length_mm,
           body_mass_g,
           sex) %>%
    drop_na(sex)

# ejemplos
mean(penguins$bill_length_mm, na.rm = TRUE)

penguins %>%
  filter(bill_length_mm >= mean(bill_length_mm, na.rm = TRUE)) %>%
  select(species, island, sex) %>%
  View()


# arrange() {cambia el orden de las filas de un data frame}

# Ordenamiento ascendente por las columnas 'bill_lenght_mm' y 'bill_depth_mm'
penguins %>%
  arrange(bill_length_mm, bill_depth_mm) %>%
  View
# Ordenamiento descendente por las columnas 'bill_lenght_mm' y 'bill_depth_mm'
penguins %>%
  arrange(desc(bill_length_mm), desc(bill_depth_mm)) %>%
  View
# La función across() aplica una función en múltiples columnas.
# Ordenamiento ascendente por las columnas que empiezan con 'bill'
penguins %>%
  arrange(across(starts_with('bill')))

# Ordenamiento ascendente por las columnas que contienen la hilera 'lenght'
penguins %>%
  arrange(across(contains('length')))

# Función mutate()
# Creación de la columna 'body_mass_kg' con el valor de 'body_mass_g' expresado en kg
penguins %>%
  select(species, body_mass_g) %>%
  mutate(body_mass_kg = body_mass_g/1000)

# Creación de la columnas 'body_mass_g_mean' (promedio de masa) 
# y 'body_mass_g_normalized' (proporción con respecto al promedio)
penguins %>%
  select(species, body_mass_g) %>%
  mutate(body_mass_g_mean = mean(body_mass_g, na.rm = TRUE)) %>%
  mutate(body_mass_g_normalized = body_mass_g / body_mass_g_mean) %>%
  view()
#La función group_by() agrupa una o más columnas.
# Creación de la columnas 'body_mass_g_mean_species' (promedio de masa de la especie) 
# y 'body_mass_g_species_normalized' (proporción con respecto al promedio de masa de la especie)
penguins %>%
  select(species, body_mass_g) %>%
  group_by(species) %>%
  mutate(body_mass_g_mean_species = mean(body_mass_g, na.rm = TRUE)) %>%
  mutate(body_mass_g_species_normalized = body_mass_g / body_mass_g_mean_species) %>%
  View()


# REPASO 23/5/22


library(tidyverse)
library(palmerpenguins)

# ## Ejemplo: mutate()
penguins_2 <-
  penguins %>%
  select(species, body_mass_g) %>%
  mutate(body_mass_kg = body_mass_g / 1000)

View(penguins_2)


mean(penguins$body_mass_g, na.rm = TRUE)
# El na.rm en true sirve para que si se pueda calcular la media aunque hayan valores en na en los datos del paquete


penguins %>%
  select(species, body_mass_g) %>%
  mutate(
    body_mass_g_mean = mean(body_mass_g, na.rm = TRUE),
    body_mass_g_normalized = body_mass_g / body_mass_g_mean
  ) %>%
  View()


penguins %>%
  select(species, body_mass_g) %>%
  group_by(species) %>%
  mutate(
    body_mass_g_mean_species = mean(body_mass_g, na.rm = TRUE),
    body_mass_g_species_normalized = body_mass_g / body_mass_g_mean_species
  ) %>%
  View()


## Ejemplo: summarise()
penguins %>%
  summarise(body_mass_g_mean = mean(body_mass_g, na.rm = TRUE),
            n = n()) %>%
  View()

penguins %>%
  group_by(species) %>%
  summarise(body_mass_g_mean = mean(body_mass_g, na.rm = TRUE),
            n = n()) %>%
  View()

# Sumarización con agrupamiento:
penguins %>%
  group_by(species) %>%
  summarise(
    body_mass_g_min = min(body_mass_g, na.rm = TRUE),
    body_mass_g_max = max(body_mass_g, na.rm = TRUE),
    body_mass_g_mean = mean(body_mass_g, na.rm = TRUE),
    n = n()
    
    # EJERCICIO: count()
    
    penguins %>%
      count(species) %>%
      view()
    
    ## Ejercicio
    penguins %>%
      select(species, body_mass_g, sex) %>%
      group_by(species,sex) %>%
      mutate(
        body_mass_g_mean_species_sex = mean(body_mass_g, na.rm = TRUE),
        body_mass_g_species_normalized_sex = body_mass_g / body_mass_g_mean_species_sex
      ) %>%
      View()
    



    









