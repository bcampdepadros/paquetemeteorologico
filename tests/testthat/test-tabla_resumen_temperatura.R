#' Resumen de temperatura por estacion
#'
#' Calcula minimo, maximo y promedio por estacion, ignorando NAs y
#' devolviendo el resultado ordenado por estacion.
#'
#' @param df data.frame con columnas de estacion y temperatura.
#' @param col_estacion string con el nombre de la columna de estacion.
#' @param col_temp string con el nombre de la columna de temperatura (numerica).
#'
#' @return data.frame con columnas: estacion, minimo, maximo, promedio.
#' @examples
#' data(datos, package = "paquetemeteorologico")
#' # IMPORTANTE: Usamos los nombres reales de las columnas del dataset 'datos' (id, temperatura...)
#' tabla_resumen_temperatura(datos, col_estacion = "id", col_temp = "temperatura_abrigo_150cm")
#' @export
tabla_resumen_temperatura <- function(df,
                                      col_estacion = "estacion",
                                      col_temp = "temperatura") {
  # validaciones
  if (!is.data.frame(df)) {
    cli::cli_abort("`df` debe ser un data.frame.")
  }
  if (!is.character(col_estacion) || length(col_estacion) != 1L ||
      !is.character(col_temp)     || length(col_temp)     != 1L) {
    cli::cli_abort("`col_estacion` y `col_temp` deben ser strings de longitud 1.")
  }
  if (!(col_estacion %in% names(df))) {
    cli::cli_abort("Falta la columna `{col_estacion}` en `df`.")
  }
  if (!(col_temp %in% names(df))) {
    cli::cli_abort("Falta la columna `{col_temp}` en `df`.")
  }
  if (!is.numeric(df[[col_temp]])) {
    cli::cli_abort("`{col_temp}` debe ser numerica.")
  }

  # filtrar NAs solo en columnas relevantes
  df2 <- df[!is.na(df[[col_estacion]]) & !is.na(df[[col_temp]]),
            c(col_estacion, col_temp), drop = FALSE]

  # si no queda nada, devolver tibble/df vacio con columnas correctas
  if (nrow(df2) == 0L) {
    return(data.frame(
      estacion = character(),
      minimo   = numeric(),
      maximo   = numeric(),
      promedio = numeric(),
      check.names = FALSE
    ))
  }

  est <- df2[[col_estacion]]
  vals <- df2[[col_temp]]

  aggr_min  <- tapply(vals, est, min,  na.rm = TRUE)
  aggr_max  <- tapply(vals, est, max,  na.rm = TRUE)
  aggr_mean <- tapply(vals, est, mean, na.rm = TRUE)

  out <- data.frame(
    estacion = names(aggr_min),
    minimo   = as.numeric(aggr_min),
    maximo   = as.numeric(aggr_max),
    promedio = as.numeric(aggr_mean),
    row.names    = NULL,
    check.names = FALSE
  )

  out[order(out$estacion), ]
}
