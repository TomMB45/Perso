package ex12;
import java.util.Scanner;
public class Exo12 {

    public static double TVA(double prix,double classe) {
        if (classe == 1) {return prix+prix*0.05;}
        else {return prix+prix*0.195;}
        }
    
    public static void main (String[] args) {
		Scanner clavier = new Scanner(System.in);
		double prix_HT ,nb_articles;
		int categorie ; 
		
		System.out.println("Prix hors taxes ?");
		prix_HT = clavier.nextInt(); clavier.nextLine();
		System.out.println("Carégorie du produit(1 ou 2 ou 3) ?");
		categorie = clavier.nextInt(); clavier.nextLine();
		System.out.println("Nombre d'articles dans le lot");
		nb_articles = clavier.nextInt(); clavier.nextLine();
		
		if (categorie == 1) {
			System.out.println("Prix TTC d'un article : " + TVA(prix_HT,categorie) + "€");
			System.out.println("Prix TTC du lot : " + (TVA(prix_HT,categorie)*nb_articles) + "€");
		} else {
			System.out.println("Prix TTC d'un article : " + TVA(prix_HT,categorie) + "€");
			System.out.println("Prix TTC du lot : " + (TVA(prix_HT,categorie)*nb_articles) + "€");
		}		
		clavier.close();

	}
}
