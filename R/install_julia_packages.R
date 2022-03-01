install_julia_packages <- function(packages){

  #' @param Character Vector. The Julia packages to be installed
  #' @examples
  #' packages <- c("WildBootTests", "FixedEffectModels")
  #' install_julia_packages(packages)

  JuliaConnectoR::juliaEval("using Pkg")

  lapply(packages, function(x){
    JuliaConnectoR::juliaEval(paste0('Pkg.add("', x, '")'))
  })

}

