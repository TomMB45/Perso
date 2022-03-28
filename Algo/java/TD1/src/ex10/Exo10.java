package ex10;

import java.util.*;

public class Exo10 {
    public static void main(String[] args) {
    Random generateur = new Random();
    int[] tableau = new int[10]; 
    int resultat;

    for (int i=0; i<100; i++){
        resultat= generateur.nextInt(10)+1;
        tableau[resultat-1]=tableau[resultat-1] + 1;
    }
    for (int i=0; i<tableau.length ; i++){
        System.out.println("La valeur " + (i+1) +" est apparue avec une fréquence de : " + tableau[i] + " %");
    }

    }
}
