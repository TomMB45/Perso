package ex14;
import java.lang.Math;
public class Exo14 {

    public static void affTab(double[] tableau) {
        for (double value : tableau) {System.out.println(value);}
    }
    
    public static void main(String[] args) {
        double[] tableau = new double[10];
        
        for (int i=0; i < tableau.length ; i++){
            tableau[i] = Math.random(); 
        }
        affTab(tableau);
    }
}
