#' Gráfico de la Temperatura Mensual
#'
#' La función `grafico_temperatura_mensual` devuelve un gráfico que muestra el promedio mensual de la temperatura de abrigo.
#' @param datos data.frame a partir del cual se crearán los gráficos.
#' @param colores Colores que se utilizarán en el gráfico.
#' @param titulo Título para el gráfico.
#'
#' @return
#' Genera un gráfico de la temperatura mensual del data.frame con el título y los colores ingresados.
#'
#' @import ggplot2
#' @import dplyr
#' @import lubridate
#' @importFrom grDevices colors
#'
#' @export
#'
#' @examples
#' # Cargar los datos de ejemplo desde el paquete
#' # data_path <- system.file("data", "estaciones_merged.rda", package = "PaqueteMeteorologia")
#' # load(data_path)
#'
#' # Llamar a la función usando los datos cargados
#' # grafico_temperatura_mensual(estaciones_merged, NULL, "Temperatura Mensual Promedio")


grafico_temperatura_mensual <- function(datos, colores = NULL, titulo = "Temperatura") {
  # Asegúrate de que la columna fecha esté en el formato correcto
  datos$fecha <- as.Date(datos$fecha)  # Ajusta esto según el formato de tus datos

  # Si no se especifican colores, se generan aleatoriamente
  if (is.null(colores)) {
    colores <- sample(colors(), length(unique(datos$id)))
  }

  # Crear gráfico
  grafico <- datos |>
    mutate(mes = month(fecha)) |>
    group_by(id, mes) |>
    summarise(mean_temp = mean(temperatura_abrigo_150cm, na.rm = TRUE), .groups = 'drop') |>
    ggplot(aes(x = mes, y = mean_temp, color = id)) +
    geom_line() +
    scale_color_manual(values = colores) +
    labs(title = titulo, x = "Mes", y = "Temperatura Promedio")

  return(grafico)
}
