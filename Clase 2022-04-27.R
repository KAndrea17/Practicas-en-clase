# Clase del 2022-04-27

# Funcion para desplejar lista de los conjuntos de datos
data()

# Funcion para desplejar un conjunto de datos
View(Titanic)

# Ejemplo de funciones

# Impreseion de una hilera de texto
print("Hola, mundo")
print("Hola, clase")
print("Hola, Manuel")


# Media aritmetica
mean(c(2, 3, 4, 5))

# directorio de trabajo 
getwd()

# Cambio de directorio de trabajo
setwd("c:/users/gf0604-1")
getwd()

View(cars)

# Dibujar graficos
plot(cars)

# Argumentos para titulos en los ejes

par(bg= "yellow")
plot(x=cars, 
     xlab="velocidad (MPH)", 
     ylab = "distancia (pies)",
     Main= "Datos de velocidad y distancia de frenado",
     sub= "Fuente de los datos: MCNeil, D. R. (1977)",
     pch =8, 
     cex.main=3,
     col= "blue")

# Carga del paquete stats
library(stats)

# Instalación del paquete PASWR2 (note las comillas)
install.packages("PASWR2")

library(PASWR2)

# Visualización del conjunto de datos TITANIC3
View(TITANIC3)

# Cantidades de pasajeros por clase
table(TITANIC3$pclass)

table(TITANIC3$sex)

table(TITANIC3$embarked)

table(TITANIC3$survived)

# Gráfico de barras por clase de pasajero: ejemplo 1
par(bg= "white")
barplot(
  height=table(TITANIC3$pclass),
  main="Distribución de pasajeros del Titanic por clase",
  xlab = "Clase",
  ylab = "Cantidad de pasajeros")  

# Grafico de cantidad de pasajeros por sobrevivencia: ejemplo 2
barplot(
  height=table(TITANIC3$survived),
  main="Distribución de pasajeros del Titanic por sexo",
  xlab = "Sexo",
  ylab = "Cantidad de pasajeros")



# Gráfico de barras apiladas: ejemplo 3
barplot(
  height = table(TITANIC3$survived, TITANIC3$pclass),
  main = "Distribución de pasajeros fallecidos y sobrevivientes por clase",
  xlab = "Clase",
  ylab = "Cantidad de pasajeros",
  col = c("red", "light green"))

# Leyenda
legend(
  x = "topleft",
  inset = 0.03,
  legend = c("Fallecidos", "Sobrevivientes"),
  fill = c("red", "light green"),
  horiz = TRUE)



# Gráfico de barras agrupadas: ejemplo 4
barplot(
  height = table(TITANIC3$survived, TITANIC3$pclass),
  main = "Distribución de pasajeros fallecidos y sobrevivientes por clase",
  xlab = "Clase",
  ylab = "Cantidad de pasajeros",  
  col = topo.colors(2),
  beside = TRUE
)

# Leyenda
legend(
  x = "topleft",
  inset = 0.03,
  legend = c("Fallecidos", "Sobrevivientes"),
  fill = topo.colors(2),
  horiz = TRUE
)

# EJERCICIO. Muestre la distribución de pasajeros fallecidos y sobrevivientes por sexo en un gráfico de barras apiladas.
barplot(
  height = table(TITANIC3$survived, TITANIC3$sex),
  main = "Distribución de pasajeros fallecidos y sobrevivientes por SEXO",
  xlab = "SEXO",
  ylab = "Cantidad de pasajeros",
  col = c("red", "light green"))

# Leyenda
legend(
  x = "topleft",
  inset = 0.03,
  legend = c("Fallecidos", "Sobrevivientes"),
  fill = c("red", "light green"),
  horiz = TRUE)

# EJERCICIO 2. Muestre la distribución de pasajeros fallecidos y sobrevivientes por sexo en un gráfico de barras agrupadas.
barplot(
  height = table(TITANIC3$survived, TITANIC3$sex),
  main = "Distribución de pasajeros fallecidos y sobrevivientes por sexo",
  xlab = "sexo",
  ylab = "Cantidad de pasajeros",  
  col = topo.colors(2),
  beside = TRUE
)

# Leyenda
legend(
  x = "topleft",
  inset = 0.03,
  legend = c("Fallecidos", "Sobrevivientes"),
  fill = topo.colors(2),
  horiz = TRUE)

# Tipos de datos

# Asignacion

x <- 10
x <- 30

50 -> x

x = 100

# Hilera de caracteres
nombre <- "Karina"

# Vector de hileras de caracteres
dias <- c('Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')

typeof(x)

typeof(nombre)

typeof(dias)

#CLASE 2-5-22 A LAS 10

# Tipos de datos

# Numericos

# Enteros
edad <- 35L
typeof(edad)

# Double
salario_mensual <- 500000
salario_anual<- salario_mensual * 12
print(salario_anual)
cat("salario mensual:", salario_mensual)
typeof(salario_anual)

