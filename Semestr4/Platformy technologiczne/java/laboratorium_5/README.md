# Laboratorium 5
Rozszerzenie laboratorium 4 o testy jednostkowe \
```mvn clean install``` - pobranie wszystkich zależności \
```localhost:8080``` - adres po uruchomieniu (domyślny w springu) \
```localhost:8080/swagger-ui.html``` - bardzo przyjemny plugin do podglądania requestów bez zabawy z postmanem

# Uruchomienie serwera bazy danych
Potrzebny jest Apache Derby, można wziąć [stąd](http://db.apache.org/derby/derby_downloads.html)\
Wypadkować, wejść do rozpakowanego folderu -> /lib

Tu najlepiej odpalić 2 konsole
* pierwsza jest instancją serwera, uruchamiamy za pomocą ```java -jar derbyrun.jar server start```\
* druga jest chyba odpowiedzialna bezpośrednio za bazę danych, tu należy dać najepirw ```java -cp "derbyclient.jar;derbytools.jar" org.apache.derby.tools.ij```, następnie ```connect 'jdbc:derby://localhost:1527/pt_lab;create=true';```

W IntelliJ: View -> Tools windows -> Databases -> '+' -> Data Source -> Apache Derby \
W properties należy ustawić URL only : ```jdbc:derby://localhost:1527/pt_lab;create=true``` \
Powinno ładnie śmigać.

# Przykładowe zapytania
* addComputer()
```
{
  "amount": 10,
  "graphic_card": "NVidia GeForce 550Ti",
  "memory": "4GB",
  "price": 2400,
  "processor": "Intel i5",
  "type": "PC"
}
```
* getComputers(), updateComputer() wymagają posiadania id filmu, które można wyciągnąć z listComputers()
* addOrder()
```
{
  "creationDate": "2019-03-27T20:02:36.567Z",
  "orderedComputers": [
    {
      "amount": 5,
      "computers": {
        "id": "tu_id_komputera_1",
      }
    },
    {
      "amount": 15,
      "computers": {
        "id": "tu_id_komputera_2",
      }
    }
  ]
}
```
* getOrder() wymaga id zamówienia, które można wyciągnąć z listOrders()

Warto podkreślić, że nigdzie (za wyjątkiem powyższego) nie potrzeba wstawiać id do zapytania (czasami w pathie potrzeba tylko), jest generowane losowo w kodzie.