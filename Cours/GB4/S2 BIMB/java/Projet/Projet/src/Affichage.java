import javax.swing.*;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import java.util.ArrayList;

import java.sql.*;

public class Affichage extends JFrame implements ActionListener {
    
    private JButton bouton1; 
    private JButton bouton2;
    private JButton bouton3;
    private JButton bouton4;
    private JButton bouton5;
    private JButton bouton6;
    private JButton bouton7; 

    public Affichage() {
        super();
        build(); 
    }

    private void build(){
        setTitle("Projet"); 
        setSize(1000, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setContentPane(Construction_fernetre());
        
    }

    private JPanel Construction_fernetre(){
        JPanel panel = new JPanel(); 
        bouton1 = new JButton("Quels sont les membres d'une famille donnée") ;
        bouton2 = new JButton("Afficher toutes les infos concernant les ennemis ou les amis d'une personne données") ;
        bouton3 = new JButton("Afficher la liste des ennemis des ennemis d'une personne donnée") ;
        bouton4 = new JButton("Le pouvoir le plus répendu est") ; 
        bouton5 = new JButton("Liste des superhéros possédant un pouvoir donné ") ;
        bouton6 = new JButton("Quels sont les ennemis qui ont au moins un ami commun") ; 
        bouton7 = new JButton("Modifier la base de donnée") ; 

        panel.add(bouton1) ; 
        panel.add(bouton2) ;
        panel.add(bouton3) ; 
        panel.add(bouton4) ; 
        panel.add(bouton5) ;
        panel.add(bouton6) ; 
        panel.add(bouton7) ;

        bouton1.addActionListener(this) ;
        bouton2.addActionListener(this) ;
        bouton3.addActionListener(this) ;
        bouton4.addActionListener(this) ; 
        bouton5.addActionListener(this) ;
        bouton6.addActionListener(this) ;
        bouton7.addActionListener(this) ;

        return panel ;
    }

    public void actionPerformed(ActionEvent e) {
        Object source = e.getSource(); 
        try {
            if (source.equals(bouton1)){choix1();}
            else if (source == bouton2){choix2();}
            else if (source == bouton3){choix3();}
            else if (source == bouton4){choix4();}
            else if (source == bouton5){choix5();}
            else if (source == bouton6){choix6();}
            else if (source == bouton7){choix7();}
        }catch (Exception except){};
        
    }

    public static void choix1() throws Exception {
        ArrayList<String> fam = getFamille(); 
        String[] f = ArraylistToString(fam); 
        // Affichage menu déroulant 
        String getFam = (String) JOptionPane.showInputDialog(null, "Quel famille voulez vous ?","Votre choix de famille",JOptionPane.QUESTION_MESSAGE,null,f,f[1]); 

        ArrayList<String> Name= new ArrayList<String>(); 
        BDD db = new BDD("superheroes"); 
        ResultSet rs = db.Requette(db, "SELECT nom FROM PERSONNES WHERE famille = '"+getFam+"'");
        while (rs.next()) {Name.add(rs.getString(1));}
        String[] res = ArraylistToString(Name); 

        // Affichage des résultats
        JOptionPane.showMessageDialog(null, res, "Résultat", JOptionPane.PLAIN_MESSAGE);
    }

    public static void choix2() throws Exception {
        ArrayList<String> Name = getAllName(); 
        String[] N = ArraylistToString(Name); 
        // Affichage menu déroulant 
        String getName = (String) JOptionPane.showInputDialog(null, "De quel personnages voulez vous des informations ?","Votre choix de personnage",JOptionPane.QUESTION_MESSAGE,null,N,N[1]); 

        // On demande le choix de si l'utilisateur veut les amis ou les ennemis
        String [] amis_ennemis = {"AMITIES","ENNEMIS"}; 
        String getChoice = (String) JOptionPane.showInputDialog(null, "Voulez vous des informations les ennemis ou les amis de "+getName+" ?","Votre choix de personnage",JOptionPane.QUESTION_MESSAGE,null,amis_ennemis,amis_ennemis[1]); 

        Object[] infos = {"Nom","Pseudo","Genre","Famille"};
        Object [][] data = Infos(getName,getChoice);
        Affichage_Tableau(data,infos) ;
    }

    public static void choix3() throws Exception{
        ArrayList<String> Name = getAllName(); 
        String[] N = ArraylistToString(Name); 
        // Affichage menu déroulant 
        String getName = (String) JOptionPane.showInputDialog(null, "De quel personnages voulez vous des informations ?","Votre choix de personnage",JOptionPane.QUESTION_MESSAGE,null,N,N[1]); 
        
        String[] ennemis = ArraylistToString(Ennemis_d_ennemis(getName));
        JOptionPane.showMessageDialog(null, ennemis, "Les ennemis des ennemis de "+getName, JOptionPane.PLAIN_MESSAGE);
    }

    public static void choix4() throws Exception{
        String[] res = new String[1]; 
        ArrayList<String> name_pvr = new ArrayList<String>();

        BDD db = new BDD("superheroes"); 
        ResultSet rs = db.Requette(db, "SELECT IdPwr AS nb FROM PERSPWR GROUP BY IdPwr HAVING COUNT(*) ORDER BY COUNT(*) DESC LIMIT 1 ;");
        int IdPvr = rs.getInt(1); 
        System.out.println(IdPvr);

        ResultSet rs2 = db.Requette(db, "SELECT Pouvoir FROM POUVOIRS WHERE idPwr='"+IdPvr+"';");
        while(rs2.next()){name_pvr.add(rs.getString(1));}
        System.out.println(name_pvr);

        // ResultSet rs = db.Requette(db, "SELECT Pouvoir FROM POUVOIRS WHERE idPwr=(SELECT idPers FROM PERSPWR GROUP BY idPers HAVING COUNT(*) ORDER BY COUNT(*) DESC) ;");
        // name_pvr.add(rs.getString(1));
        // System.out.println(name_pvr);
        res=ArraylistToString(name_pvr);
        

        JOptionPane.showMessageDialog(null, res, "Le superpouvoir le plus répandu est", JOptionPane.PLAIN_MESSAGE);

    }

    public static void choix5() throws Exception {
        ArrayList<String> pvr = getPvr(); 
        String[] f = ArraylistToString(pvr); 
        // Affichage menu déroulant 
        String getPvr = (String) JOptionPane.showInputDialog(null, "Quel pouvoir choisissez vous ?","Votre choix de pouvoir",JOptionPane.QUESTION_MESSAGE,null,f,f[1]); 

        // Recherche des noms des personnes ayant le pouvoir choisis
        ArrayList<String> Names= new ArrayList<String>(); 
        BDD db = new BDD("superheroes"); 
        ResultSet rs = db.Requette(db, "SELECT nom FROM PERSONNES WHERE idPers IN (SELECT IdPers FROM PERSPWR WHERE IdPwr = (SELECT idPwr FROM POUVOIRS WHERE Pouvoir = '"+getPvr+"'))");
        // ResultSet rs = db.Requette(db, "SELECT nom WHERE PERSONNES WHERE idPers = (SELECT IdPers FROM PERSPWR WHERE IdPwr = (SELECT idPwr FROM POUVOIRS WHERE Pouvoir = '"+getPvr+"'))");
        while (rs.next()){Names.add(rs.getString(1));}
        System.out.println(Names);
        String[] res = ArraylistToString(Names); 
        
        // Affichage des résultats
        JOptionPane.showMessageDialog(null, res, "Résultat", JOptionPane.PLAIN_MESSAGE);
    }

    public static void choix6() throws Exception{
        
    }

    public static void choix7() throws Exception {
    String requette = new String(); 

    String[] modif = {"Modifier un enregistrement", "Supprimer un enregistrement", "Ajouter un enregistrement"}; 
    // Affichage menu déroulant 
    String getChoix = (String) JOptionPane.showInputDialog(null, "Qu'est ce que vous voulez faire ?","Votre choix : ",JOptionPane.QUESTION_MESSAGE,null,modif,modif[0]); 
    BDD db = new BDD("superheroes"); 
    if (getChoix.equals(modif[0])){
        requette="";
        String[] table = {"PERSONNES", "POUVOIRS", "PERSPWR","AMITIES","ENNEMIS"}; 
        String getTable = (String) JOptionPane.showInputDialog(null, "Quelle table voulez vous modifier ?","Votre choix de table : ",JOptionPane.QUESTION_MESSAGE,null,table,table[0]); 
        ResultSet rs = db.Requette(db, "SELECT * FROM "+getTable+";"); 
        ResultSetMetaData rsMeta = rs.getMetaData();
        String[] col = new String[rsMeta.getColumnCount()]; 
        for (int i = 0; i < rsMeta.getColumnCount(); i++) { col[i]=rsMeta.getColumnName(i); } 

        String getCol = (String) JOptionPane.showInputDialog(null, "Quelle colonne de la table "+getTable+"voulez vous modifier ?","Votre choix de colonne : ",JOptionPane.QUESTION_MESSAGE,null,col,col[0]); 

        

    }
    else if (getChoix.equals(modif[1])){//Supprimer un eregistrement 
        //Quel noms doit être supprimer 

        ArrayList<String> Name = getAllName(); 
        String[] N = ArraylistToString(Name); 

        // Affichage menu déroulant 
        String getName = (String) JOptionPane.showInputDialog(null, "Quel personnage voulez-vous supprimer ?","Votre choix de personnage",JOptionPane.QUESTION_MESSAGE,null,N,N[0]); 

        // Id du personnage à supprimer 
        String Id = new String();
        ResultSet rs = db.Requette(db, "SELECT idPers FROM PERSONNES WHERE nom ='"+getName+"'"); 
        while (rs.next()){Id=rs.getString(1);}
        
        // Requette sql pour supprimer l'enregistrement dnas les différentes tables impliquées
        requette =  "DELETE FROM PERSONNAGE WHERE idPers='"+Id+"';";
        requette = requette+ "DELETE FROM PERSPWR WHERE IdPers='"+Id+"';"; 
        requette = requette+ "DELETE FROM AMITIES WHERE IdPers1='"+Id+"';"; 
        requette = requette+ "DELETE FROM ENNEMIS WHERE IdPers1='"+Id+"';";
    }

    else {//Ajouter un enregistrement 
        String[] para = new String[6]; 
        String tmp = new String(); 
        int last_id ; 
        ResultSet rs =  db.Requette(db, "SELECT idPers FROM PERSONNES"); 
        last_id = rs.getInt(1); 
        last_id++; 

        JTextField nom = new JTextField(20);
        JTextField pseudo = new JTextField(20); 
        JTextField genre = new JTextField(20); 
        JTextField famille = new JTextField(20); 
        JTextField pouvoir = new JTextField(20); 
        JTextField amis = new JTextField(20); 
        JTextField ennemis = new JTextField(20); 
        

        final JComponent[] inputs = new JComponent[] {
            new JLabel("Nom:"),nom,
            new JLabel("Pseudo:"),pseudo,
            new JLabel("Genre:"),genre,
            new JLabel("Famille:"),famille,
            new JLabel("Pouvoirs:"),pouvoir,
            new JLabel("Amis:"),amis,
            new JLabel("Ennemis:"),ennemis,
        };
        int result = JOptionPane.showConfirmDialog(null, inputs, "Entr�es", JOptionPane.PLAIN_MESSAGE);
        para[0]=nom.getText(); para[1]=pseudo.getText();para[2]=genre.getText();para[3]=famille.getText(); 
        para[4]=pouvoir.getText();
        para[5]=amis.getText();para[6]=ennemis.getText();

        // requette = "INSERT INTO PERSONNES (idPers,nom,pseudo,genre,famille) VALUES ("+last_id+","+para[0]+","+para[1]+","+para[2]+","+para[3]+");";

        // REgarde si le nom existe 
        ResultSet rs_nom = db.Requette(db, "SELECT nom FROM PERSONNES WHERE nom='"+para[0]+"';" ); 
        tmp=rs_nom.getString(1); 
        // Si le personnage n'existe pas deja et que le genre existe on peut l'ajouter  
        if (tmp.isEmpty() && (para[2].equals("male")|para[2].equals("female")|para[2].equals("robot")|para[2].equals("autre"))){
            requette = "INSERT INTO PERSONNES (idPers,nom,pseudo,genre,famille) VALUES ("+last_id+","+para[0]+","+para[1]+","+para[2]+","+para[3]+");";
        }
        // Récupération du dernier indice PersPwr pour l'ajouter 
        int last_id_PersPwr ; 
        ResultSet rs_pers_pwr =  db.Requette(db, "SELECT idPersPwr FROM PERSPWR"); 
        last_id_PersPwr = rs_pers_pwr.getInt(1); 
        last_id_PersPwr++; 

        // Récupération de l'Id du pouvoir 
        ResultSet pwr_exist = db.Requette(db, "SELECT idPwr FROM POUVOIRS WHERE Pouvoir='"+para[4]+"';");
        String Id_pvr=pwr_exist.getString(1); 
        // Si l'Id du pouvoir existe on j'ajoute 
        if (!Id_pvr.isEmpty()){
            requette=requette+"INSERT INTO PERSPWR (idPersPwr,IdPers,IdPwr) VALUES ("+last_id_PersPwr+","+last_id+","+Id_pvr+");";
        }

        // Split amis 
        String [] amis_split = para[5].split("/");
        ArrayList<String> Id_Amis_split = new ArrayList<String>(); 
        
        for (String ami : amis_split) {
            // Check si le personnage amis exite 
            ResultSet rs_nom_amis = db.Requette(db, "SELECT idPers FROM PERSONNES WHERE nom='"+ami+"';" ); 
            tmp=rs_nom_amis.getString(1); 
            if (!tmp.isEmpty()) {Id_Amis_split.add(tmp);}
        }
        // Récupération dernier indice amis
        int last_id_amis ; 
        ResultSet rs_amis =  db.Requette(db, "SELECT idAmities FROM AMITIES"); 
        last_id_amis = rs_amis.getInt(1); 
        last_id_amis++;

        requette = requette + "INSERT INTO AMITIES (idAmities,idPers1,IdPers2) VALUES";
        for(String id: Id_Amis_split){//Pour chaque identifiant des amis on crée la relation new_pers -> amis et amis -> new_pers 
            requette = requette +"("+last_id_amis+","+last_id+","+id+"),("+last_id_amis+","+id+","+last_id+")";
        }

        // Split ennemis 
        String [] ennemis_split = para[6].split("/");
        ArrayList<String> Id_Ennemis_split = new ArrayList<String>(); 
        
        for (String enmis : ennemis_split) {
            // Check si le personnage ennemis exite 
            ResultSet rs_nom_enmis = db.Requette(db, "SELECT idPers FROM PERSONNES WHERE nom='"+enmis+"';" ); 
            tmp=rs_nom_enmis.getString(1); 
            if (!tmp.isEmpty()) {Id_Ennemis_split.add(tmp);}
        }
        // Récupération dernier indice ennemis
        int last_id_enmis ; 
        ResultSet rs_enmis =  db.Requette(db, "SELECT idAmities FROM ENNEMIS"); 
        last_id_enmis = rs_enmis.getInt(1); 
        last_id_enmis++;

        requette = requette + "INSERT INTO ENNEMIS (idEnnemi,idPers1,IdPers2) VALUES";
        for(String id: Id_Ennemis_split){//Pour chaque identifiant des ennemis on crée la relation new_pers -> ennemis et ennemis -> new_pers 
            requette = requette +"("+last_id_enmis+","+last_id+","+id+"),("+last_id_enmis+","+id+","+last_id+")";
        }
    }

    try {// On test si on peut modifier la base de donnée
        int nb_modif = db.Modif_BDD(db, requette);
        if (nb_modif==0){
            JOptionPane.showMessageDialog(new JFrame(), "Invalide : aucune modification effectuée", "Erreur", JOptionPane.ERROR_MESSAGE);
            return;
        }
        JOptionPane.showMessageDialog(new JFrame(), "La base de donnée à bien été mise a jour", "MAJ valide", JOptionPane.ERROR_MESSAGE);
        return;
        }

    catch (java.sql.SQLException e){//Si on ne peut pas modifier la base de donnée c'est que la requette sql est fausse => on l'affiche
        JOptionPane.showMessageDialog(new JFrame(), "Requette sql invalide", "Invalide", JOptionPane.ERROR_MESSAGE);
        return;
    }
    
}

    public static ArrayList<String> getFamille() throws Exception{
        ArrayList<String> fam = new ArrayList<String>(); 
        BDD db = new BDD("superheroes"); 
        ResultSet rs = db.Requette(db, "SELECT DISTINCT famille FROM PERSONNES"); 
        while (rs.next()){fam.add(rs.getString(1));}
        return fam; 
    }

    public static ArrayList<String> getAllName() throws Exception {
        ArrayList<String> Name = new ArrayList<String>(); 
        BDD db = new BDD("superheroes"); 
        ResultSet rs = db.Requette(db, "SELECT DISTINCT nom FROM PERSONNES"); 
        while (rs.next()){Name.add(rs.getString(1));}
        return Name; 
    }

    public static Object[][] Infos(String Nom,String relation) throws Exception {
        // On fait la requette sql 
        BDD db = new BDD("superheroes"); 
        ResultSet rs = db.Requette(db, "SELECT * FROM PERSONNES WHERE idPers IN (SELECT idPers2 FROM "+relation+" WHERE idPers1=(SELECT idPers FROM PERSONNES WHERE nom = '"+Nom+"'))");
        ArrayList<String> nom = new ArrayList<String>(); 
        ArrayList<String> pseudo = new ArrayList<String>(); 
        ArrayList<String> genre = new ArrayList<String>(); 
        ArrayList<String> famille = new ArrayList<String>(); 
        // ArrayList<String> pouvoir = new ArrayList<String>(); 

        // On ajoute les résultat de cette requette dans un arraylist pour pouvoir compter le nombre de personnages
        while (rs.next()){
            nom.add(rs.getString(2));
            pseudo.add(rs.getString(3));
            genre.add(rs.getString(4));
            famille.add(rs.getString(5));
        }
        Object[][] res = new String[nom.size()][4]; 

        for (int i = 0; i < nom.size(); i++) {
            Personne pers = new Personne(nom.get(i), pseudo.get(i), genre.get(i), famille.get(i));
            // ResultSet rs_pvr = db.Interogate("SELECT Pouvoir FROM POUVOIRS INNER JOIN POUVOIRS.idPers ON PERSONNES.idPers WHERE nom ='"+nom.get(i)+"'");
            // String pvr = rs_pvr.getString(1); 
            // System.out.println(pvr); 
            // Heros hero = new Heros(pers.getNom(),pers.getPseudo(),pers.getGenre(),pers.getFamille(),pvr); 
            res[i][0]=pers.getNom(); 
            res[i][1]=pers.getPseudo();
            res[i][2]=pers.getGenre(); 
            res[i][3]=pers.getFamille();
            // res[i][4]=hero.getPouvoir();
        }
        return res; 
    }
    
    public static ArrayList<String> Ennemis_d_ennemis(String nom) throws Exception {
        ArrayList<String> ennemis_d_ennemis = new ArrayList<String>(); 
        BDD db = new BDD("superheroes"); 
        ResultSet rs = db.Requette(db, "SELECT nom FROM PERSONNES WHERE idPers IN (SELECT idPers2 FROM ENNEMIS WHERE idPers1=(SELECT idPers2 FROM ENNEMIS WHERE idPers1=(SELECT idPers FROM PERSONNES WHERE nom = '"+nom+"')))"); 
        while(rs.next()){ennemis_d_ennemis.add(rs.getString(1));}
        return ennemis_d_ennemis; 
    }

    public static ArrayList<String> getPvr() throws Exception{
        ArrayList<String> pvr = new ArrayList<String>(); 
        BDD db = new BDD("superheroes"); 
        ResultSet rs = db.Requette(db, "SELECT DISTINCT Pouvoir FROM POUVOIRS"); 
        while (rs.next()){pvr.add(rs.getString(1));}
        return pvr; 
    }



    public static String[] ArraylistToString(ArrayList<String> List){
        String[] res = new String[List.size()]; 
        int index=0; 
        for (String elem : List) {
            res[index]=elem; 
            index++; 
        }
        return res;
            
        
    }

    public static void Affichage_Tableau(Object[][] infos, Object[] en_tete){
        JFrame f = new JFrame() ; 
        f.setTitle("Resultats") ;
        f.setSize(1200,230) ;
        JTable Tableau = new JTable(infos,en_tete) ; 
        f.getContentPane().add(new JScrollPane(Tableau),BorderLayout.CENTER) ;
        f.setVisible(true) ;
    }

}
