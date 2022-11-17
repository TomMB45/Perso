package ex1; 
public class Vehicule {
    //Variable de classe
    public static int NbVéhicule = 0 ;  

    //Variables d'instances 
    protected String Modele ; 
    protected double Valeur ; 
    protected int Cylindre ;     

    //Constructeurs 
    public Vehicule(String modele, double prix, int puissance){
        Modele=modele; 
        Valeur = prix;
        Cylindre=puissance;
        NbVéhicule++; 
    }

    //Accesseur 
    public double get_Price(){return Valeur;}

    //redéfinition de méthodes 
    public String toString(){
        if (Cylindre > 0){
        return Modele + " (" + Cylindre + "cm^3) : " + Valeur + "euros";}
        else {return Modele + " (véhicule non motorisée) : " + Valeur + " euros";}
    }

    public int Compte_Vehicule(){return NbVéhicule;}

    public double Plus_Cher(Vehicule vehicule_a_comparé){
        if ( vehicule_a_comparé.get_Price() > get_Price()){return vehicule_a_comparé.get_Price(); }
        else {return get_Price();}
    }


    
}
