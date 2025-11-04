# tests/testthat/test-descargar_datos.R

testthat::test_that("descargar_datos descarga y lee un CSV válido", {
  testthat::skip_if_offline()
  testthat::skip_on_ci()

  id <- "NH0098"
  tmp <- withr::local_tempdir()

  df <- suppressWarnings(descargar_datos(id_estacion = id, directorio_destino = tmp))


  testthat::expect_s3_class(df, "data.frame")
  testthat::expect_true(nrow(df) > 0)

  esperadas <- c("fecha", "temperatura_abrigo_150cm")
  testthat::expect_true(all(esperadas %in% names(df)))
})

testthat::test_that("descargar_datos crea el archivo en el destino indicado", {
  testthat::skip_if_offline()
  testthat::skip_on_ci()

  id <- "NH0098"
  tmp <- withr::local_tempdir()

  df <- suppressWarnings(descargar_datos(id_estacion = id, directorio_destino = tmp))
  # <- sin "_"

  ruta <- file.path(tmp, paste0(id, ".csv"))
  testthat::expect_true(file.exists(ruta))
})
