package ex11;
import java.util.Scanner;

public class Exo11 {

    public static int[] multiplication(int nb) {
        int tableau[] = new int[11]; 
        int i; 
        for (i=0;i<=10;i++) {tableau[i] = nb*i;}
        return tableau;}

    public static void main(String[] args) {
        Scanner clavier = new Scanner(System.in);
        int table, choix_methode;  
        System.out.println("1(1 table) ou 2(table de 2 à 9)");
        choix_methode = clavier.nextInt(); 

        if (choix_methode == 1){
		System.out.print("Quelle table de multiplication ?");
		table=clavier.nextInt();clavier.nextLine();
        int[] tableau = multiplication(table);  

        for (int value : tableau){
            System.out.println(value);}
        } else {
            for (int i=2 ; i <=9;i++){
                System.out.println("##############Table de " + i + " ##############");
                int[] tableau = multiplication(i);  
                for (int value : tableau){
                System.out.println(value);}
            }
        }
		clavier.close();
    }
}