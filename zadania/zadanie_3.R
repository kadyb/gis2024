library("terra")

# załóżmy, że folderem roboczym jest "gis2024/zadania", wtedy
# ścieżka względna to "../dane/Lublin_DEM.tif"
# alternatywnie można stworzyć projekt w RStudio
raster=rast("../dane/Lublin_DEM.tif")

#1
raster
plot(raster)

#2
r_2180=project(raster, "EPSG:2180")
par(mfrow = c(1, 2)) # wyświetl mapy w 2 kolumnach
plot(raster, main = "World Geodetic System 84")
plot(r_2180, main = "Układ współrzędnych 1992")

#3
par(mfrow = c(1, 1)) # wyświetl tylko 1 mapę
plot(r_2180)
# zasieg = draw(x = "extent") # trzeba wskazać dwa wierzchołki na mapie
# zasieg

# załóżmy, że został wyznaczony taki zasięg w funkcji `draw()`:
zasieg = ext(740000, 752000, 370000, 380000) # xmin, xmax, ymin, ymax
r = crop(r_2180, zasieg)
r
plot(r, ext = ext(r_2180)) # porównaj z oryginalnym zasięgiem

#4
rasFocal=focal(r_2180, w=15, fun="mean")
par(mfrow = c(1, 2))
plot(r_2180, main = "Raster wejściowy")
plot(rasFocal, main = "Raster wygładzony")

#5
summary(r_2180) # wartości wyliczone z próby
data.frame(
  # wartości wyliczone z populacji
  global(r_2180, fun="min", na.rm = TRUE),
  global(r_2180, fun="max", na.rm = TRUE),
  global(r_2180, fun="mean", na.rm = TRUE),
  global(r_2180, fun="sd", na.rm = TRUE)
)

#6
writeRaster(rasFocal, filename = "raster.tif", gdal = c("COMPRESS=LZW"))
