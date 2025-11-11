testthat::test_that("descargar_datos descarga desde file:// y lee OK", {
  # Armamos un CSV local y lo servimos vía URL file:// para ejercitar la rama de descarga
  src <- tempfile(fileext = ".csv")
  write.csv(data.frame(a = 1:3, b = c("x","y","z")), src, row.names = FALSE)
  url_file <- paste0("file://", src)

  dest <- tempfile(fileext = ".csv")
  on.exit(unlink(c(src, dest), force = TRUE), add = TRUE)

  df1 <- descargar_datos(url = url_file, destino = dest, quiet = TRUE)
  testthat::expect_s3_class(df1, "data.frame")
  testthat::expect_true(file.exists(dest))
  testthat::expect_equal(nrow(df1), 3)

  # Segunda llamada: usa la rama de "archivo ya existe" (lectura directa)
  df2 <- descargar_datos(url = url_file, destino = dest, quiet = TRUE)
  testthat::expect_equal(df2, df1)
})

testthat::test_that("descargar_datos valida argumentos y falla con URL inexistente", {
  # url no-length-1
  testthat::expect_error(descargar_datos(url = c("a","b")), "`url` debe ser un string")

  # URL file:// inexistente -> debe fallar
  bad <- paste0("file://", tempfile(fileext = ".csv"))
  testthat::expect_error(
    descargar_datos(url = bad, destino = tempfile(fileext = ".csv"), quiet = TRUE),
    "No fue posible descargar el archivo"
  )
})
