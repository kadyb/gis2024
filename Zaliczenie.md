# Projekty końcowe

Proszę wybrać jeden z poniższych projektów.

Projekt może zostać wykonany w grupie 2-3 osób.

Wyniki projektu należy zaprezentować na zajęciach oraz przesłać raport końcowy
(preferowany format to [R Markdown](https://rmarkdown.rstudio.com/)).

## * Klasyfikacja nienadzorowana

Wybierz powiat i dokonaj klasyfikacji nienadzorowanej dowolnego wielokanałowego zdjęcia
satelitarnego o niskim zachmurzeniu uwzględniając poniższe punkty:

1. Jako metodę referencyjną wykorzystaj algorytm k-means.
2. Sprawdź jak zmieni się wynik dla innej liczby klastrów.
3. Porównaj algorytm k-means z inną [metodą klasteryzacji](https://www.statmethods.net/advstats/cluster.html).
4. Dokonaj walidacji wyników wykorzystując wskaźnik *silhouette*.
5. Spróbuj zinterpretować, co przedstawiają wydzielone klastry wykorzystując wykres pudełkowy oraz kompozycję kanałów spektralnych.
6. Zaprezentuj wynik klasteryzacji na mapie i dobierz odpowiedni schemat kolorów.

## * Klasyfikacja nadzorowana

Wybierz powiat i dokonaj klasyfikacji nadzorowanej dowolnego wielokanałowego zdjęcia
satelitarnego o niskim zachmurzeniu uwzględniając poniższe punkty:

1. Jako dane referencyjne należy wykorzystać dowolny zbiór danych o pokryciu terenu. Przykładowo może być to [S2GLC](https://s2glc.cbk.waw.pl/), [CLC](https://land.copernicus.eu/en/products/corine-land-cover) czy [BDOT10K:Pokrycie Terenu](https://www.geoportal.gov.pl/pl/dane/baza-danych-obiektow-topograficznych-bdot10k/). Liczba klas nie powinna być zbyt duża.
2. Oceń skuteczność modelu na zbiorze testowym.
3. Wskaż, które klasy były najczęściej poprawnie i niepoprawnie klasyfikowane.
4. Porównaj wyniki klasyfikacji z mapą referencyjną (użyj identycznego schematu kolorów).
5. Oblicz procentowy udział poszczególnych klas pokrycia terenu na analizowanym obszarze.

## * Analiza wieloczasowa

Wybierz trzy obiekty (np. zbiornik wodny, las, pole uprawne) i pobierz kolekcje zdjęć satelitarnych
dla całego roku w celu analizy zmienności dwóch wybranych wskaźników spektralnych (np. NDVI, NDMI)
uwzględniając następujące punkty:

1. Wybrane obiekty nie powinny być zasłonięte przez chmury.
2. Wykorzystaj przynajmniej jedno zdjęcie dla każdego miesiąca.
3. Przygotuj mapy (pamiętaj o jednakowej skali barw) oraz wykresy liniowe.
