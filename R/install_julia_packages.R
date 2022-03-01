install_julia_packages <- function(packages){

  #' @param Character Vector. The Julia packages to be installed
  #' @examples
  #' packages <- c("WildBootTests", "FixedEffectModels", "Random")
  #' install_julia_packages(packages)
  #' @export



  JuliaConnectoR::juliaEval("using Pkg")

  res <-
  lapply(packages, function(x){
    JuliaConnectoR::juliaEval(paste0('Pkg.add("', x, '")'))
  })

  invisible(res)

}

