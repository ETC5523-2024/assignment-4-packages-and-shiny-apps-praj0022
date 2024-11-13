#' Launch Coping Methods Shiny App
#'
#'This function launches the Shiny app named copingmethods_app included in the copingmethods package.
#'
#' @return No return value. This function is called for its side effects (launching the Shiny app).
#' @export
#'
#' @importFrom shiny  runApp
#'
#'
launch_copingmethods <- function() {
  app_dir <- system.file("copingmethods_app", package = "copingmethods")
  if (app_dir == "") {
    stop("Could not find the Shiny app directory. Try re-installing `copingmethods`.", call. = FALSE)
  }
      runApp(app_dir, display.mode = "normal")
}
