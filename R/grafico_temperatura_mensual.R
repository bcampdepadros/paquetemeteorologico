#' Grafico de la temperatura mensual
#'
#' Devuelve un ggplot con la temperatura promedio mensual por estacion.
#'
#' @param datos Data frame con columnas: `id`, `fecha`, `temperatura_abrigo_150cm`.
#' @param titulo Titulo del grafico (string).
#' @return Objeto ggplot.
#' @import ggplot2 dplyr lubridate
#' @export
#'
#' @examples
#' \donttest{
#' data(datos, package = "paquetemeteorologico")
#' if (all(c("estacion","temperatura") %in% names(datos))) {
#'   df <- data.frame(
#'     id    = datos$estacion,
#'     fecha = as.Date("2020-01-01") + seq_len(nrow(datos)) - 1,
#'     temperatura_abrigo_150cm = datos$temperatura
#'   )
#'   p <- grafico_temperatura_mensual(df, titulo = "Temperatura mensual promedio")
#' }
#' }
grafico_temperatura_mensual <- function(datos, titulo = "Temperatura") {
  # Validaciones minimas con {cli}
  if (!is.data.frame(datos)) {
    cli::cli_abort("`datos` debe ser un data.frame o tibble.")
  }
  req <- c("id", "fecha", "temperatura_abrigo_150cm")
  faltan <- setdiff(req, names(datos))
  if (length(faltan) > 0) {
    cli::cli_abort("Faltan columnas: {paste(faltan, collapse = ', ')}")
  }
  if (!is.character(titulo) || length(titulo) != 1) {
    cli::cli_abort("`titulo` debe ser un string de longitud 1.")
  }

  # fecha a Date si viene como texto o POSIX
  if (!inherits(datos$fecha, "Date")) {
    datos$fecha <- as.Date(datos$fecha)
    if (anyNA(datos$fecha)) cli::cli_abort("No se pudo convertir `fecha` a Date.")
  }

  datos |>
    dplyr::mutate(mes = lubridate::month(.data$fecha)) |>
    dplyr::group_by(.data$id, .data$mes) |>
    dplyr::summarise(mean_temp = mean(.data$temperatura_abrigo_150cm, na.rm = TRUE),
                     .groups = "drop") |>
    ggplot2::ggplot(ggplot2::aes(x = .data$mes, y = .data$mean_temp, color = .data$id)) +
    ggplot2::geom_line() +
    ggplot2::scale_x_continuous(breaks = 1:12) +
    ggplot2::labs(title = titulo, x = "Mes", y = "Temperatura promedio (C)", color = "Estacion") +
    ggplot2::theme_minimal()
}
