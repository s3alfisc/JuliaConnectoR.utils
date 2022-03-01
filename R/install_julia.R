#'
#' Install Julia.
#'
#' @param prefix the directory where Julia will be installed.
#'     If not set, a default location will be determined by \code{rappdirs}
#'     if it is installed, otherwise an error will be raised.
#'
#' @export
install_julia <- function(prefix = JuliaCall:::julia_default_install_dir()){

  JuliaCall::install_julia(prefix = JuliaCall:::julia_default_install_dir())

}
