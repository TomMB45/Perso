<!DOCTYPE html>
<?php
include("../connect/auth_session.php");
allowed(array("CV","CNV","SEC"), $_SESSION["role"]);

?>
<html>
    <head>
        <link rel="stylesheet" href="hours.css">
        <link rel="stylesheet" href="../common_css/button.css">
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Choix de l'heure</title>
    </head>

    <body>
        <div class=wrap>
            <div>
                <h2>Choississez une heure pour votre rendez-vous</h2>
                <?php
                if (isset($_SESSION['user_selected'])){
                    // Si l'utilisateur est une secrétaire, on affiche le nom de l'utilisateur sélectionné
                    echo "<div class='user_selected'>Utilisateur s&eacute;lectionn&eacute; : " . $_SESSION['user_selected'] . "</div><br>";
                }
                ?>
                
            </div>

            <div>
                <?php
                include("../connect/db.php");
                // On récupère les informations de la date sélectionnée
                $service = $_GET['s'];
                $day = $_GET['d'];
                $month = $_GET['m'];
                $year = $_GET['y'];
                $date = $year."-".$month."-".$day;
        
                // On récupère les heures déjà prises pour ce service et cette date et à cette heure 
                $query_dispo = "SELECT DATE_FORMAT(start_time, '%T') AS date_prise FROM Services NATURAL JOIN Appointment 
                WHERE name_service = '$service' AND DATE(start_time) =  '$date' GROUP BY DATE_Format(start_time, '%T') 
                HAVING COUNT(name_service) >= (SELECT nb_simultaneous_slots FROM Services WHERE name_service = '$service')";
                
                $result = mysqli_query($con, $query_dispo) or die(mysqli_error($con));
                $row = mysqli_fetch_all($result, MYSQLI_ASSOC);
                $date_prise = array();
                foreach ($row as $row) {
                    // Ajoute les heures déjà prises en supprimant les secondes dans le tableau 
                    array_push($date_prise, substr($row['date_prise'],0,-3));
                }

                // On récupère la durée des créneaux pour ce service
                $query_duration = "SELECT slot_duration FROM Services WHERE name_service = '$service';";
                $result = mysqli_query($con, $query_duration) or die(mysqli_error($con));
                $row_duration = mysqli_fetch_all($result, MYSQLI_ASSOC);
                $duration = intval($row_duration[0]['slot_duration']);

                $hour_now = date("H:i", time());
                $h = date("H:i",strtotime("08:00:00 + ".$duration." minutes"));
                $today = date("Y-m-d");
                echo "<h3>Matin</h3>"; 
                $i = 0; 
                
                while ($h < date("H:i",strtotime("12:30:00 - ".$duration." minutes"))){
                    // On affiche les heures disponibles pour le matin 
                    $h = date("H:i",strtotime("08:00:00 + " . $duration*$i . " minutes"));
                    if (!in_array($h, $date_prise) and (date("Y-m-d H:i",strtotime($date . $h)) > date("Y-m-d H:i",strtotime($today . $hour_now)))){
                        // On affiche les heures disponibles pour le matin
                        echo "<button onclick='location.href=\"confirm_rdv.php?s=". $_GET["s"] ."&d=" . $_GET["d"] . "&m=". $month . "&y=" . $year . "&h=" . $h . "\"' type=\"button\" class=\"rdv\">$h</button>"; 
                    }
                    $i++;
                }

                echo "<br>"; 


                echo "<h3>Apr&egraves-midi</h3>"; 
                $h = date("H:i",strtotime("14:00:00 + ".$duration." minutes"));
                $i = 0; 
                while ($h <= date("H:i",strtotime("17:30:00 - ". (2*$duration) ." minutes"))){
                    // On affiche les heures disponibles pour l'après-midi
                    $h = date("H:i",strtotime("14:00:00 + " . $duration*$i . " minutes"));
                    if (!in_array($h, $date_prise) and (date("Y-m-d H:i",strtotime($date . $h)) > date("Y-m-d H:i",strtotime($today . $hour_now)))){
                        // On affiche les heures disponibles pour l'après-midi
                        echo "<button onclick='location.href=\"confirm_rdv.php?s=". $_GET["s"] ."&d=" . $_GET["d"] . "&m=". $month . "&y=" . $year . "&h=" . $h ."\"' type=\"button\" class=\"rdv\">$h</button>"; 
                    }
                    $i++;
                }            

            echo "</div>"; 
            echo "<button onclick='location.href=\"calendar.php?s=". $_GET["s"] ."\"' type=\"button\" class=\"go_back\">Retour</button>"
            ?>
        </div>        
    </body> 
</html>