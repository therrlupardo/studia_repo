/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package platformy.technologiczne;

import java.io.File;

/**
 *
 * @author student
 */
public class BetterLS {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
//        String path = "D:\\po";
//        String sorting = "alfabet";
//        String sorting2 = "dlugosc";
//        String rec = "true";
        String path = args[0];
        String sorting = args[1];
        String rec = args[2];
        
        File tmp = new File(path);
        if(!tmp.exists()){
            System.out.println("Nie istnieje podana ścieżka!");
            return;
        }
        
        if(!sorting.equals("alfabet") && !sorting.equals("dlugosc")){
            System.out.println("Nieznane sortowanie!");
            return;
        }
        
        DiskDirectory dir;
        if(rec.equals("bez_rekurencji")){
            dir = new DiskDirectory(path, sorting, true);
        }
        else if(rec.equals("z_rekurencja")){
            dir = new DiskDirectory(path, sorting, false);
        }
        else{
            System.out.println("Nieznane polecenie rekurencji!");
            return;
        }
        dir.print(0);
    }
    
}
