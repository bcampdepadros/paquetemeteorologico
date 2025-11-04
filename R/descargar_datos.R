#' Descargar datos meteorologicos
#'
#' Descarga el CSV de una estacion (por ID) y lo lee como tibble.
#' Por defecto guarda en un directorio temporal seguro.
#'
#' @param id_estacion ID de la estacion. Admitidos: NH0098, NH0046, NH0437, NH0472, NH0910.
#' @param directorio_destino Carpeta destino del CSV (por defecto, tempdir()).
#'
#' @return Un tibble con los datos meteorologicos de la estacion.
#' @import readr
#' @importFrom utils download.file
#' @export
#'
#' @examples
#' \donttest{
#' # Requiere internet:
#' # datos <- descargar_datos("NH0098")
#' }
descargar_datos <- function(id_estacion, directorio_destino = tempdir()) {
  ids_validos <- c("NH0098", "NH0046", "NH0437", "NH0472", "NH0910")

  if (!is.character(id_estacion) || length(id_estacion) != 1) {
    cli::cli_abort(c(
      "x" = "`id_estacion` debe ser un string de longitud 1.",
      "i" = "Ejemplo: 'NH0098'."
    ))
  }
  if (!id_estacion %in% ids_validos) {
    cli::cli_abort(c(
      "x" = "ID no valido: {id_estacion}.",
      "i" = "IDs admitidos: {paste(ids_validos, collapse = ', ')}."
    ))
  }

  url_base <- "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/"
  estacion_url <- paste0(url_base, id_estacion, ".csv")

  if (!dir.exists(directorio_destino)) dir.create(directorio_destino, recursive = TRUE)

  ruta_archivo <- file.path(directorio_destino, paste0(id_estacion, ".csv"))

  ok <- try(utils::download.file(estacion_url, ruta_archivo, quiet = TRUE), silent = TRUE)
  if (inherits(ok, "try-error")) {
    cli::cli_abort(c(
      "x" = "No se pudo descargar el archivo de {id_estacion}.",
      "i" = "Verifica tu conexion o que la URL exista."
    ))
  }

  readr::read_csv(ruta_archivo, show_col_types = FALSE)
}
