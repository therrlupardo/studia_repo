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
import java.util.Date;

public class DiskFile extends DiskElement {

    public DiskFile(String path){
        this.file = new File(path);
        this.path = path;
        this.name = file.getName();
        this.lastModified = new Date(file.lastModified());
    }

    protected void print(int depth){
        for(int i = 0; i < depth; i++) {
            System.out.print("-");
        }
        System.out.print(this.name + " P " + format.format(this.lastModified));
        System.out.println();
    }

    @Override
    public int compareTo(DiskElement o) {
       if(this.name.compareTo(o.name) > 0) return 1;
        else return -1;
    }
}