# Instalacja i załadowanie potrzebnych pakietów
library(terra)

# Pobranie danych z Geoportalu (przykładowy link do granic powiatów)
url <- "https://www.gis-support.pl/downloads/2022/powiaty.zip"
download.file(url, "powiaty.zip", mode = "wb")
wektor <- unzip("powiaty.zip", exdir = "powiaty_dir")

# Wczytanie danych
f <- "~/powiaty.shp"
powiaty <- terra::vect(f)
powiaty

# Obliczenie centroidów
centroidy = centroids(powiaty, inside = FALSE)
plot(powiaty)
plot(centroidy, add = TRUE, col = "blue")

# Obliczenie macierzy odległości między centroidami
odleglosci = distance(centroidy)
odleglosci
macierz_odleglosci = as.matrix(odleglosci)
macierz_odleglosci[1:5, 1:5]
colnames(macierz_odleglosci) = rownames(macierz_odleglosci) = centroidy$JPT_NAZWA_


# Zastąpienie zer
macierz_odleglosci[lower.tri(macierz_odleglosci, diag = TRUE)] <- NA
diag(macierz_odleglosci)

# Znalezienie indeksów minimalnej i maksymalnej odległości
min_index <- which(macierz_odleglosci == min(macierz_odleglosci, na.rm = TRUE), arr.ind = TRUE)
min_index #najbliżej powiat rybnicki
max_index <- which(macierz_odleglosci == max(macierz_odleglosci, na.rm = TRUE), arr.ind = TRUE)
max_index #najdalej powiat Świnoujście

