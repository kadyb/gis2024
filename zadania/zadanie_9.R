library("rstac")
library("terra")
library("raster")
library("tidyr")
library("ggplot2")

stac_source = stac("https://earth-search.aws.element84.com/v1")

stac_source |>
  stac_search(
    collections = "sentinel-2-c1-l2a",
    bbox = c(22.57, 51.48, 22.66, 51.43),
    datetime = "2023-05-01T00:00:00Z/2023-10-31T00:00:00Z",
    limit = 6) |>
  ext_query(`eo:cloud_cover` < 20) |>
  post_request() -> obrazy

unlist(lapply(obrazy$features, \(x) x$properties$"eo:cloud_cover"))

df = items_as_sf(obrazy)
plot(sf::st_geometry(df)[1], main = "Zasięg sceny", axes = TRUE)

obrazy |>
  items_select(1) |>
  assets_select(asset_names = c("blue", "green", "red", "nir")) |>
  assets_url() -> urls
urls

dir.create("sentinel")
rastry = file.path("sentinel", basename(urls))

for (i in seq_along(urls)) {
  download.file(urls[i], rastry[i], mode = "wb")
}


# sprawdź metadane rastrów
r <- rast(rastry)
names(r) <- c("Blue", "Green", "Red", "NIR")
r

#przygotuj wizualizację RGB
rgb_stack <- c(r$Red, r$Green, r$Blue)
plotRGB(rgb_stack, r=1, g=2, b=3, stretch="lin")

# pobierz losową próbę 10 tys. punktów dla kanału niebieskiego, 
# zielonego, czerwonego oraz bliskiej podczerwieni i zaprezentuj statystyki opisowe oraz porównaj histogramy

set.seed(42)
sample_size <- 10000
sample_points <- spatSample(r, size=sample_size, method="random", as.df=TRUE, na.rm=TRUE)
colnames(sample_points) <- c("Blue", "Green", "Red", "NIR")

stats <- sample_points |> summary(funs(mean, sd, min, max, median, IQR))
print(stats)

sample_points_long <- sample_points %>%
  pivot_longer(cols = everything(), names_to = "Channel", values_to = "Value")

ggplot(sample_points_long, aes(x=Value, fill=Channel)) +
  geom_histogram(bins=30, alpha=0.5, position="identity") +
  facet_wrap(~ Channel, scales = "fixed") +
  theme_minimal() +
  labs(title="Histogramy kanałów rastrowych", x="Wartość", y="Częstotliwość")

# dodatkowo dla kanału czerwonego oraz bliskiej podczerwieni wykonaj 
# wykres rozrzutu oraz oblicz współczynnik korelacji Pearsona

ggplot(sample_points, aes(x=Red, y=NIR)) +
    geom_point(alpha=0.5, color="blue") +
    geom_abline(intercept = 0, slope = 1) +
    theme_minimal() +
    labs(title="Wykres rozrzutu dla kanałów czerwonego i bliskiej podczerwieni", x="Czerwony", y="Bliska podczerwień")

correlation <- cor(sample_points$Red, sample_points$NIR, method="pearson")
print(paste("Współczynnik korelacji Pearsona:", correlation))

#oblicz znormalizowany różnicowy wskaźnik wegetacji (NDVI) i przygotuj wizualizację

red_band <- r[[3]]
nir_band <- r[[4]]

ndvi <- (nir_band - red_band) / (nir_band + red_band)
ndvi[ndvi < -1] <- -1
ndvi[ndvi > 1] <- 1


# Wizualizacja NDVI
plot(ndvi, main="Znormalizowany Różnicowy Wskaźnik Wegetacji (NDVI)")
