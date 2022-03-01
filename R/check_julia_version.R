check_julia_version <- function(r_pkg, julia_pkg){

  #' Checks if the used version of Julia and installed verion of a Julia
  #' package are aligned with the requirements in the package's description file.
  #'@param r_pkg The name of a package. The specified package's
  #'               description file is checked for a required Julia and package version number
  #'@param julia_pkg The name of a Julia package.
  #'@importFrom stringr str_detect str_extract
  #'@importFrom utils packageDescription capture.output
  #'@importFrom base strsplit unlist
  #'
  #'@example check_julia_version("fwildclusterboot", "WildBootTests")
  #'
  #'@export

  versioninfo <- capture.output(JuliaConnectoR::juliaEval("versioninfo()"))
  julia_version <- stringr::str_extract(versioninfo[1], "\\d+\\.*\\d*\\.*\\d*")

  pkg_info <- utils::packageDescription("fwildclusterboot")
  system_requirements <- unlist(strsplit(pkg_info$SystemRequirements, ","))

  if(length(system_requirements) > 2){
    stop("JuliaConnectoR.utils only works with a Julia version and one Julia package.")
  }

  julia <- system_requirements[which(stringr::str_detect(system_requirements, "Julia"))]
  julia_version_required <- stringr::str_extract(julia, "\\d+\\.*\\d*\\.*\\d*")
  if(julia_version < julia_version_required){
    message(paste("The required Julia version is", julia_version_required, ", but the current Julia version is", julia_version, ". Please upgrade Julia."))
  } else {
    message("The current Julia version fulfills the SystemRequirements.")
  }

  if(!is.null(julia_pkg)){
    # get installed package version
    JuliaConnectoR::juliaEval("using Pkg")
    julia_pkg_version <- capture.output(JuliaConnectoR::juliaEval('Pkg.status("WildBootTests")'))[2]
    julia_pkg_version <- unlist(strsplit(julia_pkg_version, "v"))[2]
    # get package requirements
    julia_pkg2 <- system_requirements[which(stringr::str_detect(system_requirements, julia_pkg))]
    julia_pkg_version_required <- stringr::str_extract(julia_pkg2, "\\d+\\.*\\d*\\.*\\d*")
    if(julia_pkg_version < julia_pkg_version_required){
      message(paste("The required version of", paste0(julia_pkg, ".jl"), "is", julia_pkg_version_required, ", but the current Julia version is", julia_pkg_version, ". Please upgrade Julia."))
    } else {
      message(paste("The installed version of", paste0(julia_pkg, ".jl"), "fulfills the SystemRequirements."))

    }
  }

}
