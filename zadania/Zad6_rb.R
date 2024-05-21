#Wczytanie potrzebnych pakietów
library("terra")
library("rgugik")

# Wczytanie danych
lublin = vect("Lublin.gpkg")

# Pobranie i wyświetlenie danych
dane = ortho_request(lublin)
View(dane)

# Przefiltrowanie danych
dane[dane$year == 2015, ]
dane[dane$composition == 'RGB', ]

# Wybranie rastrów
id = c("69776_196303_M-34-34-A-a-3-2", "69776_196307_M-34-34-A-a-3-4")
dane_sel = dane[dane$filename %in% id, ]

#Pobranie rastrów
options(timeout = 600)
tile_download(dane_sel, outdir = "Orto")

# Wylistowanie pobranych rastrów
pliki = list.files("Orto", pattern = "\\.tif$", full.names = TRUE)
pliki

# Wczytanie rastrów
r1 = rast(pliki[1])
r2 = rast(pliki[2])

# Złączenie rastrów
mosaic = merge(r1, r2)

# Zapisanie połączonych rastrów jako TIFF
writeRaster(mosaic, "mosaic.tiff")

# Utworzenie pliku vrt
vrt_output = "mosaic.vrt"
vrt(pliki, vrt_output)

# Sprawdzenie wielkości plików 
file.size("mosaic.tiff")
file.size("mosaic.vrt")

# Sprawdzenie zawartości pliku vrt
readLines(vrt_output) # Plik w postaci XML zawierający dane dotyczące rastrów

# Zmniejszenie rozdzielczości tiff do 10m i zapisanie do oddzielnego pliku
mosaic_zmniejszona = aggregate(mosaic, fact=2)
writeRaster(mosaic_zmniejszona, "mosaic_10m.tiff") 

# Zmniejszenie rozdzielczości do 10m doprowadziło do pogorszenia jakości obrazu. Widać to szczególnie przy skali 1: 2000 i większej porównując rastry np. w programie QGIS.