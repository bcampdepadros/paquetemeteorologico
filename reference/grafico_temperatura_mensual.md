# Grafico de temperatura mensual

Agrupa por mes (AAAA-MM) y grafica la temperatura promedio mensual.

## Usage

``` r
grafico_temperatura_mensual(df, titulo = "Temperatura mensual")
```

## Arguments

- df:

  data.frame con columna `fecha` (Date) y columna de temperatura.

- titulo:

  Titulo del grafico.

## Value

Un objeto ggplot.
