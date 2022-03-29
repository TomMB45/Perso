package ex3;

import java.util.Scanner;

public class Exo3 {
	public static void main (String[] args) {
		Scanner clavier = new Scanner(System.in);
		int int1,int2;
		char operation;
		
		System.out.print("Premier nombre entier");
		int1 = clavier.nextInt(); clavier.nextLine();
		System.out.print("Opérateur");
		operation = clavier.nextLine().charAt(0); 
		System.out.print("Deuxieme nombre entier");
		int2 = clavier.nextInt(); clavier.nextLine();
		
		if (operation == '+') {System.out.println((int1+int2));}
		else if (operation == '-') {System.out.println((int1 - int2));}
		else if (operation == '*') {System.out.println((int1 * int2));}
		else if (operation == '/') {System.out.println((int1 / int2));} ;		
		clavier.close();	
	}
}
