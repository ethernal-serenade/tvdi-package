#' TVDI interface
#'
#' Windowform TVDI
#'
#' Note: Windowform TVDI have function in this Packages
#'
#' @export
TVDI_GUI <- function() {
  options(guiToolkit = "tcltk")

  env <- environment()
  win <- gwindow(title = "Calculator_TVDI")

  g <- ggroup(container = win)
  grp_path <- ggroup(container = win, horizontal = FALSE)

  env$path_ndvi = gfilebrowse(text = "Select Directory NVDI", type = "selectdir",
                             quote = FALSE, container = grp_path)
  env$path_lst = gfilebrowse(text = "Select Directory LST", type = "selectdir",
                             quote = FALSE, container = grp_path)
  env$path_result = gfilebrowse(text = "Select Directory Result", type = "selectdir",
                             quote = FALSE, container = grp_path)

  handler.TVDI <- function(h) {
    path_NDVI <- svalue(env$path_ndvi)
    path_LST <- svalue(env$path_lst)
    path_rs <- svalue(env$path_result)
    TVDI_Largefiles_process(path_NDVI, path_LST, path_rs)
  }

  gbutton("Calculator TVDI", container = grp_path,
          handler = handler.TVDI)
}