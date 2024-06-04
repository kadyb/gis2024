# Załadowanie pakietu
library(terra)

# Pobranie danych (przykładowy link do granic powiatów)
url <- "https://www.gis-support.pl/downloads/2022/powiaty.zip"
download.file(url, "powiaty.zip", mode = "wb")
wektor <- unzip("powiaty.zip", exdir = "powiaty_dir")

# Wczytanie danych
f <- "powiaty_dir/powiaty.shp"
powiaty <- terra::vect(f)
powiaty


#wczytanie danych tekstowych
dane <- read.table("C:/Users/Paweł/Desktop/zap/malopolskie.txt", sep = " ", dec = ".", header = FALSE)
str(dane)

coords <- cbind(dane$V1, dane$V2)  # Tworzenie macierzy współrzędnych
crs <- "+proj=longlat +datum=WGS84"  # Definicja układu współrzędnych
wysokosc <- dane$V3  # Wysokość

# Utworzenie obiektu SpatVector
spat_vec <- vect(wysokosc, geom = coords, crs = "EPSG:4326")
spat_vec


#generowanie centroidow siatki
centroidy = centroids(wektor, inside = FALSE)
centroidy_wewnatrz = centroids(wektor, inside = TRUE)
plot(wektor)
plot(centroidy, add = TRUE, col = "blue")
plot(centroidy_wewnatrz, add = TRUE, col = "orange")


#określenie które centroidy siatki leżą w konkretnym powiecie

proba = spatSample(wektor, size = 5, method = "random")
plot(wektor)
plot(proba, add = TRUE)

#wczytanie danych tekstowych
dane <- read.table("*/zachodniopomorskie.txt", sep = " ", dec = ".", header = FALSE)
str(dane)
coords <- cbind(dane$V1, dane$V2)  # Tworzenie macierzy współrzędnych
crs <- "+proj=longlat +datum=WGS84"  # Definicja układu współrzędnych
wysokosc <- dane$V3  # Wysokość

# Utworzenie obiektu SpatVector
spat_vec <- vect(wysokosc, geom = coords, crs = "EPSG:4326")
spat_vec


#generowanie centroidow siatki
centroidy = centroids(wektor, inside = FALSE)
centroidy_wewnatrz = centroids(wektor, inside = TRUE)
plot(wektor)
plot(centroidy, add = TRUE, col = "blue")
plot(centroidy_wewnatrz, add = TRUE, col = "orange")


#określenie które centroidy siatki leżą w konkretnym powiecie

proba = spatSample(wektor, size = 5, method = "random")
plot(wektor)
plot(proba, add = TRUE)

#wczytanie danych tekstowych
dane <- read.table("*/wielkopolskie.txt", sep = " ", dec = ".", header = FALSE)
str(dane)
coords <- cbind(dane$V1, dane$V2)  # Tworzenie macierzy współrzędnych
crs <- "+proj=longlat +datum=WGS84"  # Definicja układu współrzędnych
wysokosc <- dane$V3  # Wysokość
# Utworzenie obiektu SpatVector
spat_vec <- vect(wysokosc, geom = coords, crs = "EPSG:4326")
spat_vec


#generowanie centroidow siatki
centroidy = centroids(wektor, inside = FALSE)
centroidy_wewnatrz = centroids(wektor, inside = TRUE)
plot(wektor)
plot(centroidy, add = TRUE, col = "blue")
plot(centroidy_wewnatrz, add = TRUE, col = "orange")


#określenie które centroidy siatki leżą w konkretnym powiecie

proba = spatSample(wektor, size = 5, method = "random")
plot(wektor)
plot(proba, add = TRUE)

#wczytanie danych tekstowych
dane <- read.table("*/warminsko-mazurskie.txt", sep = " ", dec = ".", header = FALSE)
str(dane)
coords <- cbind(dane$V1, dane$V2)  # Tworzenie macierzy współrzędnych
crs <- "+proj=longlat +datum=WGS84"  # Definicja układu współrzędnych
wysokosc <- dane$V3  # Wysokość
# Utworzenie obiektu SpatVector
spat_vec <- vect(wysokosc, geom = coords, crs = "EPSG:4326")
spat_vec


#generowanie centroidow siatki
centroidy = centroids(wektor, inside = FALSE)
centroidy_wewnatrz = centroids(wektor, inside = TRUE)
plot(wektor)
plot(centroidy, add = TRUE, col = "blue")
plot(centroidy_wewnatrz, add = TRUE, col = "orange")


#określenie które centroidy siatki leżą w konkretnym powiecie

proba = spatSample(wektor, size = 5, method = "random")
plot(wektor)
plot(proba, add = TRUE)

