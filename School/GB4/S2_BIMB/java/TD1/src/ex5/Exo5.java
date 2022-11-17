package ex5;

import java.util.Scanner;

public class Exo5 {

	public static void main(String[] args) {
		Scanner clavier = new Scanner(System.in);
		int int1,int2,index=0,reste = 0;
		
		System.out.print("Premier nombre entier");
		int1 = clavier.nextInt(); clavier.nextLine();
		System.out.print("Deuxieme nombre entier");
		int2 = clavier.nextInt(); clavier.nextLine();
		
		while (int1>=int2) {
			int1=int1-int2; 
			index = index+1; 
			reste=int1;
		}
		System.out.println("Quotient = " + index +"\nReste = " + reste);
		clavier.close();
	}

}
