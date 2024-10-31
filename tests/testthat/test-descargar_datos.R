# Instalar y cargar el paquete testthat si aún no lo has hecho
# install.packages("testthat")
library(testthat)
library(readr)

# Definir la función descargar_datos (deberías tener esto en tu script principal)
descargar_datos <- function(id_estacion, directorio_destino) {
  url_repositorio <- "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/"
  estacion_url <- paste0(url_repositorio, id_estacion, ".csv")

  # Verificar si el nombre del directorio está ocupado por un archivo
  if (file.exists(directorio_destino) && !dir.exists(directorio_destino)) {
    stop(paste("Error: El destino especificado", directorio_destino, "ya existe como archivo. Por favor, elige otro nombre para el directorio."))
  }

  # Crear la ruta completa para el archivo de destino
  ruta_archivo <- file.path(directorio_destino, paste0(id_estacion, ".csv"))

  # Crear el directorio si no existe
  if (!dir.exists(directorio_destino)) {
    dir.create(directorio_destino, recursive = TRUE)
  }

  # Descargar el archivo
  download.file(url = estacion_url, destfile = ruta_archivo)

  # Leer el archivo CSV
  datos <- read_csv(ruta_archivo)

  return(datos)
}
