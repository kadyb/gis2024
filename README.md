# Zaawansowane analizy przestrzenne

To repozytorium zawiera materiały do kursu **Zaawansowane analizy przestrzenne** prowadzonego na
Uniwersytecie Marii Curie-Skłodowskiej w 2024 r.

**R** jest jednym z najpopularniejszych języków programowania używanych do analizy danych.
Jest szeroko stosowany w analizach przestrzennych ze względu na dużą liczbę pakietów przeznaczonych
do [przetwarzania danych geoprzestrzennych](https://cran.r-project.org/web/views/Spatial.html).
**R** znalazł szczególne zastosowanie w takich dziedzinach ekologia, nauki środowiskowe czy
teledetekcja dzięki swojej prostocie, możliwości automatyzacji powtarzalnych zadań oraz ogromnemu
wsparciu przez jego społeczność. **R** stanowi świetną alternatywę dla standardowych aplikacji GIS
znacząco rozszerzając ich możliwość w kontekście statystycznej analizy danych i uczenia maszynowego.
Oprócz tego oferuje szeroki wachlarz technik wizualizacji danych.

# Wstęp

**1. Instalacja R**

Interpreter języka **R** można pobrać dla [Windows](https://cloud.r-project.org/bin/windows/base/R-4.3.2-win.exe), [MacOS](https://cran.r-project.org/bin/macosx/) oraz [Linux](https://cloud.r-project.org/bin/linux/).

**2. Instalacja RStudio**

**RStudio** jest zintegrowanym środowiskiem programistycznym z edytorem kodu.
Aplikacja dostępna jest na różnych platformach do pobrania w [tym miejscu](https://posit.co/download/rstudio-desktop/).

**3. Instalacja pakietów**

Jednym z najpopularniejszych pakietów do analizy przestrzennej w R jest pakiet [**terra**](https://github.com/rspatial/terra).
Umożliwia on analizę zarówno danych rastrowych i wektorowych.
Można go zainstalować w następujący sposób:

```r
install.packages("terra")
```

Następnie można go załadować używając funkcji `library()`.

```r
library("terra")
```

Dokumentację do tego pakietu znajdziesz tutaj: <https://rspatial.github.io/terra/reference/terra-package.html>

# Materiały

Materiały dostępne są w postaci interaktywnych notebooków (R Markdown).

* [Wprowadzenie](https://kadyb.github.io/gis2024/notebooks/01_wprowadzenie.html)
* [Przetwarzanie danych rastrowych](https://kadyb.github.io/gis2024/notebooks/02_przetwarzanie_raster.html)
* [Przetwarzanie danych wektorowych](https://kadyb.github.io/gis2024/notebooks/03_przetwarzanie_wektor.html)
* [Ortofotomapa](https://kadyb.github.io/gis2024/notebooks/04_ortofotomapa.html)
* [Cyfrowe modele wysokościowe](https://kadyb.github.io/gis2024/notebooks/05_cmw.html)
* [Interpolacja przestrzenna](https://kadyb.github.io/gis2024/notebooks/06_interpolacja.html)
* [Dane satelitarne](https://kadyb.github.io/gis2024/notebooks/07_dane_satelitarne.html)
* Klasyfikacja nienadzorowana
* Klasyfikacja nadzorowana
* Obliczenia równoległe
* Optymalizacja kodu
* Geointerfejsy

# Zaliczenie

Do zaliczenia kursu wymagane jest wykonanie jednego z proponowanych [projektów końcowych](./Zaliczenie.md).

# Literatura

1. ["Geocomputation with R"](https://r.geocompx.org/) Robin Lovelace, Jakub Nowosad i Jannes Muenchow
2. ["Spatial Data Science With Applications in R"](https://r-spatial.org/book/) Edzer Pebesma i Roger Bivand
3. ["Spatial Data Science with R and terra"](https://rspatial.org/) Robert Hijmans i inni

# Kontakt

W razie pytań proszę o kontakt na krzysztof.dyba@amu.edu.pl
