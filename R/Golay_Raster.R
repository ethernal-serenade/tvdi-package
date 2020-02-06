#' Gapfill Raster using Savitzky-Golay filtering
#'
#' Use Savitzky-Golay time filtering algorithm to fill
#' satellite images lost image elements.
#'
#' @param path The path contains the images (conditions over 30 Images)
#' @param path_result The path contains the result images
#' @return Result image
#' @importFrom rgdal readGDAL
#' @importFrom raster raster crs coordinates writeRaster
#' @importFrom sp proj4string "proj4string<-" "gridded<-" "coordinates<-"
#' @importFrom tibble add_column
#' @importFrom prospectr savitzkyGolay
#' @importFrom stringr str_sub str_replace
#' @importFrom stringi stri_length
#' @importFrom Rcpp sourceCpp
#' @import RcppArmadillo
#' @export
Golay_Raster <- function(path, path_result) {
  setwd(path)
  x.listfile <- list.files(path, pattern = ".*tif$")

  if (length(x.listfile) < 30) {
    stop("Not enough image data to implement this function",
      call. = FALSE)
  }

  for (i in 1:length(x.listfile)) {
    x <- readGDAL(x.listfile[i])@data
  }
  for (i in 1:length(x.listfile)) {
    x[i] <- readGDAL(x.listfile[i])@data
  }

  x_matrix <- as.matrix(x)
  k_matrix <- as.matrix(rowMeans(x_matrix, na.rm = T))
  x_matrix[is.na(x_matrix)] <- 0
  k_matrix[is.nan(k_matrix)] <- 0
  z_matrix <- matrix(0, nrow = nrow(x), ncol = length(x))
  sourceCpp(system.file("extdata", "Find_Count_NA_data.cpp", package = "TVDIpk"))
  z_tb <- as.data.frame(NA_data(x_matrix, z_matrix, k_matrix))
  z_tb[z_tb == 0] <- NA
  z_result <- as.data.frame(savitzkyGolay(z_tb, p = 3, w = 11, m = 0))
  z_result <- add_column(z_result, z_tb$V1, z_tb$V2,
                        z_tb$V3, z_tb$V4, z_tb$V5, .before = "V6")
  z_result <- add_column(z_result, z_tb[[length(z_tb) - 4]], z_tb[[length(z_tb) - 3]],
                        z_tb[[length(z_tb) - 2]], z_tb[[length(z_tb) - 1]],
                         z_tb[[length(z_tb)]], .after = colnames(z_tb[length(z_tb) - 5]))

  for (i in 1:length(z_result)) {
    latlong <- as.data.frame(coordinates(raster(x.listfile[1])))
    data <- cbind(z_result[, i], latlong)
    sp::coordinates(data) <- ~x+y
    sp::proj4string(data) <- crs(proj4string(raster(x.listfile[1])))
    sp::gridded(data) <- TRUE
    raster_data <- raster(data)
    writeRaster(raster_data, paste(path_result, "/", "Golay_",
                                   str_sub(x.listfile[i], 1, stri_length(x.listfile[i]) - 4), ".tif",
                                   sep = ""), overwrite = T)
  }
}