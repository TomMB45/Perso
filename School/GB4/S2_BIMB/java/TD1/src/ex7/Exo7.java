package ex7;

import java.util.Scanner;

public class Exo7 {

	public static void main(String[] args) {
		Scanner clavier = new Scanner(System.in);
		System.out.println("Combien de nombres entier voulez vous ?");
		final int nb = clavier.nextInt() ; clavier.nextLine();  
		int tableau[] = new int[nb],index=0,pair=0,impair=0; 
		
		for (index=0 ; index<nb ; index++) {
			System.out.println(index +" ème nombre entier");
			tableau[index] = clavier.nextInt(); clavier.nextLine();
			if (tableau[index] % 2 == 0) {pair=pair+1;}
			else {impair=impair+1;}
		};
		clavier.close();
		
		System.out.print("Il y a " + pair + " nombre pair \net " + impair + " nomnbre impairs dans le tableau");
	}
}