library(testthat)
library(ggplot2)

test_that("grafico_temperatura_mensual devuelve un gráfico ggplot", {
  # Datos de prueba estándar (con temp_abrigo_150cm)
  datos <- data.frame(
    id = rep(1:2, each = 12),
    fecha = rep(seq.Date(from = as.Date("2023-01-01"), by = "month", length.out = 12), 2),
    temperatura_abrigo_150cm = runif(24, min = 10, max = 25)
  )

  # Llamada a la función
  grafico <- grafico_temperatura_mensual(datos)

  # Verificar que el resultado es un objeto ggplot
  expect_s3_class(grafico, "ggplot")
})

test_that("grafico_temperatura_mensual permite cambiar el título del gráfico", {
  datos <- data.frame(
    id = rep(1:2, each = 12),
    fecha = rep(seq.Date(from = as.Date("2023-01-01"), by = "month", length.out = 12), 2),
    temperatura_abrigo_150cm = runif(24, min = 10, max = 25)
  )

  titulo_personalizado <- "Temperatura Media Mensual"
  grafico <- grafico_temperatura_mensual(datos, titulo = titulo_personalizado)

  expect_equal(grafico$labels$title, titulo_personalizado)
})

# --- TESTS NUEVOS PARA COVERAGE AL 90% ---

test_that("grafico funciona con columna 'temperatura' si no está la de 150cm", {
  # Este test cubre la rama 'else if ("temperatura" %in% names(df))'
  df_alt <- data.frame(
    fecha = seq.Date(from = as.Date("2023-01-01"), by = "month", length.out = 5),
    temperatura = c(20, 21, 19, 22, 20)
  )
  g <- grafico_temperatura_mensual(df_alt)
  expect_s3_class(g, "ggplot")
})

test_that("grafico falla si faltan columnas requeridas o tipos incorrectos", {
  # Caso: df no es data.frame
  expect_error(grafico_temperatura_mensual("no soy un df"), "`df` debe ser un data.frame")

  # Caso: Falta columna fecha
  df_bad <- data.frame(x = 1:5)
  expect_error(grafico_temperatura_mensual(df_bad), "Falta la columna `fecha`")

  # Caso: Fecha no es Date
  df_bad_date <- data.frame(fecha = "2023-01-01", temperatura = 20)
  expect_error(grafico_temperatura_mensual(df_bad_date), "`fecha` debe ser de clase Date")

  # Caso: Faltan ambas columnas de temperatura
  df_no_temp <- data.frame(fecha = as.Date("2023-01-01"), x = 1)
  expect_error(grafico_temperatura_mensual(df_no_temp), "Falta una columna de temperatura")

  # Caso: Temperatura no numérica
  df_temp_char <- data.frame(fecha = as.Date("2023-01-01"), temperatura = "veinte")
  expect_error(grafico_temperatura_mensual(df_temp_char), "La columna de temperatura debe ser numerica")
})
