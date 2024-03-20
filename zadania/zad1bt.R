library("terra")
sciezka=system.file("ex/logo.tif", package = "terra")

logo=rast(sciezka)
logo
setwd("D:/Studia_xD/Rok4/ZAP/roboczyZAP")

url= "https://naciscdn.org/naturalearth/110m/physical/ne_110m_land.zip"
download.file(url, "ne_110_land.zip", mode = "wb")
unzip("ne_110_land.zip", exdir = "ne_110_land1")

urlLakes="https://naciscdn.org/naturalearth/110m/physical/ne_110m_rivers_lake_centerlines.zip"
download.file(urlLakes, "ne_110m_rivers_lake_centerlines.zip", mode = "wb")
unzip("ne_110m_rivers_lake_centerlines.zip", exdir = "ne_110m_rivers_lake_centerlines1")

lakes=vect("ne_110m_rivers_lake_centerlines1/ne_110m_rivers_lake_centerlines.shp")
lakes

land=vect("ne_110_land1/ne_110m_land.shp")
land

plot(land, background="lightblue", col="lightgreen", main="Mapa Świata")
plot(lakes, add=TRUE,col="blue")

