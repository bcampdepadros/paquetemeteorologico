#' Convertir grados Celsius a Fahrenheit
#'
#' Convierte una temperatura o vector de temperaturas de grados Celsius a Fahrenheit.
#'
#' @param celsius Un valor numerico o vector numerico que representa grados Celsius.
#' @return Un valor numerico o vector numerico en grados Fahrenheit.
#' @examples
#' celsius_to_fahrenheit(0)
#' celsius_to_fahrenheit(c(10, 25, 30))
#' @export
celsius_to_fahrenheit <- function(celsius) {
  if (!is.numeric(celsius)) {
    cli::cli_abort(c(
      "i" = "La temperatura debe ser numerica.",
      "x" = "El argumento ingresado es de tipo {class(celsius)}."
    ))
  }
  (celsius * 9/5) + 32
}
