<!DOCTYPE html>
<?php
include("../connect/auth_session.php");
include("../usefull_function/mailing.php");
// On vérifie que l'utilisateur est bien un secrétaire, un client non vérifié ou un client vérifié
allowed(array('SEC', 'CV', 'CNV'), $_SESSION["role"]);
?>
<html>
<head>
    <meta charset="utf-8">
    <title>Confirmation du rendez-vous</title>
    <link rel="stylesheet" href="style.css">
</head>
<body> 
    <?php
    include("../connect/db.php");
    // On récupère les informations du rendez-vous
    $service = $_GET['s'];
    $day = $_GET['d'];
    $month = $_GET['m'];
    $hour = $_GET['h'];
    $year = $_GET['y'];
    $appointement = "$year-$month-$day"." "."$hour:00"; 
    
    // echo $appointement;

    if ($_SESSION["role"]=="CNV"){
        // Si le client n'est pas vérifié, on vérifie qu'il n'a pas déjà un rendez-vous
        $sql = "SELECT * FROM Appointment WHERE id_user = '".$_SESSION['email']."';";
        $result = mysqli_query($con, $sql) or die(mysqli_error($con));
        if (mysqli_num_rows($result) > 0){
            // Si le client a déjà un rendez-vous, on le redirige vers la page d'erreur correspondante
            header("Location: confirm.php?confirm=CNV_max_rdv");
            exit();
        }
    }



    if (isset($_SESSION['user_selected'])){
        // Si l'utilisateur est un secrétaire, on récupère l'email du client      
        $id_user= $_SESSION['user_selected'];
        $query = "INSERT INTO `Appointment` (`id_appointment`, `name_service`, `id_user`, `start_time`) VALUES (NULL, '$service', '$id_user', '$appointement');";
    } else {
        // Sinon on récupère l'email de l'utilisateur connecté
        $id_user = $_SESSION['email'];
        $query = "INSERT INTO `Appointment` (`id_appointment`, `name_service`, `id_user`, `start_time`) VALUES (NULL, '$service', '$id_user', '$appointement');";
    }

    try {
        // On test si la query d'insertion du rendez-vous a réussi
        $result = mysqli_query($con, $query) or die(mysqli_error($con));
        $datetime = explode(" ", $appointement);
        $date = $datetime[0];
        $time = $datetime[1];
        // On envoie un mail de confirmation de rendez-vous
        confirmRDV($id_user, $date, $time, $service);
        // On redirige l'utilisateur vers la page de confirmation
        header("Location: ../info/confirm.php?&confirm=rdvTrue");
        exit();
    } catch (Exception $e) {
        // Si la query d'insertion du rendez-vous a échoué, on redirige l'utilisateur vers la page d'erreur correspondante
        header("Location: ../info/confirm.php?&confirm=rdvFalse");
        exit();
    }

    ?>
</body>
</html>