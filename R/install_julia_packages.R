install_julia_packages <- function(packages){

  #' Install Julia packages from R
  #'
  #' @param Character Vector. The Julia packages to be installed
  #' @examples
  #' packages <- c("WildBootTests", "FixedEffectModels", "Random")
  #' packages <- c("WildBootTests.jl", "FixedEffectModels.jl", "Random.jl")
  #' install_julia_packages(packages)
  #' @export

  # check if packages contain .jl suffix, if yes, delete it
  packages <- stringr::str_sub(packages, end=-4)

  JuliaConnectoR::juliaEval("using Pkg")

  res <-
  lapply(packages, function(x){
    JuliaConnectoR::juliaEval(paste0('Pkg.add("', x, '")'))
  })

  invisible(res)

}

