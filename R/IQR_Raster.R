#' IQR Raster
#'
#' Lọc giá trị ngoại lệ dựa trên công thức IQR (InterQuartile Range)
#'
#' @param x file ảnh cần lọc giá trị ngoại lệ
#' @return kết quả ảnh
#' @export
IQR_Raster <- function(x, type_img){
  k1 <- readGDAL(x)@data
  if (type_img == "NDVI"){
    k <- as.data.frame(k1 * 0.0001)
  } else if (type_img == "NDVI") {
    k <- as.data.frame(k1 * 0.02 - 273.15)
  } else {
    stop("You do not set up type image or type image have NULL",
      call. = FALSE)
  }
  latlong <- as.data.frame(coordinates(raster(x)))
  rs <- cbind(k,latlong)
  outliers <- boxplot(rs$band1, plot = FALSE)$out
  rs <- rs[-which(rs$band1 %in% outliers),]
  coordinates(rs) <- ~x+y
  proj4string(rs) <- crs(proj4string(raster(x)))
  gridded(rs) <- TRUE
  raster_outlier <- raster(rs)
  writeRaster(raster_outlier,
              filename <- paste("IQR_", str_sub(x, 1, stri_length(list[i]) - 4), ".tif",
                                               sep = "") , overwrite = TRUE)
}