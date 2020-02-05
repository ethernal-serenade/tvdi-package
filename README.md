# TVDI Package R

### Description
- Use MODIS image to calculate TVDI index
- Make multiple Raster images at the same time
- Can be used to calculate large image files
- UI interface calculates TVDI index
- UI interface exports Golay Savitzky filter images
- The functions in the TVDI package
    - Golay_Raster
    - Golay_GUI
    - Mean_Raster
    - Mask_Multi_Raster
    - IQR_Raster
    - TVDI_process
    - TVDI_Largefiles_process
    - TVDI_GUI
- Notes:
    - After coding on the libraries, need to insert the libraries into DESCRIPTION
    - Note: the problem in DESCRIPTION (packages using Imports, the packages available in the machine will be available, while currently using Depends can be used)
    - An important issue is that when using GDAL-related packages, it is necessary to add the SystemRequirements section so that R can understand it.

### How to Download and Install
1. Download and Install from Github
``` r
install.packages("devtools")
library(devtools)
install_github("nguyenduclam/TVDIpk")
library(TVDIpk)
```
2. Install from Cran (waiting for update in Cran)
``` r
install.packages("TVDIpk")
```

### How to use Pakages
1. Golay UI
    + `Golay_GUI()`
    + <img src="Golay_GUI.jpg" width="50%">
2. TVDI UI
    + `TVDI_GUI()`
    + <img src="TVDI_GUI.jpg" width="50%">

### References
- http://r-pkgs.had.co.nz/
- Package MODIStsp: https://github.com/ropensci/MODIStsp
- https://rstudio.github.io/leaflet/
- https://github.com/rstudio/shiny-examples/tree/master/063-superzip-example