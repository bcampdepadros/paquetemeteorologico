#' Datos meteorologicos de ejemplo
#'
#' Conjunto de mediciones simuladas por estacion y fecha para usar en los
#' ejemplos del paquete.
#'
#' @format Data frame con 3 columnas:
#' \describe{
#'   \item{id}{codigo de estacion (character).}
#'   \item{fecha}{fecha de observacion (Date).}
#'   \item{temperatura_abrigo_150cm}{temperatura del aire a 1.5 m en grados
#'   Celsius (numeric).}
#' }
#'
#' @details Este dataset esta pensado para las funciones
#' \code{grafico_temperatura_mensual()} y
#' \code{tabla_resumen_temperatura()}, que esperan exactamente estas columnas.
#'
#' @source Datos simulados para la materia.
"datos"