#wczytanie danych tekstowych
dane <- read.table("*/swietokrzyskie.txt", sep = " ", dec = ".", header = FALSE)
str(dane)
coords <- cbind(dane$V1, dane$V2)  # Tworzenie macierzy współrzędnych
crs <- "+proj=longlat +datum=WGS84"  # Definicja układu współrzędnych
wysokosc <- dane$V3  # Wysokość
# Utworzenie obiektu SpatVector
spat_vec <- vect(wysokosc, geom = coords, crs = "EPSG:4326")
spat_vec


#generowanie centroidow siatki
centroidy = centroids(wektor, inside = FALSE)
centroidy_wewnatrz = centroids(wektor, inside = TRUE)
plot(wektor)
plot(centroidy, add = TRUE, col = "blue")
plot(centroidy_wewnatrz, add = TRUE, col = "orange")


#określenie które centroidy siatki leżą w konkretnym powiecie

proba = spatSample(wektor, size = 5, method = "random")
plot(wektor)
plot(proba, add = TRUE)



#określenie które centroidy siatki leżą w konkretnym powiecie

proba = spatSample(wektor, size = 5, method = "random")
plot(wektor)
plot(proba, add = TRUE)

#wczytanie danych tekstowych
dane <- read.table("*/lodzkie", sep = " ", dec = ".", header = FALSE)
str(dane)
coords <- cbind(dane$V1, dane$V2)  # Tworzenie macierzy współrzędnych
crs <- "+proj=longlat +datum=WGS84"  # Definicja układu współrzędnych
wysokosc <- dane$V3  # Wysokość

# Utworzenie obiektu SpatVector
spat_vec <- vect(wysokosc, geom = coords, crs = "EPSG:4326")
spat_vec


#generowanie centroidow siatki
centroidy = centroids(wektor, inside = FALSE)
centroidy_wewnatrz = centroids(wektor, inside = TRUE)
plot(wektor)
plot(centroidy, add = TRUE, col = "blue")
plot(centroidy_wewnatrz, add = TRUE, col = "orange")


#określenie które centroidy siatki leżą w konkretnym powiecie

proba = spatSample(wektor, size = 5, method = "random")
plot(wektor)
plot(proba, add = TRUE)

#wczytanie danych tekstowych
dane <- read.table("*/podlaskie", sep = " ", dec = ".", header = FALSE)
str(dane)
coords <- cbind(dane$V1, dane$V2)  # Tworzenie macierzy współrzędnych
crs <- "+proj=longlat +datum=WGS84"  # Definicja układu współrzędnych
wysokosc <- dane$V3  # Wysokość

# Utworzenie obiektu SpatVector
spat_vec <- vect(wysokosc, geom = coords, crs = "EPSG:4326")
spat_vec


#generowanie centroidow siatki
centroidy = centroids(wektor, inside = FALSE)
centroidy_wewnatrz = centroids(wektor, inside = TRUE)
plot(wektor)
plot(centroidy, add = TRUE, col = "blue")
plot(centroidy_wewnatrz, add = TRUE, col = "orange")


#określenie które centroidy siatki leżą w konkretnym powiecie

proba = spatSample(wektor, size = 5, method = "random")
plot(wektor)
plot(proba, add = TRUE)

#wczytanie danych tekstowych
dane <- read.table("*/dolnoslaskie", sep = " ", dec = ".", header = FALSE)
str(dane)
coords <- cbind(dane$V1, dane$V2)  # Tworzenie macierzy współrzędnych
crs <- "+proj=longlat +datum=WGS84"  # Definicja układu współrzędnych
wysokosc <- dane$V3  # Wysokość

# Utworzenie obiektu SpatVector
spat_vec <- vect(wysokosc, geom = coords, crs = "EPSG:4326")
spat_vec


#generowanie centroidow siatki
centroidy = centroids(wektor, inside = FALSE)
centroidy_wewnatrz = centroids(wektor, inside = TRUE)
plot(wektor)
plot(centroidy, add = TRUE, col = "blue")
plot(centroidy_wewnatrz, add = TRUE, col = "orange")


#określenie które centroidy siatki leżą w konkretnym powiecie

proba = spatSample(wektor, size = 5, method = "random")
plot(wektor)
plot(proba, add = TRUE)

#wczytanie danych tekstowych
dane <- read.table("*/pomorskie", sep = " ", dec = ".", header = FALSE)
str(dane)
coords <- cbind(dane$V1, dane$V2)  # Tworzenie macierzy współrzędnych
crs <- "+proj=longlat +datum=WGS84"  # Definicja układu współrzędnych
wysokosc <- dane$V3  # Wysokość

# Utworzenie obiektu SpatVector
spat_vec <- vect(wysokosc, geom = coords, crs = "EPSG:4326")
spat_vec


#generowanie centroidow siatki
centroidy = centroids(wektor, inside = FALSE)
centroidy_wewnatrz = centroids(wektor, inside = TRUE)
plot(wektor)
plot(centroidy, add = TRUE, col = "blue")
plot(centroidy_wewnatrz, add = TRUE, col = "orange")


