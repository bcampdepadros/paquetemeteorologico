test_that("celsius_to_fahrenheit convierte correctamente", {
  # Prueba con valores positivos y negativos
  expect_equal(celsius_to_fahrenheit(0), 32)
  expect_equal(celsius_to_fahrenheit(100), 212)
  expect_equal(celsius_to_fahrenheit(-40), -40)
})

test_that("celsius_to_fahrenheit lanza un error si el input no es numerico", {
  # Prueba con un valor no numérico
  expect_error(celsius_to_fahrenheit("20"), "La temperatura debe ser numerica.")
})
