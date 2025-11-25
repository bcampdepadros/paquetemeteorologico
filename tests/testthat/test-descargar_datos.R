test_that("descargar_datos descarga y lee correctamente (simulado local)", {
  # 1. Crear un CSV falso temporal que simula ser el remoto
  dir_simulado <- tempfile()
  dir.create(dir_simulado)
  archivo_remoto <- file.path(dir_simulado, "EST_TEST.csv")

  df_dummy <- data.frame(a = 1:3, b = c("x", "y", "z"))
  write.csv(df_dummy, archivo_remoto, row.names = FALSE)

  # La url base sera "file://ruta_temporal/"
  url_base_local <- paste0("file://", dir_simulado, "/")

  # 2. Definir destino de descarga
  dest <- tempfile()

  # Limpieza al salir
  on.exit(unlink(c(dir_simulado, dest), recursive = TRUE), add = TRUE)

  # 3. Probamos la funcion pasando la url_base trucada
  resultado <- descargar_datos("EST_TEST", directorio_destino = dest, url_base = url_base_local)

  expect_s3_class(resultado, "data.frame")
  expect_equal(nrow(resultado), 3)
  expect_true(file.exists(file.path(dest, "EST_TEST.csv")))
})

test_that("descargar_datos valida argumentos", {
  expect_error(descargar_datos(123), "debe ser un string")
})
