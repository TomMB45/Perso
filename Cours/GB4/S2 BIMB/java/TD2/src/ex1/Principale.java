package ex1;

import java.util.Scanner;

public class Principale {
    
    public static void main(String[] args) {
        //Part 1 
        Polygone p1 = new Polygone(2,10);
        //int p1_nb = p1.getCote(); 
        System.out.println( p1.toString() ); 
        Polygone p2 = new Polygone();

        System.out.println("P1 à : "+p1.getCote()+" cotés de longueur " +p1.getL());

        System.out.println();

        p2.setCote(5);
        p2.setL(3);
        System.out.println("P2 à : "+p2.getCote()+" cotés de longueur "+p2.getL());
        System.out.println();

        System.out.println(p1.getNbPolygone() +" polygones ont été crée");

        //Part 2 
        System.out.println( p2.toString() ); 
        //System.out.println( p1.toString() ); 

        //Part 3 
        //Part 4 
        Scanner clavier = new Scanner(System.in); 
        int nb_modif_clone = 0 ; 
        System.out.println("Combien de coté voulez vous ajouter/retirer à P1");
        nb_modif_clone = clavier.nextInt(); clavier.nextLine(); 
        Polygone Clone = Polygone.presqueClone(p1.getCote(),nb_modif_clone, p1.getL()) ; 
        System.out.println(Clone.toString());

        clavier.close(); 

        //Part 5 
        System.out.println(Polygone.plusPetit(p1, Clone));

    }
    
}
