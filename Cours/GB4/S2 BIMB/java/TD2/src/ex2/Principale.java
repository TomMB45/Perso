package ex2;

import java.util.Scanner;

public class Principale {
    public static void main(String[] args) {
    //Partie 1
    Point pt1 = new Point(2,3); 
    Point pt2 = new Point(5,9); 
    
    //System.out.println(pt1.toString());
    
    //Partie 2 
    Scanner clavier = new Scanner(System.in);
    System.out.println("Diamètre du cercle ?");
    int diametre = clavier.nextInt(); clavier.nextLine();  

    Cercle C1 = new Cercle(pt2.get_x(), pt2.get_y(), diametre);
    
    System.out.println(C1.toString());
    
    clavier.close(); 

    //Partie 3 
    Segment S1 = new Segment(pt1.get_x(), pt1.get_y(), pt2.get_x(), pt2.get_y());
    System.out.println(S1.toString());

    //Partie 4 
    
    
    }
}
