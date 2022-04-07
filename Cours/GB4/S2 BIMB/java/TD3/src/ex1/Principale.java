package ex1;

import java.util.InputMismatchException;
import java.util.Scanner;

public class Principale {
    public static void main(String[] args) throws Exception_perso {
    //Partie 1
    Point pt1 = new Point(2,3); 
    Cercle C1 ;  
        
    //Partie 2 
    Scanner clavier = new Scanner(System.in);
    System.out.println("Diamètre du cercle ?");
    int diametre;
    try{
    diametre = clavier.nextInt(); clavier.nextLine();  
    }catch(InputMismatchException e){
        System.out.println("Le diamètre doit être un nombre entier, il sera donc initialisé à 1");
        diametre=1; 
    }

    try{
    C1 = new Cercle(pt1.get_x(), pt1.get_y(), diametre);
    }catch(Exception_perso except){
        System.out.println("Le diamètre d'un cercle ne peut pas avoir un rayon négatif il sera donc remplacé par 1");
        C1 = new Cercle(pt1.get_x(), pt1.get_y(), 1);
    }
    
    System.out.println(C1.toString());
    clavier.close();
    }
}
