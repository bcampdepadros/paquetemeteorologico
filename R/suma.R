#' suma dos numeros
#'
#'
#'Esta funcion toma dos numeros y los suma
#'
#' @param x
#' @param y
#'
#' @return
#' @export
#'
#' @examples
suma <- function(x = 2, y = 2) {

  if (!is.numeric(x) | !is.numeric(y)) {

    cli::cli_abort(c(
      "i" = "los argumentos deben ser numericos.",
      "x" = "x es {class(x)}, y es {class(y)}"
    ))
  }

  if (sign(x) < 0 | sign(y)  < 0) {
    cli::cli_abort(c(
      "i" = "No puedo sumar negativos."
    ))
  }

  x + y
}

# usethis::use_data(datos)
