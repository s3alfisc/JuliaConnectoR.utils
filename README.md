
<!-- README.md is generated from README.Rmd. Please edit that file -->

# JuliaConnectoR.utils

<!-- badges: start -->

[![R-CMD-check](https://github.com/s3alfisc/JuliaConnectoR.utils/workflows/R-CMD-check/badge.svg)](https://github.com/s3alfisc/JuliaConnectoR.utils/actions)
<!-- badges: end -->

The goal of JuliaConnectoR.utils is to help developers and users who
work with the [JuliaConnectoR]() package to link R and Julia.

## Installation

You can install the development version of JuliaConnectoR.utils from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("s3alfisc/JuliaConnectoR.utils")
```

## Example

``` r
library(JuliaConnectoR.utils)

install_julia()
connect_julia_r()
devtools::install_github("s3alfisc/fwildclusterboot")
install_julia_packages("WildBootTests.jl")
check_julia_system_requirements("fwildclusterboot")
set_julia_nthreads()
```
