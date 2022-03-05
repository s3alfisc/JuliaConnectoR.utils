check_julia_system_requirements <- function(r_pkg){

  #' Checks if the used version of Julia and installed verion of a Julia
  #' package are aligned with the requirements in the package's description file.
  #'@param r_pkg The name of a package. The specified package's
  #'               description file is checked for a required Julia and package version number
  #'@importFrom stringr str_detect str_extract
  #'@importFrom utils packageDescription capture.output
  #'
  #'@examples
  #'check_julia_system_requirements("fwildclusterboot")
  #'
  #'@export

  pkg_info <- utils::packageDescription(r_pkg)
  system_requirements <- unlist(strsplit(pkg_info$SystemRequirements, ","))

  julia_requirements <- system_requirements[1]
  julia_pkg_nv <- stringr::str_squish(system_requirements[2:length(system_requirements)])
  n_julia_pkg <- length(julia_pkg_nv)

  # edge case: no package version required
  julia_pkg_nv <- unlist(strsplit(julia_pkg_nv, " "))

  which_package <- which(str_right(julia_pkg_nv, 3) == ".jl")
  julia_pkg_n <- julia_pkg_nv[which_package]
  julia_pkg_v <- julia_pkg_nv[which(julia_pkg_nv != julia_pkg_n)]

  if(length(julia_pkg_v) != 0 && !(length(julia_pkg_n) %in% c(length(julia_pkg_v), 2*length(julia_pkg_v)))){
    stop("check_system_requirements() can currently only perform checks on packages where all Julia dependencies have either a specified version number or no Julia package has a specified version number.")
  }

  # julia version info
  versioninfo <- capture.output(JuliaConnectoR::juliaEval("versioninfo()"))
  julia_version <- stringr::str_extract(versioninfo[1], "\\d+\\.*\\d*\\.*\\d*")

  julia <- stringr::str_squish(system_requirements[which(stringr::str_detect(system_requirements, "Julia"))])
  julia_version_required <- stringr::str_extract(julia, "\\d+\\.*\\d*\\.*\\d*")
  if(julia_version < julia_version_required){
    message(paste("The required Julia version is", julia_version_required, ", but the current Julia version is", julia_version, ". Please upgrade Julia."), "\n")
  } else {
    message("The current Julia version fulfills the SystemRequirements specified in Description.", "\n")
  }

  # need to drop .jl suffix else Julia.Pkg.status fails
  if(stringr::str_sub(julia_pkg_n, start= -3) == ".jl"){
    julia_pkg_n <- stringr::str_sub(julia_pkg_n, end=-4)
  }

  # if there are any julia package requiremens ...
  if(length(n_julia_pkg) != 0){
    # get installed package version
    JuliaConnectoR::juliaEval("using Pkg")

    for(x in seq_along(julia_pkg_n)){

      if(!is.na(julia_pkg_v[x])){
        julia_pkg_version <- capture.output(JuliaConnectoR::juliaEval(paste0('Pkg.status("', julia_pkg_n[x], '")')))[2]
        julia_pkg_version <- stringr::str_squish(julia_pkg_version)
        julia_pkg_version <- unlist(strsplit(julia_pkg_version, " "))[3]
        # drop first element
        julia_pkg_version <- stringr::str_sub(julia_pkg_version, start=+2)

        # get package requirements
        julia_pkg_version_required <- stringr::str_extract(julia_pkg_v, "\\d+\\.*\\d*\\.*\\d*")
        if(julia_pkg_version < julia_pkg_version_required){
          message(paste("The required version of", paste0(julia_pkg_n[x], ".jl"), "is", julia_pkg_version_required, ", but the current Julia version is", julia_pkg_version, ". Please upgrade Julia."), "\n")
        } else {
          message(paste("The installed version of", paste0(julia_pkg_n[x], ".jl"), "fulfills the SystemRequirements specified in Description."), "\n")
        }
      }
    }
    if(sum(is.na(julia_pkg_v)) == length(julia_pkg_v)){
      message("No version requirements for all Julia packages.", "\n")
    }
  }

}

str_right <- function(string, n) {
  substr(string, nchar(string) - (n - 1), nchar(string))
}
