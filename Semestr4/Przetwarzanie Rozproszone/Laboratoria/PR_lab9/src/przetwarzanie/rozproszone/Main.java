package przetwarzanie.rozproszone;

public class Main {

    public static void main(String[] args) {
	// write your code here
        Magazyn magazyn = new Magazyn();
        Integer producenci = 0;
        Producent producent_kapci = new Producent(Produkty.KANAPKI, magazyn, ++producenci);
        Producent producent_kanapek = new Producent(Produkty.SZAFKI, magazyn, ++producenci);
        Producent producent_szafek = new Producent(Produkty.KAPCIE, magazyn, ++producenci);
        Integer klienci = 0;
        Klient klient1 = new Klient(magazyn, ++klienci);
        Klient klient2 = new Klient(magazyn, ++klienci);
        Klient klient3 = new Klient(magazyn, ++klienci);

        magazyn.start();
        producent_kanapek.start();
        producent_kapci.start();
        producent_szafek.start();
        klient1.start();
        klient2.start();
        klient3.start();
        System.out.println("WATEK GŁÓWNY STARTUJE");

    }
}
