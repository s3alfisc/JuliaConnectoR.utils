connect_julia_R <- function(){
  message("Add JULIA_BINDIR= '.../Julia-1.X.X/bin' to your renviron file and save the changes.
           Restart your R session and rerun wildboottestjlr_setup(), but skip all previously completed steps.", appendLF = FALSE)
  suppressMessages(usethis::edit_r_environ())
}
