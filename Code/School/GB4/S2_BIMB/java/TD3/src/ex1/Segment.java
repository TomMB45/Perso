package ex1;

public class Segment implements Forme{
    //Variables d'instances 
    private Point p1;
    private Point p2;
    
    //Constructeur 
    public Segment(int x_1, int y_1, int x_2,int y_2){
        p1 = new Point(x_1,y_1); 
        p2 = new Point(x_2,y_2); 
    }

    //Accesseur
    public Point get_p1 () {return p1;}
    public Point get_p2 () {return p2;}  

    // Méthode de classe 
    public String toString (){return ("Segment délimité par les points " + p1 + " et " + p2);}

    //Méthode issue de la classe
    public Point Centre(){
        int x_centre = (p1.get_x()+p2.get_x())/2, y_centre = (p1.get_y()+p2.get_y())/2; 
        Point Centre = new Point(x_centre,y_centre); 
        return Centre ; 
    }

    public double Longueur(){
        return p1.dist(p2);
    }

    public void Dessine(){
        System.out.println("Au compas : " + toString() + " & de longueur : " + Longueur());
    }
}
