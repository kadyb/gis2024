library("terra")
library("rgugik")


# wyszukanie danych
wspolrzedne = matrix(c(22.73, 50.78), ncol = 2)
centroid = vect(wspolrzedne, type = "points", crs = "EPSG:4326")
centroid
centroid = project(centroid, "EPSG:2180")
dane = DEM_request(centroid)
# wyświetl 10 pierwszych wierszy i 6 pierwszych kolumn
dane[1:10, 1:6]

DTM_sel = dane[dane$format == "ARC/INFO ASCII GRID" & dane$product == "DTM" & dane$year == 2013, ]
DSM_sel = dane[dane$format == "ARC/INFO ASCII GRID" & dane$product == "DSM" & dane$year == 2013, ]

# połączenie powyższych ramek danych
dane_sel = rbind(DTM_sel, DSM_sel)
dane_sel
dane_sel[, 1:6]

options(timeout = 600)
tile_download(dane_sel, outdir = "dane")

DTM = rast("dane/5298_491397_M-34-46-C-b-4-2.asc")
DSM = rast("dane/5300_491399_M-34-46-C-b-4-2.asc")
DTM
DSM

# ustawienie układu współrzędnych
crs(DTM) = crs(DSM) = "EPSG:2180"

#DSM = resample(DSM, DTM, method = "near", filename = "D:/Zaawansowane analizy przestrzenne/zad7/dane/DSM_1.tif")
DEM = c(DTM, DSM)
names(DEM) = c("DTM", "DSM")
nlyr(DEM)

plot(DTM, main = "Numeryczny model terenu [m]")
plot(DSM, main = "Numeryczny model pokrycia terenu [m]")
names(DTM) = "DTM"
names(DSM) = "DSM"

# profil wysokosciowy
#plot(DTM)
#profil = draw("line", n = 2) # klikamy punkt początkowy i końcowy na mapie
#crs(profil) = "EPSG:2180"
#profil

punkty = matrix(c(762816.7, 329824.8, 763481.5, 331415.5), ncol = 2, byrow = TRUE)
profil = vect(punkty, type = "lines", crs = "EPSG:2180")

plot(DTM, main = "DTM [m]", col = terrain.colors(99, alpha = NULL))
plot(profil, col = "red", lwd = 2, add = TRUE)

text("A", x = 762896, y = 329824.8, cex = 0.8)
text("B", x = 763481.5, y = 331415.5, cex = 0.8)

# wyswietlenie profilu
prof = extract(DTM, profil)
plot(prof$DTM, type = "l", xlab = "Indeks komórki", ylab = "Wysokość n.p.m. [m]")
#View(prof)

profil_wartosci = loess(prof[, 2] ~ seq_along(prof[, 2]), span = 0.1)
profil_wartosci = profil_wartosci$fitted
plot(profil_wartosci, type = "l", xlab = "Indeks komórki", ylab = "Wysokość n.p.m. [m]")

# srednia odleglosc miedzy punktami
odleglosc = perim(profil) / length(profil_wartosci)
odleglosc

odleglosc = cumsum(rep(odleglosc, length(profil_wartosci)))
odleglosc[1:5] # odległość pierwszych 5 punktów

summary(profil_wartosci)
plot(odleglosc, profil_wartosci, type = "l", ylab = "Wysokość n.p.m. [m]",
     xlab = "Odległość [m]")

# wizualizacje wysokości obiektów (znormalizowany NMPT)
nDSM = DSM - DTM
nDSM

# nadpisz wartości poniżej 0
nDSM[nDSM < 0] = 0
nDSM
plot(nDSM)

# Obliczenie zakresu, średniej i odchylenia standardowego dla rastrów
statystyki = data.frame(
  global(DEM, "range", na.rm = TRUE),
  global(DEM, "mean", na.rm = TRUE),
  global(DEM, "sd", na.rm = TRUE)
)

# Wyświetlenie wyników
print(statystyki)
