#' Descargar datos meteorológicos
#'
#' La función `descargar_datos` toma el ID de una estación y descarga un archivo CSV con los datos meteorológicos.
#' Por defecto, se guardará en un directorio temporal seguro, pero se puede especificar otro destino.
#'
#' @param id_estacion ID de la estación meteorológica. Los posibles son: NH0098, NH0046, NH437, NH472 y NH0910.
#' @param directorio_destino Directorio donde se guardará el archivo CSV. Por defecto, se usa un directorio temporal.
#'
#' @return Un data.frame con los datos meteorológicos de la estación.
#' Además, se guarda un archivo CSV en el directorio especificado.
#'
#' @import readr
#' @importFrom utils download.file
#' @export
#'
#' @examples
#' # Descargar datos de la estación NH0098 en un directorio temporal:
#' datos <- descargar_datos("NH0098")
#'
#' # O especificar un directorio personalizado:
#' # datos <- descargar_datos("NH0098", "mi_carpeta")

descargar_datos <- function(id_estacion, directorio_destino = tempdir()) {
  url_repositorio <- "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/"
  estacion_url <- paste0(url_repositorio, id_estacion, ".csv")

  # Crear el directorio si no existe
  if (!dir.exists(directorio_destino)) {
    dir.create(directorio_destino, recursive = TRUE)
  }

  # Crear la ruta completa para el archivo de destino
  ruta_archivo <- file.path(directorio_destino, paste0(id_estacion, ".csv"))

  # Descargar el archivo
  utils::download.file(url = estacion_url, destfile = ruta_archivo, quiet = TRUE)

  # Leer el archivo CSV
  datos <- readr::read_csv(ruta_archivo, show_col_types = FALSE)

  return(datos)
}
