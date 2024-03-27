library("terra")

sciezka_do_logo = system.file("ex/logo.tif", package = "terra")
sciezka_do_logo # wyświetl

logo = rast(sciezka_do_logo)

logo
