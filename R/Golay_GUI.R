#' Savitzky Golay interface
#'
#' Windowform Savitzky Golay
#'
#' Note: Windowform Savitzky Golay have function in this Packages
#' @importFrom gWidgets gwindow ggroup gfilebrowse svalue gbutton
#' @import gWidgetsRGtk2
#' @export
Golay_GUI <- function() {
  options(guiToolkit = "RGtk2")

  env <- environment()
  win <- gwindow(title = "Calculator_Golay_Savitzky")

  grp_path <- ggroup(container = win, horizontal = FALSE)

  env$path_inp = gfilebrowse(text = "Select Directory Input", type = "selectdir",
                             quote = FALSE, container = grp_path)
  env$path_out = gfilebrowse(text = "Select Directory Output", type = "selectdir",
                             quote = FALSE, container = grp_path)

  handler.Filter_Golay_Savitzky <- function(h,...) {
    path <- svalue(env$path_inp)
    path_result <- svalue(env$path_out)
    Golay_Raster(path, path_result)
  }

  gbutton("Filter", container = grp_path,
          handler = handler.Filter_Golay_Savitzky)
}