package ex1;

public class Velo extends Vehicule implements Deplacement {

    public Velo(String modele, double prix, int puissance){
        super(modele, prix, puissance); 
    }

    //Redef
    public String Accelere(){return "Je dois pédaler";}
    public String Freine(){return "Je freine en usant les semelles de mon utilisateur";}
    
}
