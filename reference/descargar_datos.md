# Descargar datos meteorologicos

Descarga el CSV de una estacion y lo lee a un data.frame.

## Usage

``` r
descargar_datos(id_estacion, directorio_destino = tempdir())
```

## Arguments

- id_estacion:

  ID de la estacion (ej.: NH0098, NH0046, NH0437, NH0472, NH0910).

- directorio_destino:

  Carpeta donde guardar el CSV. Por defecto usa un tempdir seguro.

## Value

Un data.frame con los datos descargados.
