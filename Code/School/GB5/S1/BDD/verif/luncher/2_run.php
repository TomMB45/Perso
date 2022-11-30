<?php
    $con = mysqli_connect("localhost","root","","bdd_fraisse");
    // Check connection
    if (mysqli_connect_errno()){
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }

    for ($i=1; $i <= 20; $i++) {
        $rm = "DELETE FROM peut_transporter;";
        $result = mysqli_query($con,$rm);

        $rm = "DELETE FROM achemine;";
        $result = mysqli_query($con,$rm);

        $rm = "DELETE FROM sensible_volontairement;";
        $result = mysqli_query($con,$rm);

        $rm = "DELETE FROM sensible_involontairement;";
        $result = mysqli_query($con,$rm);

        $rm = "DELETE FROM Trajet;";
        $result = mysqli_query($con,$rm);

        $rm = "DELETE FROM Parasite;";
        $result = mysqli_query($con,$rm);

        $rm = "DELETE FROM Vegetal;";
        $result = mysqli_query($con,$rm);

        $rm = "DELETE FROM Pays;";
        $result = mysqli_query($con,$rm);

        $file = fopen("../data_file/q2/".$i."_info.txt","r");

        if ($file){
            $pays1 = fgets($file);
            $pays2 = fgets($file);
            $vegetal = fgets($file);
            $oracle = fgets($file);
        }
        fclose($file); 

        $file = fopen("../data_file/q2/".$i.".txt","r");
        if ($file){
            while (($line = fgets($file)) !== false){
                $line = str_replace("\r","",$line);
                $line = str_replace("\n","",$line);
                if ($line != ""){
                    $sql = $line; 
                    mysqli_query($con,$sql);
                }
            }
        }
        fclose($file);

    $oracle = $oracle ? "FALSE" : "TRUE"; 
    $query = "SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
        nombre_etapes = 1 AND 
        (
            (nom_pays_depart = " . "'" . $pays1 . "'" . " AND nom_pays_arrivee = " . "'" . $pays2 . "'" . " AND (
                nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = " . "'" . $pays2 . "'" . " AND nom_vegetal = " . "'" . $vegetal . "'" . " AND caractere_envahissant = 1) 
                OR 
                nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = " . "'" . $pays2 . "'" . " AND nom_parasite = " . "'" . $vegetal . "'" . " AND caractere_envahissant = 1) 
                )
            ) OR (
                nom_pays_depart = " . "'" . $pays2 . "'" . " AND nom_pays_arrivee = " . "'" . $pays1 . "'" . " AND (
                nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = " . "'" . $pays1 . "'" . " AND nom_vegetal = " . "'" . $vegetal . "'" . " AND caractere_envahissant = 1) 
                OR 
                nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = " . "'" . $pays1 . "'" . " AND nom_parasite = " . "'" . $vegetal . "'" . " AND caractere_envahissant = 1) 
                )
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal 
                LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE (
                    (Vegetal.nom_vegetal = " . "'" . $vegetal . "'" . " AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                    OR 
                    (
                        Parasite.nom_parasite = " . "'" . $vegetal . "'" . " AND 
                        (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction)
                    )
                )
            ) 
        )
    );"; 

    $result = mysqli_query($con,$query);
    $row = mysqli_fetch_array($result);
    if ($row['result'] == $oracle) {
        echo "test passed <br>";
        } else {
        echo "test failed <br>";
        };
}

?>