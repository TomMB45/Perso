package ex4;

import java.util.Scanner;

public class Exo4 {

	public static void main(String[] args) {
		Scanner clavier = new Scanner(System.in);
		int i,table;
		System.out.print("Quelle table de multiplication ?");
		table=clavier.nextInt();clavier.nextLine(); 
		clavier.close();
		
		for (i=0;i<=10;i++) {
			System.out.println((table*i));
		};
		
	}
	

}
