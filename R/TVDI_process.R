#' Calculate TVDI and Export TVDI Images
#'
#' Lập hàm xác định TVDI thông qua 2 chỉ số LST và NDVI trên toàn bộ các thời điểm ảnh.
#' Sau đó xuất kết quả dưới dạng Raster TVDI.
#'
#' @param list_NDVI Danh sách các ảnh NDVI
#' @param list_LST Danh sách các ảnh LST
#' @return kết quả ảnh TVDI
#' @export
TVDI_process <- function (path_NDVI, path_LST, path) {
  setwd(path_NDVI)
  list_NDVI <- list.files(path_NDVI)
  setwd(path_LST)
  list_LST <- list.files(path_LST)

  if (length(list_NDVI) != length(list_LST)) {
    stop("You need to change the length of the 2 lists to be equal",
         call. = FALSE)
  }

  setwd(path_NDVI)
  data_NDVI <- read.table(header = TRUE, text = 'band1')
  for (f in list_NDVI) {
    x <- readGDAL(f)@data
    data_NDVI <- rbind(data_NDVI, x)
  }
  setwd(path_LST)
  data_LST <- read.table(header = TRUE, text = 'band1')
  for (f in list_LST) {
    y <- readGDAL(f)@data
    data_LST <- rbind(data_LST, y)
  }

  GROUP <- cbind(data_NDVI,data_LST)
  colnames(GROUP) <- c("NDVI","LST")
  range_md <- read.table(header = T, file = system.file("extdata",
                                                        "Range_MD.txt", package = "TVDIpk"), sep = ",")
  group_range <- data.frame(GROUP$NDVI, "Type" = cut(GROUP$NDVI, breaks = range_md$Start,
                                                     right = F, include.lowest = T))
  GROUP <- cbind(group_range, data_LST)
  colnames(GROUP) <- c("NDVI", "Type", "LST")

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

  tableMax <- rbind(Q0.2_0.25[which.max(Q0.2_0.25$LST),],
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
                    Q0.85_0.9[which.max(Q0.85_0.9$LST),])

  linearMod <- lm(formula = tableMax$LST ~ tableMax$NDVI)
  Stats <- summary(linearMod)
  Coef <- Stats[4]$coefficients
  Coef_tbl <- as.data.frame(Coef)
  linear_index <- as.data.frame(Coef_tbl$Estimate)
  rownames(linear_index) <- c("b","a")
  colnames(linear_index) <- c("Estimate")

  a <- linear_index[1,1]
  b <- linear_index[2,1]
  Tmin_tb <- GROUP[which.min(GROUP$LST),]
  Tmin <- Tmin_tb$LST
  dir.create(paste(path, "TVDI",sep = "/"))
  path_result = paste(path, "TVDI",sep = "/")
  latlong <- as.data.frame(coordinates(raster(list_LST[1])))

  for (i in 1:length(list_NDVI)) {
    setwd(path_NDVI)
    x <- readGDAL(list_NDVI[i])@data
    setwd(path_LST)
    y <- readGDAL(list_LST[i])@data

    tb <- cbind(x,y)
    TVDI <- (y - Tmin)/(a + b*x - Tmin)
    raster_TVDI <- cbind(TVDI, latlong)
    coordinates(raster_TVDI) <- ~x+y
    proj4string(raster_TVDI) <- crs(proj4string(raster(list_LST[1])))
    gridded(raster_TVDI) <- TRUE
    TVDI <- raster(raster_TVDI)
    writeRaster(TVDI, paste(path_result, "/", "TVDI",
                                   str_sub(str_replace(list_LST[i], "LST", ""), 1,
                                           stri_length(str_replace(list_LST[i],
                                                                   "LST", "")) - 4), ".tif",
                                   sep = ""), overwrite = T)

  }
}