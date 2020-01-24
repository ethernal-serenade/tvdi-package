#' Calculate TVDI and Export TVDI Images
#'
#' Set the function of determining TVDI through LST and NDVI on all image points.
#' Then export the result as Raster TVDI.
#' Note: Firstly, this function will process large files If you have small or medium files, you can
#' use 'TVDI_process' in order to process small and medium files. Secondly, I have divided roughly in
#' this calculation has a distance of 0.05, can be adjusted by downloading this function and changing
#' to suit the data
#'
#' @param list_NDVI List of NDVI images
#' @param list_LST List of LST images
#' @return Results TVDI
#' @export

TVDI_Largefiles_process <- function (path_NDVI, path_LST, path) {
  setwd(path_NDVI)
  list_NDVI <- list.files(path_NDVI)
  setwd(path_LST)
  list_LST <- list.files(path_LST)

  if (length(list_NDVI) != length(list_LST)) {
    stop("You need to change the length of the 2 lists to be equal",
         call. = FALSE)
  }

  range_md <- read.table(header = T, file = system.file("extdata",
                                                        "Range_MD.txt",
                                                        package = "TVDIpk"), sep = ",")
  tableMax = as.data.frame(c())
  Tmin_tb = as.data.frame(c())
  for (i in 1:length(list_NDVI)) {
    setwd(path_NDVI)
    x <- readGDAL(list_NDVI[i])@data
    setwd(path_LST)
    y <- readGDAL(list_LST[i])@data
    GROUP <- cbind(x, y)
    colnames(GROUP) <- c("NDVI","LST")
    group_range <- data.frame(GROUP$NDVI, "Type" = cut(GROUP$NDVI, breaks = range_md$Start,
                                                       right = F, include.lowest = T))
    GROUP <- cbind(group_range, y)
    colnames(GROUP) <- c("NDVI", "Type", "LST")
    Tmin_tb <- rbind(GROUP[which.min(GROUP$LST),], Tmin_tb)

    Q0.2_0.25 <- subset(GROUP, Type == "[0.2,0.25)")
    Q0.25_0.3 <- subset(GROUP, Type == "[0.25,0.3)")
    Q0.3_0.35 <- subset(GROUP, Type == "[0.3,0.35)")
    Q0.35_0.4 <- subset(GROUP, Type == "[0.35,0.4)")
    Q0.4_0.45 <- subset(GROUP, Type == "[0.4,0.45)")
    Q0.45_0.5 <- subset(GROUP, Type == "[0.45,0.5)")
    Q0.5_0.55 <- subset(GROUP, Type == "[0.5,0.55)")
    Q0.55_0.6 <- subset(GROUP, Type == "[0.55,0.6)")
    Q0.6_0.65 <- subset(GROUP, Type == "[0.6,0.65)")
    Q0.65_0.7 <- subset(GROUP, Type == "[0.65,0.7)")
    Q0.7_0.75 <- subset(GROUP, Type == "[0.7,0.75)")
    Q0.75_0.8 <- subset(GROUP, Type == "[0.75,0.8)")
    Q0.8_0.85 <- subset(GROUP, Type == "[0.8,0.85)")
    Q0.85_0.9 <- subset(GROUP, Type == "[0.85,0.9)")

    tableMax <- rbind(rbind(Q0.2_0.25[which.max(Q0.2_0.25$LST),],
                      Q0.25_0.3[which.max(Q0.25_0.3$LST),],
                      Q0.3_0.35[which.max(Q0.3_0.35$LST),],
                      Q0.35_0.4[which.max(Q0.35_0.4$LST),],
                      Q0.4_0.45[which.max(Q0.4_0.45$LST),],
                      Q0.45_0.5[which.max(Q0.45_0.5$LST),],
                      Q0.5_0.55[which.max(Q0.5_0.55$LST),],
                      Q0.55_0.6[which.max(Q0.55_0.6$LST),],
                      Q0.6_0.65[which.max(Q0.6_0.65$LST),],
                      Q0.65_0.7[which.max(Q0.65_0.7$LST),],
                      Q0.7_0.75[which.max(Q0.7_0.75$LST),],
                      Q0.75_0.8[which.max(Q0.75_0.8$LST),],
                      Q0.8_0.85[which.max(Q0.8_0.85$LST),],
                      Q0.85_0.9[which.max(Q0.85_0.9$LST),]), tableMax)
  }

  Tb_Max.2_0.25 <- subset(tableMax, Type == "[0.2,0.25)")
  Tb_Max.25_0.3 <- subset(tableMax, Type == "[0.25,0.3)")
  Tb_Max.3_0.35 <- subset(tableMax, Type == "[0.3,0.35)")
  Tb_Max.35_0.4 <- subset(tableMax, Type == "[0.35,0.4)")
  Tb_Max.4_0.45 <- subset(tableMax, Type == "[0.4,0.45)")
  Tb_Max.45_0.5 <- subset(tableMax, Type == "[0.45,0.5)")
  Tb_Max.5_0.55 <- subset(tableMax, Type == "[0.5,0.55)")
  Tb_Max.55_0.6 <- subset(tableMax, Type == "[0.55,0.6)")
  Tb_Max.6_0.65 <- subset(tableMax, Type == "[0.6,0.65)")
  Tb_Max.65_0.7 <- subset(tableMax, Type == "[0.65,0.7)")
  Tb_Max.7_0.75 <- subset(tableMax, Type == "[0.7,0.75)")
  Tb_Max.75_0.8 <- subset(tableMax, Type == "[0.75,0.8)")
  Tb_Max.8_0.85 <- subset(tableMax, Type == "[0.8,0.85)")
  Tb_Max.85_0.9 <- subset(tableMax, Type == "[0.85,0.9)")

  table_Max <- rbind(Tb_Max.2_0.25[which.max(Tb_Max.2_0.25$LST),],
                     Tb_Max.25_0.3[which.max(Tb_Max.25_0.3$LST),],
                     Tb_Max.3_0.35[which.max(Tb_Max.3_0.35$LST),],
                     Tb_Max.35_0.4[which.max(Tb_Max.35_0.4$LST),],
                     Tb_Max.4_0.45[which.max(Tb_Max.4_0.45$LST),],
                     Tb_Max.45_0.5[which.max(Tb_Max.45_0.5$LST),],
                     Tb_Max.5_0.55[which.max(Tb_Max.5_0.55$LST),],
                     Tb_Max.55_0.6[which.max(Tb_Max.55_0.6$LST),],
                     Tb_Max.6_0.65[which.max(Tb_Max.6_0.65$LST),],
                     Tb_Max.65_0.7[which.max(Tb_Max.65_0.7$LST),],
                     Tb_Max.7_0.75[which.max(Tb_Max.7_0.75$LST),],
                     Tb_Max.75_0.8[which.max(Tb_Max.75_0.8$LST),],
                     Tb_Max.8_0.85[which.max(Tb_Max.8_0.85$LST),],
                     Tb_Max.85_0.9[which.max(Tb_Max.85_0.9$LST),])

  linearMod <- lm(formula = table_Max$LST ~ table_Max$NDVI)
  Stats <- summary(linearMod)
  Coef <- Stats[4]$coefficients
  Coef_tbl <- as.data.frame(Coef)
  linear_index <- as.data.frame(Coef_tbl$Estimate)
  rownames(linear_index) <- c("b","a")
  colnames(linear_index) <- c("Estimate")

  a <- linear_index[1,1]
  b <- linear_index[2,1]
  Tmin <- min(Tmin_tb$LST)
  dir.create(paste(path, "TVDI",sep = "/"))
  path_result = paste(path, "TVDI",sep = "/")

  for (i in 1:length(list_NDVI)) {
    setwd(path_NDVI)
    x <- readGDAL(list_NDVI[i])@data
    setwd(path_LST)
    y <- readGDAL(list_LST[i])@data

    tb <- cbind(x, y)
    TVDI <- (y - Tmin)/(a + b*x - Tmin)
    latlong <- as.data.frame(coordinates(raster(list_LST[i])))
    raster_TVDI <- cbind(TVDI, latlong)
    coordinates(raster_TVDI) <- ~x+y
    proj4string(raster_TVDI) <- crs(proj4string(raster(list_LST[i])))
    gridded(raster_TVDI) <- TRUE
    TVDI <- raster(raster_TVDI)
    writeRaster(TVDI, paste(path_result, "/", "TVDI",
                            str_sub(str_replace(list_LST[i], "LST", ""), 1,
                                    stri_length(str_replace(list_LST[i],
                                                            "LST", "")) - 4),
                            ".tif", sep = ""), overwrite = T)
  }
}