#' Calculate Mean Raster
#'
#' Calculate Raster of TVDI index
#'
#' @param path The path contains the Raster
#' @return Result Images
#' @importFrom rgdal readGDAL
#' @importFrom raster raster coordinates crs
#' @importFrom sp proj4string "proj4string<-" "gridded<-" "coordinates<-"
#' @export
Mean_Raster <- function(path){
  setwd(path)
  list = list.files(path, pattern = "*.tif$")

  for (i in 1:length(list)) {
    x <- readGDAL(list[i])@data
  }
  for (i in 1:length(list)) {
    x[i] <- readGDAL(list[i])@data
  }
  data <- as.data.frame(x)
  latlong <- as.data.frame(coordinates(raster(list[1])))
  Mean <- rowMeans(data, na.rm = TRUE)
  dataMean <- cbind(Mean, latlong)
  sp::coordinates(dataMean) <- ~x+y
  sp::proj4string(dataMean) <- crs(proj4string(raster(list[1])))
  sp::gridded(dataMean) <- TRUE
  rasterMean <- raster(dataMean)
}