#' Mask Multifile Raster
#'
#' Tạo mask và cắt nhiều ảnh Raster
#'
#' @param path đường dẫn chứa ảnh
#' @param path_result đường dẫn chứa kết quả ảnh
#' @param vector_shp dữ liệu vector (ESRI Shapefiles)
#' @return kết quả ảnh
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