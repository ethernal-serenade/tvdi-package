#' Savitzky Golay interface
#'
#' Windowform Savitzky Golay
#'
#' Note: Windowform Savitzky Golay have function in this Packages
#'
#' @export
Golay_GUI <- function() {
  options(guiToolkit = "tcltk")

  env <- environment()
  win <- gwindow(title = "Calculator_Golay_Savitzky")

  g <- ggroup(container = win)
  grp_path <- ggroup(container = win, horizontal = TRUE)

  env$path_inp = gfilebrowse(text = "Select Directory Input", type = "selectdir",
                             quote = FALSE, container = grp_path)
  env$path_out = gfilebrowse(text = "Select Directory Output", type = "selectdir",
                             quote = FALSE, container = grp_path)

  handler.Filter_Golay_Savitzky <- function(h) {
    path <- svalue(env$path_inp)
    path_result <- svalue(env$path_out)
    Golay_Raster(path, path_result)
  }

  gbutton("Filter", container = grp_path,
          handler = handler.Filter_Golay_Savitzky)
}