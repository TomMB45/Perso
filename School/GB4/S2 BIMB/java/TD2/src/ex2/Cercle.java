package ex2;

public class Cercle { 
    //Variable de classe

    //Variables d'instances 
    private int x = 0;
    private int y = 0;
    private int diametre = 0; 

    //Constructeurs 
    public Cercle(int x_C,int y_C, int diametre_C){
        x=x_C;
        y=y_C;  
        diametre = diametre_C; 
    }
    public Cercle(Segment S){
        
    }

    // Méthode de classe 
    public String toString ()
    {return ("Cercle de centre " + "(" + x + ","+y+")" + " et de rayon "+diametre);}

    //Classe abstraite de l'interface Forme 
    public Point Centre() { 
        Point Centre = new Point(x,y) ; 
        return Centre; 
    }
}
