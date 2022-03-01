set_julia_ntreads <- function(){

  #' Helper function to set the number of threads for use in Julia

  message("Set the number of Julia threads as an environment variable as JULIACONNECTOR_JULIAOPTS='--threads {N|auto}', where N is either an integer or 'auto', where 'auto' sets N to the number of local CPU threads. See also the Julia documentation here https://docs.julialang.org/en/v1/manual/command-line-options/ .")
  usethis::edit_r_environ()

}
