#' IQR Raster
#'
#' Filter outliers based on formula IQR (InterQuartile Range)
#'
#' @param x Image file to filter out exception value
#' @param type_img Type of Image
#' @return Result image
#' @importFrom rgdal readGDAL
#' @importFrom raster raster crs coordinates writeRaster
#' @importFrom sp proj4string "proj4string<-" "gridded<-" "coordinates<-"
#' @importFrom stringr str_sub str_replace
#' @importFrom stringi stri_length
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
  sp::coordinates(rs) <- ~x+y
  sp::proj4string(rs) <- crs(proj4string(raster(x)))
  sp::gridded(rs) <- TRUE
  raster_outlier <- raster(rs)
  writeRaster(raster_outlier,
              filename <- paste("IQR_", str_sub(x, 1, stri_length(list[i]) - 4), ".tif",
                                               sep = "") , overwrite = TRUE)
}