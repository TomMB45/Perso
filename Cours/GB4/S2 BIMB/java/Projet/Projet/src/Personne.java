import java.util.ArrayList;

public class Personne {
    protected String Nom ; 
    protected String Pseudo;
    protected String Genre;
    protected String Famille;
    protected ArrayList<Personne> Amis ; 
    protected ArrayList<Personne> Ennemis; 

    public Personne(String Son_Nom, String Son_Pseudo, String Son_Genre, String Sa_famille/*, ArrayList<Personne> Ses_Amis,ArrayList<Personne> Ses_Ennemis*/){
        Nom=Son_Nom; 
        Pseudo = Son_Pseudo; 
        Genre=Son_Genre;
        Famille=Sa_famille; 
        // Amis=Ses_Amis; 
        // Ennemis=Ses_Amis;
    }

    public String toString(){
        return (Nom+" est un "+Genre+"\nIl a pour amis : " + Aff_lien(Amis)+"\n et pour ennemis : "+ Aff_lien(Ennemis)); 
    }

    public String Aff_lien(ArrayList<Personne> Amis_v_ennemis){
        String res = new String(); 
        if (Amis_v_ennemis.size()==0){return ("personne");}
        for (Personne elem : Amis_v_ennemis){res=res+elem+ " ";}
        return res; 
    }

    public String getNom() {
        return Nom;
    }

    public String getPseudo() {
        return Pseudo;
    }

    public String getGenre() {
        return Genre;
    }

    public String getFamille() {
        return Famille;
    }

}

