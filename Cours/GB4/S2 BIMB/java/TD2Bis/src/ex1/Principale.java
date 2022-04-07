package ex1;


public class Principale {
    
    public static void main(String[] args) {
    Vehicule v1 = new Vehicule("V1", 592.2, 300); 
    Vehicule v2 = new Vehicule("V2", 72.2, 0);
    /*
    System.out.println(v1.toString());
    System.out.println(v2.toString());
    System.out.println("Il y a " + v1.Compte_Vehicule() + " dans notre parc de véhicule");
    System.out.println(v2.Plus_Cher(v1));
    */
    Moto M1 = new Moto("M3", 500, 300, "Cuir"); 
    Velo V1 = new Velo("V1", 30, 0); 

    Vehicule[] tab = new Vehicule[4]; 
    tab[0]=v1; 
    tab[1]=v2; 
    tab[2]=M1;
    tab[3]=V1; 

    double tot = 0 ; 
    for (Vehicule parc : tab) {
        tot = tot+parc.get_Price(); 
        parc.toString(); 
    }

    System.out.println("Je possède un patrimoine de : " + tot + " euros en véhicule") ; 
    }

    
}
