package przetwarzanie.rozproszone;

import java.util.Random;

public class Producent extends Thread {
    private Produkty produkt;
    private Magazyn magazyn = null;
    private Integer number;

    @Override
    public void run() {
        log("Producent " + this.produkt + " startuje");
        while (true) {
            Random generator = new Random();
            try {
                sleep((generator.nextInt(10)+1) * 1000);
                Integer amount = (generator.nextInt(5)+1);
                Integer output = magazyn.OdbierzProdukt(this.produkt, amount);
                if (output.equals(amount)) {
                    log("Wyprodukowano " + amount + " " + this.produkt);
                }
                else if(output != -1){
                    log("Wyprodukowano " + amount + " " + this.produkt+ ". Nie było więcej miejsca.");
                }
                else{
                    log("Produkcja " + amount + " " + this.produkt + " nie powiodła się");
                }
            } catch (Exception e) {
                System.err.println(e.getClass());
            }
        }

    }

    private void log(String text) {
        System.out.println("PRODUCENT"+ this.number +":    " + text);
    }

    Producent(Produkty produkt, Magazyn magazyn, Integer number) {
        this.produkt = produkt;
        this.magazyn = magazyn;
        this.number = number;
    }
}
