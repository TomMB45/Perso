package ex13;
import java.util.Scanner;


public class Exo13 {
    public static double[][] Transposee (double[][] matrix) {
        double[][] transposee = new double[matrix[0].length][matrix.length]; 

        for (int i=0; i<matrix.length; i++){
            for (int j = 0 ; j<matrix[0].length;j++){
                transposee[j][i] = matrix[i][j] ;
            }
        }
        return transposee ;
    }

    public static double[][] Multiplication_réel(double[][] matrix, double n) {
        for (int i = 0 ; i < matrix.length ; i++){
            for (int j = 0 ; j < matrix[0].length ; j++){
                matrix[i][j] = matrix[i][j]*n; 
            }
        }
        return matrix ;
    }

    public static void affMat(double[][] matrix) {
        for (int i = 0 ; i < matrix.length ; i++){
            for (int j = 0 ; j < matrix[0].length ; j++) {
                System.out.println("Valeur pour la ligne " + i +" et à la colonne "+j+" :" +matrix[i][j]);
            }
        } 
    }
    public static void main(String[] args) {
        System.out.println("Attention la partie sur la transposée d'une matrice ne fonctionne que pour des matrices carrées de nimporte quel ordre !!!!");
        Scanner clavier = new Scanner(System.in); 
        int taille_lignes, taille_colonnes;
        double n,entree ;  

        System.out.println("Nb de lignes de la matrice a transposée ?");
        taille_lignes = clavier.nextInt();clavier.nextLine(); 
        System.out.println("Nb de colonnes de la matrice a transposée ?");
        taille_colonnes = clavier.nextInt();clavier.nextLine();
        
        double[][] matrice = new double[taille_lignes][taille_colonnes]; 
        for (int i = 0 ; i < matrice.length ; i++){
            for (int j = 0 ; j < matrice[0].length ; j++){
                System.out.println("Valeur pour la ligne " + i +" et à la colonne "+j);
                entree = clavier.nextDouble();clavier.nextLine();
                matrice[i][j] = entree; 
            }
        }
        System.out.println("Matrice a multiplié par ?");
        n = clavier.nextDouble();clavier.nextLine();
        Multiplication_réel(matrice, n); 
        affMat(matrice);

        System.out.println("#################################");
        System.out.println("##########Transposition##########");
        System.out.println("#################################");
        Transposee(matrice) ; 
        affMat(matrice); 

        clavier.close(); 
    }    
}