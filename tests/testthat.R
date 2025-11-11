# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.

library(testthat)
library(paquetemeteorologico)
library(dplyr)  # <-- necesario para evitar el warning de dependencias en tests

test_check("paquetemeteorologico")
