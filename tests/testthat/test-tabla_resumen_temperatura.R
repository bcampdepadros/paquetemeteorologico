# Instalar y cargar el paquete testthat si aún no lo has hecho
# install.packages("testthat")
library(testthat)
library(dplyr)

# Definir la función tabla_resumen_temperatura (deberías tener esto en tu script principal)
tabla_resumen_temperatura <- function(datos) {
  resumen <- datos %>%
    group_by(id) %>%
    summarise(
      min_temp = min(temperatura_abrigo_150cm, na.rm = TRUE),
      max_temp = max(temperatura_abrigo_150cm, na.rm = TRUE),
      mean_temp = mean(temperatura_abrigo_150cm, na.rm = TRUE)
    )
  return(resumen)
}

# Crear un conjunto de datos de ejemplo
datos_ejemplo <- data.frame(
  id = c(1, 1, 2, 2, 3, 3),
  temperatura_abrigo_150cm = c(15, 20, 10, 12, NA, 18)
)

# Iniciar las pruebas
test_that("tabla_resumen_temperatura funciona correctamente", {

  # Llamar a la función con los datos de ejemplo
  resultado <- tabla_resumen_temperatura(datos_ejemplo)

  # Comprobar la estructura del resultado
  expect_s3_class(resultado, "data.frame")

  # Comprobar que el número de filas es correcto (debe ser igual al número de estaciones)
  expect_equal(nrow(resultado), 3)

  # Comprobar que los valores de min, max y mean son correctos
  expect_equal(resultado$min_temp, c(15, 10, 18))  # Valores mínimos por id
  expect_equal(resultado$max_temp, c(20, 12, 18))  # Valores máximos por id
  expect_equal(resultado$mean_temp, c(17.5, 11, 18))  # Valores medios por id
})

# Para ejecutar las pruebas, simplemente puedes usar:
# test_file("ruta/a/tu/archivo_de_pruebas.R") o usar test_dir si tienes múltiples archivos de prueba
