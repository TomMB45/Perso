<?php
$bdd = new PDO('mysql:host=localhost;dbname=bdd_fraisse;charset=utf8','root',"");

for ($i=1; $i <= 42; $i++) {
    $rm = "DELETE FROM peut_transporter;";
    $result = $bdd->query($rm);

    $rm = "DELETE FROM achemine;";
    $result = $bdd->query($rm);

    $rm = "DELETE FROM sensible_volontairement;";
    $result = $bdd->query($rm);

    $rm = "DELETE FROM sensible_involontairement;";
    $result = $bdd->query($rm);

    $rm = "DELETE FROM Trajet;";
    $result = $bdd->query($rm);

    $rm = "DELETE FROM Parasite;";
    $result = $bdd->query($rm);

    $rm = "DELETE FROM Vegetal;";
    $result = $bdd->query($rm);

    $rm = "DELETE FROM Pays;";
    $result = $bdd->query($rm);

    $file = fopen("../data_file/q3/".$i."_info.txt","r");
    $oracle = array();
    if ($file){
        $vegetal = fgets($file);
        while (($line = fgets($file)) !== false){
            $line = str_replace("\r","",$line);
            $line = str_replace("\n","",$line);
            if ($line != ""){
                array_push($oracle,$line);
            }
        }
    }
    fclose($file);

    $file = fopen("../data_file/q3/".$i.".txt","r");
    if ($file){
        while (($line = fgets($file)) !== false){
            $line = str_replace("\r","",$line);
            $line = str_replace("\n","",$line);
            if ($line != ""){
                $sql = $line; 
                $result = $bdd->query($sql);
            }
        }
    }
    fclose($file);

    $vegetal = str_replace(" ","",$vegetal);
    $vegetal = str_replace("\r","",$vegetal);
    $vegetal = str_replace("\n","",$vegetal);

    $q = "SELECT DISTINCT nom_pays_arrivee AS `res` FROM Trajet WHERE(
        nombre_etapes = 1 AND 
        nom_pays_arrivee IN (
                (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = \"".$vegetal."\" AND caractere_envahissant = 1 AND historique = 0) 
                UNION 
                (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = \"".$vegetal."\" AND caractere_envahissant = 1 AND historique = 0)
                )
        AND 
        id_trajet IN (
            SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal 
            LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE 
            (
                (vegetal.nom_vegetal = \"".$vegetal."\" AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                OR 
                (Parasite.nom_parasite = \"".$vegetal."\" AND 
                (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
            )
        ) 
    );";

    $rep = $bdd->query($q); 
    $sortie = array();
    while ($data = $rep->fetch()){
        $data = $data['res'];  
        array_push($sortie, $data); 
    }

    if(count(array_intersect($sortie,$oracle)) == count($oracle) && count(array_intersect($sortie,$oracle)) == count($sortie)){
        echo "test valide <br>"; 
    } else {
        echo "test invalide <br>"; 
        print_r($sortie);
        echo "<br>";
        print_r($oracle);
        echo "<br>";

        echo $q; 
        echo "<br>";
    }
} 
?>