
<!-- README.md is generated from README.Rmd. Please edit that file -->

# JuliaConnectoR.utils

<!-- badges: start -->
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

install_julia() # install Julia
connect_julia_r() # instructions to connect Julia and R
install_julia_packages("WildBootTests.jl") # install WildBootTests.jl
set_julia_ntreads() # instructions to set nthreads for Julia
```
