testthat::test_that("tabla_resumen_temperatura calcula min, max, mean y ordena", {
  df <- data.frame(estacion = c("A","A","B","B"),
                   temperatura = c(20,20,10,15))
  out <- tabla_resumen_temperatura(df, col_estacion = "estacion", col_temp = "temperatura")

  testthat::expect_true(all(c("estacion","minimo","maximo","promedio") %in% names(out)))

  filaA <- out[out$estacion == "A", ]
  testthat::expect_equal(
    unname(unlist(filaA[1, c("minimo","maximo","promedio")], use.names = FALSE)),
    c(20, 20, 20)
  )

  filaB <- out[out$estacion == "B", ]
  testthat::expect_equal(
    unname(unlist(filaB[1, c("minimo","maximo")], use.names = FALSE)),
    c(10, 15)
  )
  testthat::expect_equal(filaB$promedio, 12.5)
})

testthat::test_that("tabla_resumen_temperatura valida columnas y tipos", {
  # temperatura no numérica
  df_bad <- data.frame(estacion = c("A","B"), temperatura = c("x","y"), stringsAsFactors = FALSE)
  testthat::expect_error(tabla_resumen_temperatura(df_bad), "debe ser numerica")

  # falta columna de estación
  df_miss <- data.frame(est = c("A"), temperatura = 1)
  testthat::expect_error(tabla_resumen_temperatura(df_miss), "Falta la columna")

  # falta columna de temperatura
  testthat::expect_error(tabla_resumen_temperatura(df_miss, col_estacion="est", col_temp="no_existe"), "Falta la columna")

  # inputs invalidos en nombres de columnas
  testthat::expect_error(tabla_resumen_temperatura(data.frame(), col_estacion=123), "strings de longitud 1")
})

testthat::test_that("tabla_resumen_temperatura ignora NAs y maneja df vacio", {
  # Caso con NAs
  df <- data.frame(estacion = c("A","A","A"), temperatura = c(NA, 10, NA))
  out <- tabla_resumen_temperatura(df)
  testthat::expect_equal(out$minimo[out$estacion == "A"], 10)

  # Caso donde todo es NA o vacio (Para coverage del return vacio)
  df_vacio <- data.frame(estacion = character(), temperatura = numeric())
  out_vacio <- tabla_resumen_temperatura(df_vacio)
  testthat::expect_equal(nrow(out_vacio), 0)
  testthat::expect_true("minimo" %in% names(out_vacio))
})
