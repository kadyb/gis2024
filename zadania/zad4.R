# Instalacja i załadowanie potrzebnych pakietów
install.packages("sf")
install.packages("raster")
library(sf)
library(terra)
library(raster)

# Pobranie danych z Geoportalu (przykładowy link do granic powiatów)
url <- "https://www.gis-support.pl/downloads/2022/powiaty.zip"
download.file(url, "powiaty", mode = "wb")
wektor <- unzip("powiaty.zip", exdir = "powiaty_dir")

# Wczytanie danych
f <- "C:/Users/piotr/Documents/powiaty_dir/powiaty.shp"
powiaty <- terra::vect(f)
powiaty

# Obliczenie centroidów
centroidy = centroids(powiaty, inside = FALSE)
centroidy_wewnatrz = centroids(powiaty, inside = TRUE)
plot(powiaty)
plot(centroidy, add = TRUE, col = "blue")
plot(centroidy_wewnatrz, add = TRUE, col = "orange")

# Obliczenie macierzy odległości między centroidami
odleglosci = distance(centroidy)
odleglosci
macierz_odleglosci = as.matrix(odleglosci)
macierz_odleglosci[1:5, 1:5]
colnames(macierz_odleglosci) = rownames(macierz_odleglosci) = centroidy$NAME_2

# Zastąpienie zer
macierz_odleglosci[lower.tri(macierz_odleglosci, diag = TRUE)] <- NA

# Znalezienie indeksów minimalnej i maksymalnej odległości
min_index <- which(macierz_odleglosci == min(macierz_odleglosci, na.rm = TRUE), arr.ind = TRUE)
min_index
max_index <- which(macierz_odleglosci == max(macierz_odleglosci, na.rm = TRUE), arr.ind = TRUE)
max_index
powiaty
