#' Resumen de temperatura por estación
#'
#' Calcula mínimo, máximo y promedio por estación, ignorando NAs y ordenando por estación.
#'
#' @param df data.frame con columnas de estación y temperatura.
#' @param col_estacion nombre de la columna de estación (string).
#' @param col_temp nombre de la columna de temperatura (numérica).
#'
#' @return data.frame con columnas: estacion, minimo, maximo, promedio.
#' @export
tabla_resumen_temperatura <- function(df, col_estacion = "estacion", col_temp = "temperatura") {
  stopifnot(is.data.frame(df))
  if (!is.character(col_estacion) || !is.character(col_temp))
    stop("`col_estacion` y `col_temp` deben ser nombres de columnas (strings).")
  if (!(col_estacion %in% names(df)))
    stop("Falta la columna: `", col_estacion, "`.")
  if (!(col_temp %in% names(df)))
    stop("Falta la columna: `", col_temp, "`.")

  x <- df[[col_temp]]
  if (!is.numeric(x)) stop("`", col_temp, "` debe ser numérica.")

  # Filtramos NAs en ambas columnas relevantes
  df2 <- df[!is.na(df[[col_estacion]]) & !is.na(df[[col_temp]]), c(col_estacion, col_temp), drop = FALSE]
  est <- df2[[col_estacion]]

  # Agregados base R (sin deps)
  aggr_min  <- tapply(df2[[col_temp]], est, min,  na.rm = TRUE)
  aggr_max  <- tapply(df2[[col_temp]], est, max,  na.rm = TRUE)
  aggr_mean <- tapply(df2[[col_temp]], est, mean, na.rm = TRUE)

  out <- data.frame(
    estacion = names(aggr_min),
    minimo   = as.numeric(aggr_min),
    maximo   = as.numeric(aggr_max),
    promedio = as.numeric(aggr_mean),
    row.names = NULL,
    check.names = FALSE
  )

  # Orden consistente para tests
  out[order(out$estacion), ]
}