#caracter
nombre <- "Juan"
apellido <- "Perez"

nombre_completo <- append(nombre, apellido)

print(nombre_completo)
cat(nombre, apellido)

nombre_completo_con_minusculas <-tolower(nombre_completo)
print(nombre_completo_con_minusculas)

#Logicos (booleanos)

e <- 10 > 20
print(e)

e <- 10 < 20
print(e)

# Vectores

vector_numeros <- c(10, 20, 30, 40, 50)

secuencia <- seq(from=1, to=10)
secuencia

secuencia_2_en_2 <- seq(from=1, to=10, by=2)
secuencia_2_en_2

# Vecto nombres de paises
paises <- c("Argentina", "Francia", "China", "Australia")
paises
paises[1]
paises[2]

paises[2:4]

paises[c(-1, -3, -5)]

a <- c(1, 3, 5, 7)
b <- c(2, 4, 6, 8)

c <- a + b
c

# Data frames

# Vector de nombres de paises
paises <- c("PAN", "CRI", "NIC", "SLV", "HND", "GTM", "BLZ", "DOM")

# Vector de cantidades de habitantes de cada pais (en millones)
poblaciones <- c(4.1, 5.0, 6.2, 6.4, 9.2, 16.9, 0.3, 10.6)

# Creacion de un data frame a partir de los dos vectores
poblaciones_paises <-
  data.frame(
    pais = paises,
    poblacion = poblaciones
  )
poblaciones_paises
poblaciones_paises[1, ]
poblaciones_paises[4, ]
poblaciones_paises[c(1, 2, 3), ]
poblaciones_paises[c(1, 2, 3), 2]
poblaciones_paises[2, 2]

# Columna de nombres de paises
poblaciones_paises$pais

# Columna de poblaciones de paises
poblaciones_paises$poblacion

# Lectura de archivo CSV ubicado en la Web
covid <- 
  read.csv("https://raw.githubusercontent.com/gf0604-procesamientodatosgeograficos/2022-i/main/datos/cepredenac/covid/covid-centroamericard-20210422.csv")

covid_local <-
  read.csv("C:/Users/gf0604-1/Downloads/covid-centroamericard-20210422.csv")

covid_cr_positivos <-
  read.csv("C:/Users/gf0604-1/R/04_26_22_CSV_POSITIVOS.csv", sep = ";")



covid_cr_positivos_remoto <-
  read.csv("https://raw.githubusercontent.com/KAndrea17/covid/main/04_26_22_CSV_POSITIVOS.csv", sep = ";")




# Clase de 4 del 05 del 22

# Tipos compuestos

## Factores

sexos <-c("Masculino", "Femenino", "Femenino", "Masculino")
print(sexos)

sexo <- factor(sexos)


levels(sexo)

nlevels(sexo)

table(sexo)

estado_civil <- c("Casado","Soltero", "Divorciado", "soltero" )
factor_estado_civil <- factor(estado_civil)

# Fechas

# Fecha actual
fecha_actual <- Sys.Date()
print(fecha_actual)


# Tipo de datos
typeof(fecha_actual)


# Clase
class(fecha_actual)


# Conversión de fecha en formato año-mes-día


fecha_caracter_01 <- "2020-01-01"
typeof(fecha_caracter_01)
class(fecha_caracter_01)

fecha_01 <- as.Date(fecha_caracter_01, format="%Y-%m-%d")
print(fecha_01)
typeof(fecha_01)
class(fecha_01)


# Conversión de fecha en formato día/mes/año

fecha_caracter_02 <- "31/01/2020"
fecha_02 <- as.Date(fecha_caracter_02, format="%d/%m/%Y")
fecha_02


# Diferencia entre fechas

fecha_02 - fecha_01
fecha_01 - fecha_02

# Deficion de funciones (para programarla debe ser por medio de la palabra function())

mi_funcion <- function(argumento_1, argumento_2, argumento_n) 
   # Cuerpo de la función 
  
# Ejemplo
  
  nota_final <- function(promedio_examenes,
                         promedio_proyectos,
                         promedio_tareas) {
    factor_examenes <- promedio_examenes * 0.5
    factor_proyectos <- promedio_proyectos * 0.4
    factor_tareas <- promedio_tareas * 0.1
    
    return(factor_examenes + factor_proyectos + factor_tareas)
  }

# Si ni se incluyen los nombres de los argumentos, la función asume que se ingresan en el mismo orden en el que fueron definidos
nota_final(100, 50, 0)
nota_final(100, 100, 100)
nota_final(75, 50, 100)


# El uso de los nombres de argumentos permite modificar su orden
nota_final(promedio_examenes =  100, promedio_tareas =  0, promedio_proyectos = 50)
nota_final(promedio_tareas =  100, promedio_examenes = 75, promedio_proyectos = 50)
nota_final(promedio_tareas =  100, promedio_examenes = 75)
           
