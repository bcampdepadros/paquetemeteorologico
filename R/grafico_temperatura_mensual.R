#' Grafico de temperatura mensual
#'
#' Agrupa por mes (AAAA-MM) y grafica la temperatura promedio mensual.
#'
#' @param df data.frame con columna `fecha` (Date) y columna de temperatura.
#' @param titulo Titulo del grafico.
#' @return Un objeto ggplot.
#' @import ggplot2
#' @export
grafico_temperatura_mensual <- function(df, titulo = "Temperatura mensual") {
  if (!is.data.frame(df)) {
    cli::cli_abort("`df` debe ser un data.frame.")
  }
  if (!("fecha" %in% names(df))) {
    cli::cli_abort("Falta la columna `fecha`.")
  }
  if (!inherits(df$fecha, "Date")) {
    cli::cli_abort("`fecha` debe ser de clase Date.")
  }

  # Elegir la columna de temperatura segun disponibilidad
  col_temp <- NULL
  if ("temperatura" %in% names(df)) {
    col_temp <- "temperatura"
  } else if ("temperatura_abrigo_150cm" %in% names(df)) {
    col_temp <- "temperatura_abrigo_150cm"
  } else {
    cli::cli_abort("Falta una columna de temperatura: use `temperatura` o `temperatura_abrigo_150cm`.")
  }

  if (!is.numeric(df[[col_temp]])) {
    cli::cli_abort("La columna de temperatura debe ser numerica.")
  }

  # Resumen por mes (AAAA-MM)
  mes <- format(df$fecha, "%Y-%m")
  agg <- stats::aggregate(df[[col_temp]],
                          by = list(mes = mes),
                          FUN = mean, na.rm = TRUE)
  names(agg)[2] <- "temp_prom"

  # Eje X ordenado cronologicamente
  agg$mes <- factor(agg$mes, levels = sort(unique(agg$mes)), ordered = TRUE)

  ggplot2::ggplot(agg, ggplot2::aes(x = mes, y = temp_prom, group = 1)) +
    ggplot2::geom_line() +
    ggplot2::geom_point() +
    ggplot2::labs(
      x = "Mes",
      y = "Temperatura promedio",
      title = titulo
    ) +
    ggplot2::theme_minimal()
}

utils::globalVariables("temp_prom")
