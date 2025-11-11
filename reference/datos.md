# Datos meteorologicos de ejemplo

Conjunto de mediciones simuladas por estacion y fecha para usar en los
ejemplos del paquete.

## Usage

``` r
datos
```

## Format

Data frame con 3 columnas:

- id:

  codigo de estacion (character).

- fecha:

  fecha de observacion (Date).

- temperatura_abrigo_150cm:

  temperatura del aire a 1.5 m en grados Celsius (numeric).

## Source

Datos simulados para la materia.

## Details

Este dataset esta pensado para las funciones
[`grafico_temperatura_mensual()`](https://bcampdepadros.github.io/paquetemeteorologico/reference/grafico_temperatura_mensual.md)
y
[`tabla_resumen_temperatura()`](https://bcampdepadros.github.io/paquetemeteorologico/reference/tabla_resumen_temperatura.md),
que esperan exactamente estas columnas.
