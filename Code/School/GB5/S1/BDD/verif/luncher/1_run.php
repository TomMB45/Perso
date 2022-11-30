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
        $file = fopen("../data_file/q1/".$i."_info.txt","r");

        if ($file){
            $pays = fgets($file);
            $vegetal = fgets($file);
            $oracle = fgets($file);
        }

        fclose($file);

        $file = fopen("../data_file/q1/".$i.".txt","r");

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

    $query = "SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE ( 
        nom_pays = " . "'" . $pays . "'" . " AND
            (
                nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = " . "'" . $vegetal . "'" . " AND caractere_envahissant = 1)
                OR 
                nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = " . "'" . $vegetal . "'" . " AND caractere_envahissant = 1)
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