#Si se desea darle al usuario la opción de omitir algunos argumentos, se les puede asignar un valor por defecto.Seguidamente, la función nota_final() se redefine asignando valores por defecto a algunos de los argumentos:

nota_final <- function(promedio_examenes,
                       promedio_proyectos = 0,
                       promedio_tareas = 0) {
  factor_examenes <- promedio_examenes * 0.5
  factor_proyectos <- promedio_proyectos * 0.4
  factor_tareas <- promedio_tareas * 0.1
  
  # Al no llamarse a la función return(), se retorna la última expresión:
  factor_examenes + factor_proyectos + factor_tareas
}

# Se utiliza el valor por defecto (0) para el argumento promedio_tareas
nota_final(promedio_examenes = 100, promedio_proyectos = 50)


# Se llama la función usando la posición del primer argumento y el nombre del segundo
nota_final(100, promedio_proyectos = 50)

#Ejercicio 1

celsius_a_fahrenheit <- function(celsius) {
  fahrenheit <- (celsius * 9/5) + 32
  
  return(fahrenheit)
}
# segundo forma de hacerlo
celsius_a_fahrenheit <- function(celsius) {
  fahrenheit <- (celsius * 9/5) + 32
  
  fahrenheit
}
# tercera forma de hacerlo
celsius_a_fahrenheit <- function(celsius) {
  return(celsius * 9/5) + 32
}


celsius_a_fahrenheit(30)
celsius_a_fahrenheit(0)
celsius_a_fahrenheit(40)
celsius_a_fahrenheit(-10)

# Ejercicio 2 fahrenheit_a_celsius() (Caso inverso del ejercicio anterior)
fahrenheit_a_celsius <- function(fahrenheit) {
  (fahrenheit -32) * 5/9
}

fahrenheit_a_celsius(86)
fahrenheit_a_celsius(32)
fahrenheit_a_celsius(104)
fahrenheit_a_celsius(14)

#Ejercicio 3  índice de masa corporal (IMC) con base en su peso (en kilogramos) y su estatura (en metros).

imc <- function(peso, estatura) {
  return(peso / estatura^2)
}

imc(52,1.57)
imc(82,1.65)

## Explicacion del profesor
imc <- function(masa, estatura) {
 masa/estatura^2
}

imc(71,1.69)

# Condicionales ( verdadera o falsa )

## La sentencia if
if (condicion) {
  # bloque de instrucciones a ejecutar si la condicion es verdadera
}
# Ejemplo
edad <- 25
if (edad >= 18) {
  print("La persona es mayor de edad")
}

edad <- 17
if (edad >= 18) {
  print("La persona es mayor de edad")
  print("La persona puede votar")
  print("La persona puede conducir automoviles")
}

#La claúsula else
edad <- 15

if (edad >= 18) {
  print("Adulto")
} else {
  print("Menor")
}

## ejercicio

if (edad >= 18) {
  print("La persona es mayor de edad")
  print("La persona puede votar")
  print("La persona puede conducir automoviles")
} else {
  print("La persona es menor de edad")
  print("La persona no puede votar")
  print("La persona no puede conducir automoviles")
}

#  La cláusula else if

edad <- 70

if (edad < 18) {
  print("Menor")
} else if (edad < 65) {
  print("Adulto")
} else {
  print("Adulto mayor")
}

edad <- 5

if (edad < 18) {
  print("Menor")
} else if (edad < 65) {
  print("Adulto")
} else {
  print("Adulto mayor")
}

edad <- 25

if (edad < 18) {
  print("Menor")
} else if (edad < 65) {
  print("Adulto")
} else {
  print("Adulto mayor")
}

edad <- 90

if (edad < 12) {
  print("Niño")
} else if (edad < 18) {
  print("Adolescente")
} else if (edad < 65) {
  print("Adulto")
} else if (edad < 18) {} else {
  print("Adulto mayor")
}

# Nota importante: Las cláusulas else if deben escribirse antes de la cláusula else, la cual es siempre la última, si es que está presente. Tanto las cláusulas else if como la cláusula else son opcionales.

# Ejercicios a realizar

interpretacion_imc <- function(interpretacion_imc){
if ( interpretacion_imc < 18.5) {
  print("Bajo peso")
} else if (interpretacion_imc < 24.9) {
  print("Normal")
} else if (interpretacion_imc <= 29.9) {
  print("Sobrepeso")
} else {
  print("Obesidad")
}
}
interpretacion_imc(15)
interpretacion_imc(23)
interpretacion_imc(26)
interpretacion_imc(32)


# resuelto por el profesor

interpretacion_imc <- function(imc) {
  if(imc < 18.5) {
     "Bajo"
  } else if (imc < 25) {
    "normal"
  } else if (imc < 30) {
     "sobrepeso"
  } else {
    "obesisad"
  } 
  
}

interpretacion_imc(15)
interpretacion_imc(22)
interpretacion_imc(30)
