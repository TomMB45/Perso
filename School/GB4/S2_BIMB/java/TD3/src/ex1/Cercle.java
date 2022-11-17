package ex1;
import java.lang.Math;

public class Cercle extends Point implements Forme{ 
    //Variable de classe
    //Toutes issues de la classe Point 

    //Variables d'instances 
    private int diametre = 0; 
    
    //Constructeurs 
    public Cercle(int x_C,int y_C, int diametre_C) throws Exception_perso{
        super(x_C, y_C); 
        x=x_C;
        y=y_C;  
        if (diametre_C < 0){throw new Exception_perso();}
        else {diametre = diametre_C; }
    }

    // Méthode de classe 
    public String toString ()
    {return ("Cercle de centre " + "(" + x + ","+y+")" + " et de rayon "+diametre);}

    //Classe abstraite de l'interface Forme 
    public Point Centre() { 
        Point Centre = new Point(x,y);
        return Centre; 
    }

    public double Circonference(){
        double len = diametre * Math.PI ; 
        return len;
    }

    public void Dessine(){
        System.out.println("Au compas : " + toString() + "Soit une circonférence égale à : "+ Circonference());
    }

}
