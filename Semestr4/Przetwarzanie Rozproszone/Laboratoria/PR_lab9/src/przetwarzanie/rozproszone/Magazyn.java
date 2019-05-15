package przetwarzanie.rozproszone;

import java.util.HashMap;
import java.util.Map;

public class Magazyn extends Thread {

    private Map<Produkty, Integer> magazyn;
    private Integer max_capacity;
    private Integer amount_in_store;

    @Override
    public void run() {
        log("Magazyn startuje");
    }

    private void log(String text) {
        System.out.println("MAGAZYN:       " + text);
    }

    Magazyn() {
        this.magazyn = new HashMap<>();
        this.max_capacity = 100;
        this.amount_in_store = 0;
    }

    synchronized Integer OdbierzProdukt(Produkty produkt, Integer amount) {
        if (this.magazyn.containsKey(produkt)) {
            if (this.amount_in_store + amount <= this.max_capacity) {
                this.amount_in_store += amount;
                Integer value = amount + this.magazyn.get(produkt);
                this.magazyn.remove(produkt);
                this.magazyn.put(produkt, value);
                printStore();
                log("Dodano " + amount + " produktu " + produkt + " do mogazynu");
                return amount;
            } else if (!this.amount_in_store.equals(this.max_capacity)) {
                Integer value = this.max_capacity - this.amount_in_store;
                this.amount_in_store = this.max_capacity;
                value += this.magazyn.get(produkt);
                this.magazyn.remove(produkt);
                this.magazyn.put(produkt, value);
                log("Dodano " + value + " produktu " + produkt + " do mogazynu. Magazyn jest pelny.");
                printStore();
                return value;
            }
            else {
                log("Magazyn jest pelny.");
                return -1;
            }
        } else {
            if (this.amount_in_store + amount <= this.max_capacity) {
                this.amount_in_store += amount;
                this.magazyn.put(produkt, amount);
                log("Dodano " + amount + " produktu " + produkt + " do mogazynu niezawierajacego tego produktu");
                return amount;
            } else if (!this.amount_in_store.equals(this.max_capacity)) {
                Integer value = this.max_capacity - this.amount_in_store;
                this.magazyn.put(produkt, value);
                this.amount_in_store = this.max_capacity;
                log("Dodano " + value + " produktu " + produkt + " do mogazynu niezawierajacego tego produktu. Magazyn pelny");
                return value;
            }
            else{
                log("Magazyn pelny.");
                return -1;
            }

        }

    }

    private void printStore() {
        log("W magazynie jest aktualnie " + this.amount_in_store + " produktów: ");
        for (Map.Entry<Produkty, Integer> entry : this.magazyn.entrySet()) {
            log(entry.getKey() + ": " + entry.getValue());
        }
    }

    synchronized Integer WydajProdukt(Produkty produkt, Integer amount) {
        if (this.magazyn.containsKey(produkt)) {
            if (this.magazyn.get(produkt) >= amount) {
                Integer value = this.magazyn.get(produkt);
                this.magazyn.remove(produkt);
                if(value-amount != 0) {
                    this.magazyn.put(produkt, value - amount);
                }
                this.amount_in_store -= amount;
                log("Sprzedano " + amount + " " + produkt);
                log("W magazynie zostało " + this.amount_in_store + " produktów");
                return amount; // return true
            } else {
                Integer value = this.magazyn.get(produkt);
                this.magazyn.remove(produkt);
                log("Sprzedano " + value + " " + produkt +". Nie ma juz tego produktu w magazynie");
                log("W magazynie zostało " + this.amount_in_store + " produktów");
                this.amount_in_store -= value;
                return value; // return true
            }
        } else {
            log("W magazynie nie ma żadnego " + produkt);
            return -1;
        }
    }
}
