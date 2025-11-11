# Resumen de temperatura por estacion

Calcula minimo, maximo y promedio por estacion, ignorando NAs y
devolviendo el resultado ordenado por estacion.

## Usage

``` r
tabla_resumen_temperatura(
  df,
  col_estacion = "estacion",
  col_temp = "temperatura"
)
```

## Arguments

- df:

  data.frame con columnas de estacion y temperatura.

- col_estacion:

  string con el nombre de la columna de estacion.

- col_temp:

  string con el nombre de la columna de temperatura (numerica).

## Value

data.frame con columnas: estacion, minimo, maximo, promedio.

## Examples

``` r
data(datos, package = "paquetemeteorologico")
tabla_resumen_temperatura(datos, "estacion", "temperatura")
#>     estacion minimo maximo promedio
#> 1 Estacion A   22.5   22.5     22.5
#> 2 Estacion B   18.7   18.7     18.7
```
