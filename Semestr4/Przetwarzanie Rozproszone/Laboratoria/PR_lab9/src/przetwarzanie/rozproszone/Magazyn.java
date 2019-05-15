package przetwarzanie.rozproszone;

import java.util.HashMap;
import java.util.Map;

public class Magazyn extends Thread {

    private Map<Produkty, Integer> magazyn;
    private Integer max_capacity;
    private Integer amount_in_store;
    @Override
    public void run(){
        log("Magazyn startuje");
    }

    private void log(String text){
        System.out.println("MAGAZYN:       " + text);
    }

    Magazyn(){
        this.magazyn = new HashMap<>();
        this.max_capacity = 100;
        this.amount_in_store = 0;
    }

    public synchronized Integer OdbierzProdukt(Produkty produkt, Integer amount){
        if(this.magazyn.containsKey(produkt)){
            Integer value = this.magazyn.get(produkt);
            if(this.amount_in_store + amount <= this.max_capacity){
                this.amount_in_store += amount;
                value += amount;
            }
            else {
                value += this.max_capacity - this.amount_in_store;
                this.amount_in_store = this.max_capacity;
            }
            if(!value.equals(0)){
                this.magazyn.remove(produkt);
                this.magazyn.put(produkt, value);
                log("Dodano " + value + " produktu " + produkt + " do mogazynu");
                log("W magazynie jest aktualnie " + this.amount_in_store + " produktów: ");
                for(Map.Entry<Produkty, Integer> entry : this.magazyn.entrySet()){
                    log(entry.getKey() + ": "+ entry.getValue());
                }
                return value;
            }
            else{
                return -1;
            }
        }
        else{
            if(this.amount_in_store + amount <= this.max_capacity){
                this.amount_in_store += amount;
                this.magazyn.put(produkt, amount);
                log("Dodano " + amount + " produktu " + produkt + " do mogazynu");
                return amount;
            }
            else if (!this.amount_in_store.equals(this.max_capacity)){
                Integer value = this.max_capacity - this.amount_in_store;
                this.magazyn.put(produkt, value);
                this.amount_in_store = this.max_capacity;
                log("Dodano " + value + " produktu " + produkt + " do mogazynu");
                return value;
            }
            return -1;
        }

    }

    public synchronized Integer WydajProdukt(Produkty produkt, Integer amount){
        if(this.magazyn.containsKey(produkt)){
            if(this.magazyn.get(produkt) >= amount){
                Integer value = this.magazyn.get(produkt);
                this.magazyn.remove(produkt);
                this.magazyn.put(produkt, value-amount);
                this.amount_in_store -= amount;
                log("Sprzedano " + amount + " " + produkt);
                return amount; // return true
            }
            else {
                Integer value = this.magazyn.get(produkt);
                this.magazyn.remove(produkt);
                log("Sprzedano " + value + " " + produkt);
                this.amount_in_store -= value;
                return value; // return true
            }
        }
        else {
            return -1;
        }
    }
}
