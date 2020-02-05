# TVDI Package R

### Description
+ Use MODIS image to calculate TVDI index
+ Make multiple Raster images at the same time
+ Can be used to calculate large image files
+ UI interface calculates TVDI index
+ UI interface exports Golay Savitzky filter images
+ The functions in the TVDI package
    + Golay_Raster
    + Golay_GUI
    + Mean_Raster
    + Mask_Multi_Raster
    + IQR_Raster
    + TVDI_process
    + TVDI_Largefiles_process
    + TVDI_GUI
+ Notes:
    + After coding on the libraries, need to insert the libraries into DESCRIPTION
    + Note: the problem in DESCRIPTION (packages using Imports, the packages available in the machine will be available, while currently using Depends can be used)
    + An important issue is that when using GDAL-related packages, it is necessary to add the SystemRequirements section so that R can understand it.

### How to Download and Install
+ Download and Install from Github
``` r
install.packages("devtools")
library(devtools)
install_github("nguyenduclam/TVDIpk")
library(TVDIpk)
```
+ Install from Cran (waiting for update in Cran)
``` r
install.packages("TVDIpk")
```
+ Note that **if the `GTK+` library is not already installed on your
system, installation may fail**. In that case, please install and load
the `gWidgetsRGtk2` library beforehand:

``` r
install.packages("gWidgetsRGtk2")
library(gWidgetsRGtk2)
```

+ Upon loading `gWidgetsRGtk2`, an error window will probably appear. This
signals that library “GTK+” is not yet installed on your system or is
not on your PATH. To install it press “OK”. A new window dialog window
will appear, asking if you. want to install “GTK+”. Select “Install GTK”
and then “OK” . Windows will download and install the GTK+ library. When
it finishes, the RSession should be restarted and you should be ready to
go \!

+ In case RStudio does not automatically restart or continuously asks to
install GTK+ again, kill it form “Task Manager” (or restart the R
session from RStudio “Session” menu), reload RStudio and the try to
reload `gWidgetsRGtk2`. If it loads correctly, you should be ready to
go.

If it still fails, try downloading the GTK+ bundle
from:

<http://ftp.gnome.org/pub/gnome/binaries/win64/gtk+/2.22/gtk+-bundle_2.22.1-20101229_win64.zip>
(OR
<http://ftp.gnome.org/pub/gnome/binaries/win32/gtk+/2.22/gtk+-bundle_2.22.1-20101227_win32.zip>
if on Win32)

, unzip the archive on a folder of your choice (e.g., `C:\\Program
Files\\GTK+`), then add the path to its “bin” subfolder (e.g.,
`C:\\Program Files\\GTK+\\bin\\` to your system PATH environment
variable.

Restart your system and try loading again `gWidgetsRGtk2`: if it loads
ok, you should be ready to install
`MODIStsp`


### How to use Pakages
1. Golay UI
    + `Golay_GUI()`
    + <img src="Golay_GUI.jpg" width="50%">
2. TVDI UI
    + `TVDI_GUI()`
    + <img src="TVDI_GUI.jpg" width="50%">

### References
+ http://r-pkgs.had.co.nz/
+ Package MODIStsp: https://github.com/ropensci/MODIStsp
+ https://rstudio.github.io/leaflet/
+ https://github.com/rstudio/shiny-examples/tree/master/063-superzip-example