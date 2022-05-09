import java.util.ArrayList;
import java.util.Scanner;



public class Principale {
    public static void main(String[] args) throws Exception{
        Affichage a = new Affichage(); 
        a.setVisible(true);







        // Variables 
        // ArrayList<String> mb_Fam = new ArrayList<String>(); 
        // ArrayList<String> Amis_de_qq1 = new ArrayList<String>();

        Scanner clavier = new Scanner(System.in);

        System.out.println("1) Quels sont tous les membres d'une famille donnée ?");
        
        //Récupération de la base de donnée
        Class.forName("org.sqlite.JDBC"); 
        // BDD db = new BDD("superheroes"); 

        System.out.println("Quels famille ? Tapper 1 pour avengers et 2 pour x-men"); 

        // int choix = clavier.nextInt();clavier.nextLine();
        // if (choix == 1) {
        //     String Famille_sql = "SELECT nom,famille FROM PERSONNES WHERE famille = 'avengers'";
        //     mb_Fam = db.Requette(db,Famille_sql);//avengers ou x-men
        // }
        // else if (choix == 2){
        //     String Famille_sql = "SELECT nom,famille FROM PERSONNES WHERE famille = 'x-men'";
        //     mb_Fam = db.Requette(db,Famille_sql);//avengers ou x-men
        // }
        // else {
        //     mb_Fam = new ArrayList<String>(1); 
        //     mb_Fam.add("Cette famille n'existe pas");
        //     }
        // Affiche_Arrayliste(mb_Fam);

        //Question 2 : 
        System.out.println("2)Afficher toutes les infos concernant les ennemis ou les amis d'une personne données");
        // String q2 = "SELECT nom FROM PERSONNES WHERE idPers=(SELECT idPers2 FROM ENNEMIS WHERE idPers1=(SELECT idPers FROM PERSONNES WHERE nom = 'the joker'))";
        // Amis_de_qq1 = db.Requette(db, q2) ; 
        // Affiche_Arrayliste(db.Requette(db, q2));


        //Question 3 :
        System.out.println("3)Afficher la liste des ennemis des ennemis d'une personne donnée (ex : The Joker)");
        // String q3 = "SELECT nom FROM PERSONNES WHERE idPers=(SELECT idPers2 FROM ENNEMIS WHERE idPers1=(SELECT idPers2 FROM ENNEMIS WHERE idPers1=(SELECT idPers FROM PERSONNES WHERE nom = 'robin')))";
        // Affiche_Arrayliste(db.Requette(db, q3));

        //Question 4 : 
        System.out.println("4)Quel est le pouvoir le plus répandu chez les super héros ?");
        // String q4 = "SELECT ";
        // Affiche_Arrayliste(db.Requette(db, q4));
        

        //Question 5 : 
        System.out.println("5)Quelle est la liste des superhéros possédant un pouvoir donné ?");

        //Question 6 : 
        // System.out.println("6)Quels sont les ennemis qui ont au moins un ami commun (ex  Daredevil & Kingpi sont ennemis et tous deux sont amis avec Elektra)");
        
        //Question 7 : 
        // System.out.println("7)Ajouter un enregistrement");
        
        // //Question 8 : 
        // System.out.println("8)Possibilié de modifier un enregistrement : modification de valeur d'un champ (sauf clé primaire)");


        clavier.close();
        // ResultSet rs = db.Interogate("SELECT * FROM ENNEMIS");
    }

    


    public static void Affiche_Arrayliste(ArrayList<String> L){
        for (String elem : L){System.out.println(elem);}
    }
}
