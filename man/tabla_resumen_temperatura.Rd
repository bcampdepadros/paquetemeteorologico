% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tabla_resumen_temperatura.R
\name{tabla_resumen_temperatura}
\alias{tabla_resumen_temperatura}
\title{Crea una Tabla Resumen de la Temperatura Abrigo}
\usage{
tabla_resumen_temperatura(datos)
}
\arguments{
\item{datos}{data.frame de las estaciones de cuya temperatura abrigo se quiere crear una tabla resumen.}
}
\value{
Devuelve una tabla resumen de la temperatura abrigo de las estaciones ingresadas.
}
\description{
La función \code{tabla_resumen_temperatura} crea una tabla de resumen de la temperatura_abrigo_150cm para una o más estaciones.
}
\examples{
# Cargar los datos de ejemplo desde el paquete
# data_path <- system.file("data", "estaciones_merged.rda", package = "PaqueteMeteorologia")
# load(data_path)

# Llamar a la función usando los datos cargados
# tabla_resumen_temperatura(estaciones_merged)
}
