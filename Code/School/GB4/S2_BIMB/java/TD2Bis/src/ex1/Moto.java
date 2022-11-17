package ex1;

public class Moto extends Vehicule implements Deplacement {
    private String type_selle; 

    public Moto(String modele, double prix, int puissance, String selle){
        super(modele, prix, puissance); 
        type_selle=selle; 
    }

    //Redef
    public String toString(){return type_selle;}

    public String Accelere(){return "J'accélère à la main en utilisant la poignée des gaz";}
    public String Freine(){return "Je freine avec un levier";}
    
}
