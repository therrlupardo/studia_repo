/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package platformy.technologiczne;

/**
 *
 * @author student
 */

import java.io.File;
import java.util.*;

public class DiskDirectory extends DiskElement {
    private Set<DiskElement> children;
    private String sorting;
    private Boolean rec;
    
    public DiskDirectory(String path, String sorting, Boolean rec) {
        this.sorting = sorting;
        this.rec = rec;
        if(sorting.equals("dlugosc")){
            children = new TreeSet<>((o1, o2) -> {
           if(o1.name.length() > o2.name.length()){
               return 1;
           }
           else if (o1.name.length() == o2.name.length() && o1.name.compareTo(o2.name) > 0){
               //System.out.println("TAKA SAMA DLUGOSC!");
               return 1;
           }
           else return -1;
        });
        }
        else if (sorting.equals("alfabet")){
            children = new TreeSet<>();
        }
        else{
            System.err.println("Nie ma takiego sortowania!");
            return;      
        }

        this.path = path;
        this.file = new File(path);
        this.name = file.getName();

        this.lastModified = new Date(file.lastModified());
        File[] files = this.file.listFiles();
        for (File it : Objects.requireNonNull(files)) {
            if (it.isDirectory() && !rec) {
                DiskDirectory disk = new DiskDirectory(it.getPath(), sorting, rec);
                this.children.add(Objects.requireNonNull(disk));
            } else {
                DiskFile dfile = new DiskFile(it.getPath());
                this.children.add(Objects.requireNonNull(dfile));
            }
        }
    }

    protected void print(int depth) {

        for (DiskElement it : children) {
            if (it.getClass() == DiskDirectory.class) {
                for (int i = 0; i <= depth; i++) {
                    System.out.print("-");
                }
                DiskDirectory dir = new DiskDirectory(it.getPath(), this.sorting, this.rec);
                System.out.print(dir.name + " K " + format.format(dir.lastModified));
                System.out.println();
                dir.print(depth+1);
            }
            else{
                DiskFile dfile = new DiskFile(it.getPath());
                dfile.print(depth+1);
            }
        }

        /*...pozostałe pola i metody...*/
    }

    @Override
    public int compareTo(DiskElement o) {
        if(this.name.compareTo(o.name) > 0) return 1;
        else return -1;
    }
}