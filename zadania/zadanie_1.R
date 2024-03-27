library("terra")

sciezka_do_logo = system.file("ex/logo.tif", package = "terra")
sciezka_do_logo # wyświetl

logo = rast(sciezka_do_logo)

logo
# class       : SpatRaster
# dimensions  : 77, 101, 3  (nrow, ncol, nlyr)
# resolution  : 1, 1  (x, y)
# extent      : 0, 101, 0, 77  (xmin, xmax, ymin, ymax)
# coord. ref. : Cartesian (Meter)
# source      : logo.tif
# colors RGB  : 1, 2, 3
# names       : red, green, blue
# min values  :   0,     0,    0
# max values  : 255,   255,  255

## raster składa się z trzech kanałów (warstw), tj. czerwonego, zielonego
## i niebieskiego
## zakres przestrzenny zdefiniowany jest przez liczbę wierszy (oś Y) i liczbę
## kolumn (oś X)
