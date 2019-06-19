# METODY NUMERYCZNE - PROJEKT 1

Celem projektu było zaimplementowanie wskaźnika giełdowego MACD, wykorzystując dowolny język programowania.
Wskaźnik był sprawdzany na kursach 10 różnych walut w okresie od 01.04.2015 do 19.03.2019. 
Dane zaczerpnięto z serwisu money.pl. 

Aby uruchomić program wystarczy wpisać ```python main.py``` w konsoli.

# Dodatkowe informacje

Domyślnie w kodzie ustawione jest wykonywanie operacji tylko na kursie jena japońskiego, w określonym powyżej okresie, z domyślnym algorytmem liczącym MACD. 

Aby uruchomić program z ulepszonym algorytmem, należy zmienić parametr w wywołaniu funkcji:
```
Simulator.single_currency_simulator(Simulator(), 'jen_japonski.csv', False)
```
z ```False``` na ```True```.

Aby uruchomić program dla wszystkich walut, których kursy są zawarte w folderze ```data```, należy wykonać funkcję:
```
   Simulator.multi_currency_simulator(Simulator(), True)
```
