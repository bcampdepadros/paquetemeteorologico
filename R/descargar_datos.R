#' Descargar datos meteorologicos
#'
#' Descarga el CSV de una estacion y lo lee a un data.frame.
#'
#' @param id_estacion ID de la estacion (ej.: NH0098, NH0046, NH0437, NH0472, NH0910).
#' @param directorio_destino Carpeta donde guardar el CSV. Por defecto usa un tempdir seguro.
#'
#' @return Un data.frame con los datos descargados.
#' @import readr
#' @importFrom utils download.file
#' @export
descargar_datos <- function(id_estacion, directorio_destino = tempdir()) {
  if (!is.character(id_estacion) || length(id_estacion) != 1L) {
    stop("`id_estacion` debe ser un string de longitud 1")
  }

  url_base <- "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/"
  url <- paste0(url_base, id_estacion, ".csv")

  if (!dir.exists(directorio_destino)) {
    dir.create(directorio_destino, recursive = TRUE)
  }

  ruta <- file.path(directorio_destino, paste0(id_estacion, ".csv"))

  utils::download.file(url = url, destfile = ruta, mode = "wb", quiet = TRUE)

  readr::read_csv(ruta, show_col_types = FALSE)
}
