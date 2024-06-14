#wykonali Maciej Fornal Hubert Janowski Paweł Gil
library(terra)
library("raster")

# Funkcja do obliczania mediany i odchylenia standardowego
calculate_stats <- function(points, regions) {
  stats_list <- list()
  for (i in 1:nrow(regions)) {
    region <- regions[i, ]
    region_points <- points[region, , drop = FALSE]
    if (nrow(region_points) > 0) {
      med <- median(region_points$z, na.rm = TRUE)
      std <- sd(region_points$z, na.rm = TRUE)
      region_name <- as.character(region$JPT_NAZWA_)  # Użyj kolumny JPT_NAZWA_
      if (length(region_name) > 0) {
        stats_list[[i]] <- data.frame(
          Wojewodztwo = wojewodztwo,
          Powiat = region_name,
          Mediana_wysokosci = med,
          Odch_Std = std
        )
      }
    }
  }
  stats_df <- do.call(rbind, stats_list)
  return(stats_df)
}

# Pobieranie repozytorium
url <- "https://codeload.github.com/Vrokur/Analiza_przestrzenna_5/zip/heads/main"
download.file(url, "powiaty.zip", mode = "wb", method = "libcurl")
unzip("powiaty.zip", exdir = "zad5")

# Wczytywanie pliku shapefile powiaty
powiaty <- vect("zad5/Analiza_przestrzenna_5-heads-main/2/powiaty/powiaty.shp")




# Wczytywanie danych dla każdego województwa i przetwarzanie
wojewodztwa <- c("dolnoslaskie", "kujawsko-pomorskie", "lubelskie", "lubuskie", 
                 "lodzkie", "malopolskie", "mazowieckie", "opolskie", "podkarpackie", 
                 "podlaskie", "pomorskie", "slaskie", "swietokrzyskie", "warminsko-mazurskie", 
                 "wielkopolskie", "zachodniopomorskie")




# Iteracja przez województwa
for (wojewodztwo in wojewodztwa) {
  # Sprawdź istnienie pliku dla województwa
  file_path <- file.path("zad5/Analiza_przestrzenna_5-heads-main/2", paste0(wojewodztwo, ".txt"))
  cat("Sprawdzam ścieżkę:", file_path, "\n")
  
  if (file.exists(file_path)) {
    woj_txt <- read.table(file_path, header = FALSE, sep = " ")
    colnames(woj_txt) <- c("x", "y", "z")  # Zakładam, że to są nazwy kolumn w pliku
    
    # Konwertowanie na obiekt typu SpatVector
    spat_vector <- vect(woj_txt, geom = c("x", "y"), crs = "EPSG:2180")
    
    # Dodanie trzeciego wymiaru (z)
    spat_vector$z <- woj_txt$z
    print(spat_vector)
    
    
    # Obliczanie statystyk dla powiatów
    powiaty_stats <- calculate_stats(spat_vector, powiaty_2180)
    
    # Sprawdzenie zawartości powiaty_stats (debug)
    print(powiaty_stats)
    
    # Sprawdzenie, czy powiaty_stats zawiera dane do zapisu
    if (nrow(powiaty_stats) > 0) {
      # Zapisywanie wyników do pliku CSV
      csv_file <- paste0("zad5/Analiza_przestrzenna_5-heads-main/2/", wojewodztwo, "_powiaty_stats.csv")
      write.csv(powiaty_stats, file = csv_file, row.names = FALSE)
      cat("Zapisano wyniki do:", csv_file, "\n")
    } else {
      cat("Brak danych do zapisu dla województwa:", wojewodztwo, "\n")
    }
    
  } else {
    cat("Brak pliku dla województwa:", wojewodztwo, "\n")
  }
}

# Obliczanie statystyk dla wszystkich powiatów
powiaty_stats <- calculate_stats(spat_vector, powiaty_2180)

# Tworzenie mapy odchylenia standardowego dla wszystkich powiatów
std_map <- rasterize(powiaty_2180, powiaty_stats["Odch_Std"], field="Odch_Std")
plot(std_map, main="Standard Deviation")
legend("topright", legend="Standard Deviation", fill=NA, border="black", bty="n")
dev.copy(png, filename=paste0("std_map_", wojewodztwo, ".png"))
dev.off()

# Tworzenie mapy mediany wysokości dla wszystkich powiatów
med_map <- rasterize(powiaty_2180, powiaty_stats["Mediana_wysokosci"], field="Mediana_wysokosci")
plot(med_map, main="Median Height")
legend("topright", legend="Median Height", fill=NA, border="black", bty="n")
dev.copy(png, filename=paste0("med_map_", wojewodztwo, ".png"))
dev.off()
