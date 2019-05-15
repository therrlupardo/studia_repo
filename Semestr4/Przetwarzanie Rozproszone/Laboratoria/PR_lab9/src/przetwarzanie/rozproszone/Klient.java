package przetwarzanie.rozproszone;

import java.util.Random;

public class Klient extends Thread {
    private Magazyn magazyn = null;
    private Integer number;

    @Override
    public void run(){
        log("Klient startuje");
        while (true) {
            Random generator = new Random();
            try {
                sleep((generator.nextInt(10)+1) * 1000);
                Integer amount = generator.nextInt(5)+1;
                Produkty produkt;
                switch(generator.nextInt(3)){
                    case 0:
                        produkt = Produkty.KANAPKI;
                        break;
                    case 1:
                        produkt = Produkty.KAPCIE;
                        break;
                    default:
                        produkt = Produkty.SZAFKI;
                        break;

                }
                log("Próba zakupu "+amount + " "+produkt);
                Integer output = magazyn.WydajProdukt(produkt, amount);
                if (output.equals(amount)) {
                    log("Zakupiono " + amount + " " + produkt);
                }
                else if (output == -1){
                     log("Brak produktu " + produkt + " w magazynie!");
                }
                else{
                    log("Zakupiono tylko " + output + " " + produkt + ". Nie było więcej w magazynie");
                }
            } catch (Exception e) {
                System.err.println(e.getClass());
            }
        }
    }

    private void log(String text){
        System.out.println("KLIENT"+this.number+":       " + text);
    }

    Klient(Magazyn magazyn, Integer number){
        this.magazyn = magazyn;
        this.number = number;
    }
}
