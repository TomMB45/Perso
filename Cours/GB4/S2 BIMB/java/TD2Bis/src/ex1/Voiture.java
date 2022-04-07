package ex1;

public class Voiture extends Vehicule implements Deplacement {
    private int NB_Place; 

    public Voiture(String modele, double prix, int puissance,int nbPlace, int nb_place){
        super(modele, prix, puissance); 
        NB_Place=nbPlace; 
    }

    //Redef
    public String toString(){return "J'ai "+NB_Place +" places";}

    public String Accelere(){return "J'accélère avec le pied sur la pédale de droite";}
    public String Freine(){return "Je freine avec la pédale du milieu";}
    
}
