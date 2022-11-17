package ex2;

public class Segment {
    //Variables d'instances 
    private int x1 = 0;
    private int y1 = 0;
    private int x2 = 0;
    private int y2 = 0;

    //Constructeur 
    public Segment(int x_1, int y_1, int x_2,int y_2){
        x1 = x_1; 
        y1 = y_1; 
        x2 = x_2; 
        y2 = y_2; 
    }

    //Accesseur
    public int get_x1 () {return x1;}
    public int get_y1 () {return y1;} 
    public int get_x2 () {return x2;}
    public int get_y2 () {return y2;} 

    // Méthode de classe 
    public String toString (){return ("Segment délimité par les points " + "(" + x1 + ","+y1+")" + " et " + "(" + x2 + ","+y2+")");}

}
