library(testthat)
library(ggplot2)

test_that("grafico_temperatura_mensual devuelve un gráfico ggplot", {
  # Datos de prueba
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
  # Datos de prueba
  datos <- data.frame(
    id = rep(1:2, each = 12),
    fecha = rep(seq.Date(from = as.Date("2023-01-01"), by = "month", length.out = 12), 2),
    temperatura_abrigo_150cm = runif(24, min = 10, max = 25)
  )

  # Título personalizado
  titulo_personalizado <- "Temperatura Media Mensual"

  # Llamada a la función con título personalizado
  grafico <- grafico_temperatura_mensual(datos, titulo = titulo_personalizado)

  # Verificar que el título del gráfico es el esperado
  expect_equal(grafico$labels$title, titulo_personalizado)
})
