testthat::test_that("tabla_resumen_temperatura calcula min/max/mean y ordena", {
  df <- data.frame(
    estacion    = c("B","A","A", NA),
    temperatura = c(30, 10, 20, 15)
  )
  out <- tabla_resumen_temperatura(df)
  testthat::expect_true(all(c("estacion","minimo","maximo","promedio") %in% names(out)))
  # quedan solo A y B (la fila con NA en estacion se ignora)
  testthat::expect_equal(sort(out$estacion), c("A","B"))
  testthat::expect_equal(out$minimo[out$estacion=="A"], 10)
  testthat::expect_equal(out$maximo[out$estacion=="A"], 20)
  testthat::expect_equal(out$promedio[out$estacion=="A"], 15)
})

testthat::test_that("tabla_resumen_temperatura valida columnas y tipos", {
  df_ok <- data.frame(estacion = c("X","X","Y"), temperatura = c(1, NA, 3))

  # falta columna
  testthat::expect_error(
    tabla_resumen_temperatura(df_ok[, "temperatura", drop = FALSE]),
    "Falta la columna"
  )

  # temperatura no numérica
  df_bad <- df_ok; df_bad$temperatura <- as.character(df_bad$temperatura)
  testthat::expect_error(tabla_resumen_temperatura(df_bad), "debe ser numérica")

  # nombres de columnas personalizados
  df_alt <- data.frame(id = c("X","X","Y"), temp = c(1, NA, 3))
  out2 <- tabla_resumen_temperatura(df_alt, col_estacion = "id", col_temp = "temp")
  testthat::expect_equal(sort(out2$estacion), c("X","Y"))
  testthat::expect_equal(out2$minimo[out2$estacion=="X"], 1)
})
