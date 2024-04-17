library("terra")
raster1=rast("D:/Studia_xD/Rok4/ZAP/output_NASADEM.tif")

#1
raster1
plot(raster1)

#2
zasieg = ext(740000, 752000, 370000,380000 ) # xmin, xmax, ymin, ymax
r = crop(raster1, zasieg)
r
plot(r, ext = ext(raster1)) # porównaj z oryginalnym zasięgiem

#3
r_2180=project(raster1, "EPSG:2180")
par(mfrow = c(1, 2))
plot(raster1, main = "World Geodetic System 84")
plot(r_2180, main = "2180")

#4
rasFocal=focal(raster1, w=3, fun="mean")
par(mfrow = c(1, 2))
plot(raster1, main = "Raster wejściowy")
plot(rasFocal, main = "Raster wygładzony")

#5
summary(raster1)
data.frame(
  global(raster1, fun="min"),
  global(raster1, fun="max"),
  global(raster1, fun="mean"),
  global(raster1, fun="sd")
)

#6
par(mfrow = c(1, 1))
plot(raster1, colNA="lightblue", range=c(1,2700), main="Lublin")

#7
writeRaster(raster1, filename = "raster.tif", gdal = c("COMPRESS=LZW"))
