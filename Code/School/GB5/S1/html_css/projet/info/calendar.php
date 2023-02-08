<?php
include("../connect/auth_session.php");
include("../connect/db.php");
// On permet l'accès à la page uniquement aux utilisateurs ayant le rôle "SEC", "CV", "CNV" et "SU"
allowed(array('SEC', 'CV', 'CNV'), $_SESSION["role"]);
?>

<?php
// tableau de traduction des jours de la semaine
$translate = array(
    "Monday" => 'Lundi',
    "Tuesday" => 'Mardi',
    "Wednesday" => 'Mercredi',
    "Thursday" => 'Jeudi',
    "Friday" => 'Vendredi',
    "Saturday" => 'Samedi',
    "Sunday" => 'Dimanche',
);

// tableau du nombre de jours a afficher pour le mois précédent en fonction du premier jour du mois
$past = array(
    "Lundi" => 0, 
    "Mardi" => 1,
    "Mercredi" => 2,
    "Jeudi" => 3,
    "Vendredi" => 4,
    "Samedi" => 5,
    "Dimanche" => 6,
); 

// tableau de conversion des mois en chiffres en mois en lettres
$month = array(
    '01' => 'Janvier',
    '02' => 'F&eacute;vrier',
    '03' => 'Mars',
    '04' => 'Avril',
    '05' => 'Mai',
    '06' => 'Juin',
    '07' => 'Juillet',
    '08' => 'Août',
    '09' => 'Septembre',
    '10' => 'Octobre',
    '11' => 'Novembre',
    '12' => 'D&eacute;cembre',
);


function create_array($first_day){
    /**
     * Créer un tableau des numéro des jours du mois précédent
     * @param $first_day : le premier jour du mois
     * @return array : le tableau des jours du mois précédent
     * @global $past : le tableau du nombre de jours a afficher pour le mois précédent en fonction du premier jour du mois
     */
    global $past;
    $res = array();
    $last_day_precedent_day = date('d',strtotime("last day of +" . strval( $_GET['p']+$_GET['n']) -1 . " month")); 
    for($i = 0; $i < $past[$first_day]; $i++){
        $res[$i] = $last_day_precedent_day;
        $last_day_precedent_day--;
    }
    return array_reverse($res);
}

// Vérification des paramètres GET
if (!isset( $_GET['p'])){
    // Si les paramètres GET ne sont pas définis, on les initialisent
    $_GET['p'] = 0;  
    $_GET['n'] = 0;
    $_GET['s'] = "Radiologie";
}

// Check CNV
if ($_SESSION["role"]=="CNV"){
    // On vérifie que le CNV n'a pas déjà un rendez-vous
    $sql = "SELECT * FROM Appointment WHERE id_user = '".$_SESSION['email']."';";
    $result = mysqli_query($con, $sql) or die(mysqli_error($con));
    if (mysqli_num_rows($result) > 0){
        header("Location: confirm.php?confirm=CNV_max_rdv");
        exit();
    }
}

// Check secr&eacute;taire
(isset($_SESSION['user_selected'])) ? $user = '&u=' . $_SESSION['user_selected'] : $user = ''; 
if (isset($_SESSION['user_selected'])){
    // On vérifie que la secrétaire à bien sélectionné un utilisateur
    echo "<div class='user_selected'>Utilisateur s&eacute;lectionn&eacute; : " . $_SESSION['user_selected'] . "</div>";
} elseif ($_SESSION["role"]=="SEC") {
    // Si la secrétaire n'a pas sélectionné d'utilisateur, on la redirige vers la page de sélection
    header("Location: confirm.php?confirm=SEC_no_user_selected");
    exit();
}

// On crée la chaine de caractère pour récupérer le premier jour du mois dans lequel on se trouve
$temp = "first day of +" . strval( $_GET['p']+$_GET['n']) . " month";

// On récupère le nom du premier jour du mois dans lequel on se trouve
$first_day = $translate[date('l',strtotime($temp, time()))];

?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Calendrier</title>
    <link rel="stylesheet" href="calendar.css">
    <link rel="stylesheet" href="../common_css/button.css">
