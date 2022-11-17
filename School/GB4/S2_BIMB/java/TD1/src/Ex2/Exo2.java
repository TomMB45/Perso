package Ex2;

import java.util.Scanner;

public class Exo2 {
	public static void main (String[] args) {
		Scanner clavier = new Scanner(System.in);
		double prix_HT ,nb_articles;
		String categorie = new String(); 
		
		System.out.print("Prix hors taxes ?");
		prix_HT = clavier.nextInt(); clavier.nextLine();
		System.out.print("Carégorie du produit ?");
		categorie = clavier.nextLine().toUpperCase();
		System.out.print("Nombre d'articles dans le lot");
		nb_articles = clavier.nextInt();
		
		if (categorie.equals("ALIM")) {
			System.out.print("Prix TTC d'un article : " + (prix_HT+prix_HT*0.05) + "€");
			System.out.println("Prix TTC du lot : " + ((prix_HT+prix_HT*0.05)*nb_articles) + "€");
		} else {
			System.out.print("Prix TTC d'un article : " + (prix_HT+prix_HT*0.196) + "€");
			System.out.println("Prix TTC du lot : " + ((prix_HT+prix_HT*0.196)*nb_articles) + "€");
		}		
		clavier.close();

	}

}