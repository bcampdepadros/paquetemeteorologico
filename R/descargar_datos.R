#' Descargar y leer datos CSV
#'
#' @param url URL del CSV remoto.
#' @param destino Ruta opcional donde guardar/leer el archivo. Si existe, se lee sin descargar.
#' @param quiet Logical, silencia mensajes.
#' @return data.frame con los datos leídos.
#' @export
descargar_datos <- function(
    url = "https://example.com/datos.csv",
    destino = NULL,
    quiet = TRUE
) {
  # Ruta destino por defecto (tempdir) si no se especifica
  if (is.null(destino)) {
    destino <- file.path(tempdir(), basename(url))
  }

  # Si el archivo ya existe, leemos sin descargar (facilita test unitario)
  if (file.exists(destino)) {
    if (!quiet) message("Leyendo archivo existente: ", destino)
    return(utils::read.csv(destino, stringsAsFactors = FALSE))
  }

  # Descarga con manejo de errores
  ok <- tryCatch({
    utils::download.file(url, destino, quiet = quiet, mode = "wb")
    TRUE
  }, error = function(e) {
    if (!quiet) message("Fallo la descarga: ", conditionMessage(e))
    FALSE
  })

  if (!ok || !file.exists(destino)) {
    stop("No fue posible descargar el archivo desde: ", url)
  }

  utils::read.csv(destino, stringsAsFactors = FALSE)
}
