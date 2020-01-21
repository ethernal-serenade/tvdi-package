# TVDI Package R
- Sử dụng ảnh MODIS tính chỉ số TVDI
- Thực hiện được nhiều ảnh Raster cùng lúc
- Các function trong TVDI package
    - Golay_Raster
    - Mean_Raster
    - Mask_Multi_Raster
    - IQR_Raster
    - TVDI_process
- Các lưu ý:
    - Sau khi code trên các thư viện, cần chèn các thư viện vào phần DESCRIPTION
    - Note: vấn đề ở phần DESCRIPTION (các package sử dụng Imports thì các package có trong máy sẽ vào sẵn, trong khi hiện tại phải sử dụng Depends mới vào được)
    - Một vấn đề quan trọng là khi sử dụng các package có liên quan đến GDAL cần thêm phần SystemRequirements để R hiểu mà thêm vào
###### References