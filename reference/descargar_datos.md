# Descargar datos meteorologicos

Descarga el CSV de una estacion y lo lee a un data.frame.

## Usage

``` r
descargar_datos(
  id_estacion,
  directorio_destino = tempdir(),
  url_base = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/"
)
```

## Arguments

- id_estacion:

  ID de la estacion (ej.: NH0098, NH0046).

- directorio_destino:

  Carpeta donde guardar el CSV. Por defecto usa un tempdir seguro.

- url_base:

  URL base para descargar (argumento interno para tests).

## Value

Un data.frame con los datos descargados.
