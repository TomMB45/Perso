package sujet1;
import java.util.Scanner; 

public class ex1 {
	
	public static void main (String[] args) {
		Scanner clavier = new Scanner(System.in); 
		int voiture1=40,voiture2 = 50,jours,km;
		double tarif1 = 0.5 , tarif2 = 0.3;
		
		
		System.out.print("Combien de jours de location ?");
		jours = clavier.nextInt(); clavier.nextLine(); 
		System.out.print("Combien de km ?");
		km = clavier.nextInt(); clavier.nextLine(); 
		
		if (voiture1*jours+tarif1*km > voiture2*jours+tarif2*km) {
			System.out.print("Forfait 2, soit " + (voiture2*jours+tarif2*km) +"€" );
		}else {
			System.out.print("Forfait 1, soit " + (voiture1*jours+tarif1*km) +"€" );
		}
		clavier.close();
	}

}
