package ex2;

public class Point {
    //Variable de classe
    public static int nbPoint = 0;
    private static double distance = 0;  

    //Variables d'instances 
    private int x = 0;
    private int y = 0;  
     
    //Constructeurs 
    public Point(int x_pt,int y_pt){
        x=x_pt;
        y=y_pt;  
        nbPoint++; 
    }

    //Accesseur 
    public int get_x () {return x;}
    public int get_y () {return y;} 
    
    // Méthode de classe 
    public String toString (){return ("Point n° : " + nbPoint + " (" + x + ","+y+")");}

    //Méthode 
    public void dist(Point p) {
        distance = Math.sqrt( Math.pow(Math.abs(x-p.get_x()),2) + Math.pow( Math.abs(y-p.get_y()),2) ); 
        System.out.println(distance);
    }

}
