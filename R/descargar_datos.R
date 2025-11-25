#' Descargar datos meteorologicos
#'
#' Descarga el CSV de una estacion y lo lee a un data.frame.
#'
#' @param id_estacion ID de la estacion (ej.: NH0098, NH0046).
#' @param directorio_destino Carpeta donde guardar el CSV. Por defecto usa un tempdir seguro.
#' @param url_base URL base para descargar (argumento interno para tests).
#'
#' @return Un data.frame con los datos descargados.
#' @import readr
#' @import cli
#' @importFrom utils download.file
#' @export
descargar_datos <- function(id_estacion,
                            directorio_destino = tempdir(),
                            url_base = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/") {

  if (!is.character(id_estacion) || length(id_estacion) != 1L) {
    cli::cli_abort("`id_estacion` debe ser un string de longitud 1.")
  }

  # Construccion de la URL
  url <- paste0(url_base, id_estacion, ".csv")

  if (!dir.exists(directorio_destino)) {
    dir.create(directorio_destino, recursive = TRUE)
  }

  ruta <- file.path(directorio_destino, paste0(id_estacion, ".csv"))

  # Intentamos descargar. Si falla, avisamos con cli.
  tryCatch(
    {
      utils::download.file(url = url, destfile = ruta, mode = "wb", quiet = TRUE)
    },
    error = function(e) {
      cli::cli_abort("No fue posible descargar el archivo desde {.url {url}}.")
    },
    warning = function(w) {
      cli::cli_abort("Fallo la descarga (warning) desde {.url {url}}.")
    }
  )

  readr::read_csv(ruta, show_col_types = FALSE)
}
