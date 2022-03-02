connect_julia_r <- function(){

  #' Function to help connect Julia and R
  #' @export

  message("Add JULIA_BINDIR= '.../Julia-1.X.X/bin' to your renviron file and save the changes.
           Restart your R session.", appendLF = FALSE)
  suppressMessages(usethis::edit_r_environ())
}
