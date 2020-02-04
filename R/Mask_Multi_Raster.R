#' Mask Multifile Raster
#'
#' Create a mask and crop multiple raster images
#'
#' @param path The path contains the images
#' @param path_result The path contains the result images
#' @param vector_shp vector data (ESRI Shapefiles)
#' @return Result images
#' @export
Mask_Multi_Raster <- function(path, path_result, vector_shp){
  setwd(path)
  list = list.files(path, pattern = "*.tif$")

  if (vector_shp == "") {
      for (i in 1:length(list)) {
        cropped <- raster(list[i])
        writeRaster(cropped, filename <- paste(path_result, "/", "Mask_",
                                       str_sub(list[i], 1, stri_length(list[i]) - 4), ".tif",
                                               sep = "") , overwrite = TRUE)
      }
  } else {
      vector_shp <- readOGR(vector_shp)
      for (i in 1:length(list)) {
        masked <- mask(raster(list[i]), vector_shp)
        cropped <- crop(masked,extent(vector_shp))
        writeRaster(cropped, filename <- paste(path_result, "/", "Mask_",
                                       str_sub(list[i], 1, stri_length(list[i]) - 4), ".tif",
                                               sep = "") , overwrite = TRUE)
      }
  }
}