</head>
<body>
    <div class = wrap>  
        <h2>Prendre rendez-vous <?php if(($_SESSION["role"]=="SEC") && $_SESSION["user_selected"]){echo "pour ".$_SESSION["user_selected"];} ?></h2>
        <div>
            <?php
            // On récupère les services et les durées de rendez-vous
            $query = "SELECT name_service, slot_duration FROM `Services`";
            $result = mysqli_query($con, $query) or die(mysqli_error($con));
            $row = mysqli_fetch_all($result, MYSQLI_ASSOC);
            foreach ($row as $key => $value) {
                // On affiche les boutons des services
                $classe = $value['name_service'] != $_GET['s'] ? "services not_selected" : "services";
                if ($value['name_service'] == $_GET['s']){
                    $duration = $value['slot_duration'];
                }
                echo "<button onclick='location.href=\"calendar.php?s=". $value["name_service"] .'&p=' . $_GET['p']. '&n=' .$_GET['n']. "\"' type=\"button\" class='$classe'> ". $value["name_service"] ."</button>";
            }
            ?>
        </div> 

        <div>
            <?php 
            // On récupère dans une variable le mois dans lequel on se trouve
            $month_current = date('m',strtotime($temp,time())); 
            global $month;
            // On affiche le mois et l'année dans lequel on se trouve 
            echo "
            <h3 class='month'>". $month[$month_current] . " " . date('Y',strtotime($temp,time())) . "</h3>
            ";
            ?>
        </div>

        <div class = calendar>
            <table>
                <thead>
                    <th>Lundi</th>
                    <th>Mardi</th>
                    <th>Mercredi</th>
                    <th>Jeudi</th>
                    <th>Vendredi</th>
                    <th>Samedi</th>
                    <th>Dimanche</th>
                </thead>
                <?php
                // On récupère le service sélectionné
                $service = $_GET['s'];
                $year = date('Y',strtotime($temp,time()));
                
                // On effectue une requête pour récupérer les dates où le service est complet
                $query_dispo = "SELECT DATE(start_time) AS date_prise FROM Services NATURAL JOIN Appointment WHERE name_service = '$service'
                                GROUP BY DATE(start_time) HAVING COUNT(name_service) = (SELECT 8 * nb_simultaneous_slots * 60 DIV slot_duration 
                                FROM Services WHERE name_service = '$service')";
                
                $result = mysqli_query($con, $query_dispo) or die(mysqli_error($con));
                $row = mysqli_fetch_all($result, MYSQLI_ASSOC);
                $date_prise = array();
                foreach ($row as $row) {
                    // On stocke les dates où le service est complet dans un tableau 
                    array_push($date_prise, $row['date_prise']);
                }

                $array = create_array($first_day);
                // On affiche les jours du mois précédent
                echo "<tr>";
                foreach($array as $value){ 
                    // affichage des jours du mois pr&eacute;c&eacute;dent
                    echo "<td class='non_possible'>" . $value . "</td>"; 
                }

                // On récupère le l'heure maximale à laquelle on peut prendre le dernier rendez-vous
                $hour_max = date("H:i",strtotime("17:30:00 - ". $duration ." minutes"));
                $hour_now = date("H:i");
                $today = date('Y-m-d');
                $i = 1;
                for ($i = 1; $i <= 7-sizeof($array); $i++){ 
                    // affichage des jours du mois courant de la première semaine
                    $date_i = date("Y-m",strtotime(strval($_GET['p']+$_GET['n']) . "month"))."-0$i";
                    if ($date_i < date('Y-m-d') or $i == 7-sizeof($array)){
                        // Si la date est passée ou si on est sur les jour du mois précédent, on affiche le jour en gris
                        echo "<td class='non_possible'>" . $i . "</td>";
                    }else{
                        // Sinon, on affiche le jour en violet
                        echo "<td class='possible' onclick=\"location.href='hours.php?s=". $_GET["s"] ."&d=" . $i . "&m=". $month_current . "&y=". date('Y',strtotime($temp,time())) . "';\">" . $i . "</td>";
                    }
                }

                echo "</tr>";
                
                while ($i <= date('d',strtotime("last day of +" . strval( $_GET['p']+$_GET['n']) . " month"))){
                    // affichage des jours du mois courant des semaines suivantes
                    echo "<tr>";
                    for ($j = 0; $j < 7; $j++){
                        // On affiche les 7 jours de la semaine
                        if ($i <= date('d',strtotime("last day of +" . strval( $_GET['p']+$_GET['n']) . " month"))){
                            $exact_date = $year."-".$month_current."-".$i;
                            if (($i < date('d', time()) and $month_current == date('m') ) or in_array($exact_date,$date_prise) or date('l',strtotime($exact_date)) == 'Sunday' or ($exact_date == $today and  $hour_now > $hour_max)) { 
                                // Condition jour pas disponible & WEEKENDS
                                echo "<td class='non_possible'>" . $i . "</td>";
                                $i++;
                            }else{
                                // Condition jour disponible
                                echo "<td class='possible' onclick=\"location.href='hours.php?s=". $_GET['s'] . "&d=" . $i ."&m=". $month_current . "&y=". date('Y',strtotime($temp,time())) . "';\">" . $i . "</td>";   
                                $i++;
                            }
                        }
                    }
                    echo "</tr>";
                }
                ?>
            </table>
            
            <!-- arrows -->
            <?php
            // On affiche les flèches pour naviguer entre les mois
            if ($_GET['p']+$_GET['n'] < 11){
                // On affiche la flèche de droite si on est pas à plus 11 mois du mois actuel
                echo '<a href="calendar.php?s=' . $_GET['s'] . "&p=" . ($_GET['p']+=1) . "&n=" . ($_GET['n']).' " class="arrow"></a>';
            }
            if ($_GET['p']+$_GET['n'] > 1){
                // On affiche la flèche de gauche que si on est pas à moins de 1 mois du mois actuel
                echo '<a href="calendar.php?s=' . $_GET['s'] . "&p=" . ($_GET['p']-=1) . "&n=" . (--$_GET['n']).' " class="arrow-left"></a>';
            }
            ?>
            <br>
            <button onclick='location.href="info.php"' type="button" class="go_back">Retour</button>
        </div>
    </div>
</body>
</html>
