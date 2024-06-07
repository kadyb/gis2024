# Jakub Grabowski & Filip Skiba

library("terra")
library("fields")
library("gstat")

meteo_df = read.csv("../dane/dane_meteo.csv")
str(meteo_df)

summary(meteo_df$OPAD)
hist(meteo_df$OPAD, main = NULL, breaks = 10, xlab = "Suma opadów [mm]",
     ylab = "Częstość" )
meteo = vect(meteo_df, geom = c("X", "Y"), crs = "EPSG:4326")
meteo

plot(meteo, "TYP", col = c("purple", "blue"), alpha = 0.7,
     main = "Stacje meteorologiczne")

paleta = hcl.colors(10, palette = "Blues 2", rev = TRUE)
plot(meteo, "OPAD", type = "continuous", col = paleta,
     main = "Suma opadów [mm]")

r = rast(meteo, resolution = 0.01)
r

# loswość
set.seed(2)
n = nrow(meteo_df)
indeksy = sample(n, size = 0.7 * n)
trening = meteo_df[indeksy, ]
test = meteo_df[-indeksy, ]

plot(meteo[indeksy], col = "green", alpha = 0.8)
plot(meteo[-indeksy], col = "blue", alpha = 0.8, add = TRUE)
add_legend("bottomleft", legend = c("Treningowe", "Testowe"),
           col = c("green", "blue"), pch = 19, cex = 0.9)

RMSE = function(obserwowane, predykcja) {
  sqrt(mean((predykcja - obserwowane) ^ 2))
}

# ============= METODY INTERPOLACJI
# Naturalna interpolacja sąsiadów

mdl = gstat(formula = OPAD ~ 1, locations = ~X + Y, data = trening, nmax = 10,
            set = list(idp = 0))
nn = interpolate(r, mdl, xyNames = c("X", "Y"), debug.level = 0)
nn = subset(nn, 1) # wybiera tylko pierwszą warstwę
plot(nn, col = paleta)

nn_test = predict(mdl, test, debug.level = 0)$var1.pred
rmse_nn <- RMSE(test$OPAD, nn_test)

# Interpolacja wielomianowa

mdl = gstat(formula = OPAD ~ 1, locations = ~X + Y, data = trening,
            degree = 3)
poly = interpolate(r, mdl, xyNames = c("X", "Y"), debug.level = 0)
#zamiana wartości ujemnych na dodatnie
poly_vals = values(poly)
poly_vals[poly_vals < 0] <- 0
values(poly) <- poly_vals
poly = subset(poly, 1)
plot(poly, col = paleta)
# test
poly_test = predict(mdl, test, debug.level = 0)$var1.pred
poly_test <- pmax(poly_test, 0)
rmse_poly <- RMSE(test$OPAD, poly_test)

# Odwrotne ważenie odległości

mdl = gstat(formula = OPAD ~ 1, locations = ~X + Y, data = trening,
            set = list(idp = 2))
idw = interpolate(r, mdl, xyNames = c("X", "Y"), debug.level = 0)
idw = subset(idw, 1)
plot(idw, col = paleta)
# test
idw_test = predict(mdl, test, debug.level = 0)$var1.pred
rmse_idw <- RMSE(test$OPAD, idw_test)

# Kriging

gst = gstat(formula = OPAD ~ 1, locations = ~X + Y, data = trening)
v = variogram(gst, width = 0.4)
plot(v)
fv = fit.variogram(v, vgm(psill = 3, model = "Sph", range = 2, nugget = 1))
fv

plot(v, model = fv)

mdl = gstat(formula = OPAD ~ 1, locations = ~X + Y, data = trening, model = fv)
kr = interpolate(r, mdl, xyNames = c("X", "Y"), debug.level = 0)
names(kr) = c("Predykcja", "Wariancja")

par(mfrow = c(1, 2))
plot(kr[[1]], col = paleta, main = "Predykcja")
plot(kr[[2]], col = gray.colors(n = 10, rev = TRUE), main = "Wariancja")
# test
kr_test = predict(mdl, test, debug.level = 0)$var1.pred
rmse_kr <- RMSE(test$OPAD, kr_test)

par(mfrow = c(1, 1))

# Interpolacja metodą cienkiej płytki (TPS)
tps_model = Tps(as.matrix(trening[, c("X", "Y")]), trening$OPAD)
tps_rast = interpolate(r, tps_model, xyNames = c("X", "Y"))
plot(tps_rast, col = paleta, main = "Interpolacja metodą cienkiej płytki")

# Predykcja
tps_test_pred = predict(tps_model, as.matrix(test[, c("X", "Y")]))
tps_rmse = RMSE(test$OPAD, tps_test_pred)
print(paste("RMSE TPS:", tps_rmse))

# Podsumowanie wyników RMSE
results <- data.frame(
  Method = c("Naturalna interpolacja sąsiadów", "Interpolacja wielomianowa", "Odwrotne ważenie odległości", "Kriging", "TPS"),
  RMSE = c(rmse_nn, rmse_poly, rmse_idw, rmse_kr, tps_rmse)
)
print(results)

# Jak można zauważyć przy metodzie cienkiej płyty wartość jest najmniejsza co oznacza że ma najmiejszy błąd średnio kwadratowy.
