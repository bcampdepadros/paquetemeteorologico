#' Gráfico de temperatura mensual
#'
#' Agrupa por mes (AAAA-MM) y grafica la temperatura promedio mensual.
#'
#' @param df data.frame con columnas `fecha` (Date) y `temperatura` (numérica).
#' @return objeto ggplot2::ggplot
#' @export
grafico_temperatura_mensual <- function(df) {
  if (!all(c("fecha", "temperatura") %in% names(df)))
    stop("Se requieren las columnas `fecha` y `temperatura`.")
  if (!inherits(df$fecha, "Date"))
    stop("`fecha` debe ser de clase Date.")
  if (!is.numeric(df$temperatura))
    stop("`temperatura` debe ser numérica.")

  # Resumen por mes (AAAA-MM)
  mes <- format(df$fecha, "%Y-%m")
  agg <- stats::aggregate(df$temperatura, by = list(mes = mes), FUN = mean, na.rm = TRUE)
  names(agg)[2] <- "temp_prom"

  p <- ggplot2::ggplot(agg, ggplot2::aes(x = mes, y = temp_prom, group = 1)) +
    ggplot2::geom_line() +
    ggplot2::geom_point() +
    ggplot2::labs(
      x = "Mes",
      y = "Temperatura promedio",
      title = "Temperatura mensual"
    ) +
    ggplot2::theme_minimal()

  p
}
