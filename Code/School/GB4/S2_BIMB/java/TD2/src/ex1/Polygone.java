package ex1; 
public class Polygone {
    //Variable de classe
    public static int NbPolygone = 0 ;  
    public static int nbCote = 0 ;  

    //Variables d'instances 
    private int Cote =  0 ; 
    private int L = 0 ; 
    private int perim = 0 ; 
    //private int nb_a_supprimer = 0 ; 
    

    //Constructeurs 
    public Polygone(){
        Cote=0;
        L=0;
        NbPolygone++;
    }
    public Polygone(int nbCote, int len) {
        Cote = nbCote ; 
        L = len ;
        NbPolygone++; 
        perim= calcPerim(nbCote, len); 
    }

    //Accesseur & Mutateurs 
    public void setCote (int nbCote){Cote=nbCote;}
    public int getCote () {return Cote;}

    public void setL (int len){L=len;}
    public int getL () {return L;}

    public int getNbPolygone(){return NbPolygone;}

    public void setPerim (int nbCote, int len){perim = calcPerim(nbCote, len);}; 
    public int getPerim(){return perim;}

    // Méthode de classe 
    public String toString (){return ("Polygone n° " + NbPolygone + " à " + Cote + " cotés de longueur " + L + " dont le périmètre est de : " + perim);}

    //Méthodes 
    private static int calcPerim (int C , int L) {return (C*L);} 
    public static Polygone presqueClone(int nbC_initial, int nb_supprimer, int len) {
        Polygone Clone = new Polygone(nbC_initial+nb_supprimer,len);  
        return Clone; 
    }
    public static String plusPetit(Polygone p1, Polygone p2) {
        int peri1=0,peri2=0; 
        peri1=Polygone.calcPerim(p1.getCote(),p1.getL());
        peri2=Polygone.calcPerim(p1.getCote(),p1.getL()); 

        if (peri1==peri2){return "Les deux polynomes ont la même taille"; }
        else if (peri1>peri2){return "Le 1er polygone passé en argument est le plus petit";}
        else {return "Le 2nd polygone passé en argument est le plus petit";}
    }
}
