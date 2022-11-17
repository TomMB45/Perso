package ex6;
import java.util.*;


public class Exo6 {
    public static void main(String[] args) {
        Random generateur = new Random();
        Scanner clavier = new Scanner(System.in); 
        int resultat , user=100; 

        resultat= generateur.nextInt(10);
 
        for (int i = 0 ; i <= 10 && user != resultat; i++){
            System.out.println("Choississez un nombre entre 0 et 10");
            user = clavier.nextInt(); clavier.nextLine(); 
            if (user == resultat){System.out.println("Bravo tu à réussit en "+i+" essais");}
            else {System.out.println("Raté recommence");}
        }
        clavier.close();
    }
}
