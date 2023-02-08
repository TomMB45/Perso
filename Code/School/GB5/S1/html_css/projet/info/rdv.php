<!DOCTYPE html>
<?php
include("../connect/auth_session.php");
// On vérifie que l'utilisateur a le droit d'accéder à cette page (CV, CNV, SEC)
allowed(array("CV","CNV","SEC"), $_SESSION["role"]);
?>

<html>
    <head>
        <link rel= "stylesheet" href= "../common_css/form.css"></li>
        <title>A propos de vos rendez-vous</title>
    </head>

    <body>
        <?php
        // On récupère dans une variable qu'est ce que l'utilisateur veut faire (modif, info, rm)
        $q = $_GET["q"];
        if (isset($_SESSION['user_selected'])){
            // Si l'utilisateur est une secrétaire, on récupère l'id de l'utilisateur dont elle veut voir les informations
            $id_user= $_SESSION['user_selected'];
        } else {
            // Sinon, on récupère l'id de l'utilisateur connecté
            $id_user = $_SESSION['email'];
        }
        switch ($q) {
            case 'modif':
                // Si l'utilisateur veut modifier un rendez-vous
                if (isset($_GET["id"])){
                    // Si l'utilisateur a cliqué sur le bouton "Modifier" et que l'id est renseigné
                    include("../connect/db.php"); 
                    // On supprime le rendez-vous
                    $sql = "DELETE FROM `Appointment` WHERE `id_appointment` = " . $_GET["id"];
                    $result = mysqli_query($con, $sql);
                    if ($result) {
                        // Si la suppression s'est bien passée, on redirige l'utilisateur vers la page de confirmation
                        header("Location: confirm.php?confirm=rdv_delete");
                        exit();
                    } else {
                        // Sinon, on redirige l'utilisateur vers la page d'erreur
                        header("Location: confirm.php?confirm=rdv_delete_error");
                        exit();
                    }
                }else{
                    // Sinon, on affiche la liste des rendez-vous modifiables
                    include("../connect/db.php");
                    // On récupère les rendez-vous modifiables
                    $sql = "SELECT id_appointment, start_time, name_service FROM Appointment JOIN Users ON Appointment.id_user = Users.email NATURAL JOIN `Services` WHERE email = '".$id_user."' AND start_time > CURRENT_TIMESTAMP";
                    $result = mysqli_query($con, $sql);
                    
                    if ($result){
                        // Si la requête s'est bien passée, on affiche la liste des rendez-vous modifiables
                        $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
                        echo "
                        <div class=wrap>
                            <h2>Liste des rendez-vous modifiables</h2>
                            <ul>";
                            foreach ($rows as $row) {  
                                // Pour chaque rendez-vous, on affiche un lien vers la page de modification
                                echo "
                                <li>Modifier le rendez-vous du <a href='rdv.php?q=modif&id=".$row["id_appointment"]."'>".$row["start_time"]." pour le service ".$row["name_service"]."</a></li>
                                ";
                            }
                            echo "</ul>
                            <button class='button' onclick='location.href=\"info.php\"'>Retour</button>
                        </div>";

                    } else {
                        // Sinon, on affiche un message d'erreur
                        echo "
                        <div class='wrap'>
                            <h2>Vous n'avez pas de rendez-vous à en cours</h2>
                            <div class='link'>
                                <p>Pour prendre un rendez-vous cliquez <a href='calendar.php'>ici</a></p>
                            </div>
                        </div>";
                    }
                }
                break;
            case 'info':
                // Si l'utilisateur veut voir ses rendez-vous
                include("../connect/db.php");
                $state = $_GET["state"];
                if ($state == "curr") {
                    // Si l'utilisateur veut voir ses rendez-vous en cours, on récupère les rendez-vous en cours
                    $sql = "SELECT * FROM Appointment NATURAL JOIN Services WHERE start_time > CURRENT_DATE AND id_user = '".$id_user."';";
                } else {
                    // Sinon, on récupère les rendez-vous passés
                    $sql = "SELECT * FROM Appointment NATURAL JOIN Services WHERE start_time < CURRENT_DATE AND id_user = '".$id_user."';";
                }
                $result = mysqli_query($con, $sql);
                $row = mysqli_fetch_all($result, MYSQLI_ASSOC);
                $state = ($state == "curr") ? "en cours" : "pass&eacute;s";
                if (count($row) == 0){
                    // Si l'utilisateur n'a pas de rendez-vous, on affiche un message d'erreur
                    echo "
                    <div class='wrap'>
                        <h2>Vous n'avez pas de rendez-vous ".$state.".</h2>
                        <div class='link'>
                            <p>Pour prendre un rendez-vous cliquez <a href='calendar.php'>ici</a></p>
                        </div>
                        <button class='button' onclick='location.href=\"info.php\"'>Retour</button>
                    </div>";
                } else {
                    // Sinon, on affiche la liste des rendez-vous
                    echo "
                    <div class='wrap'>
                        <h2>Vos rendez-vous $state :</h2>";
                        foreach ($row as $key => $value) {
                            // Pour chaque rendez-vous, on affiche les informations
                            echo "
                                <p>Rendez-vous du : ".$value["start_time"].", dans le service ".$value["name_service"]."</p> <br>
                            ";
                        }
                    echo "
                        <button class='button' onclick='location.href=\"info.php\"'>Retour</button>
                    </div>";
                }
                break; 
            
            case "rm" : 
                // Si l'utilisateur veut supprimer un rendez-vous
                if (isset($_GET["id"])){
                    // Si l'utilisateur a choisi un rendez-vous à supprimer
                    include("../connect/db.php"); 
                    // On supprime le rendez-vous
                    $sql = "DELETE FROM `Appointment` WHERE `id_appointment` = " . $_GET["id"]; 
                    $result = mysqli_query($con, $sql);
                    if ($result) {
                        // Si la requête s'est bien passée, on affiche un message de confirmation
                        header("Location: confirm.php?confirm=rdv_delete_2");
                        exit();
                    } else {
                        // Sinon, on affiche un message d'erreur
                        header("Location: confirm.php?confirm=rdv_delete_error");
                        exit();
                    }
                }else{
                    // Sinon, on affiche la liste des rendez-vous supprimables
                    include("../connect/db.php");
                    // On récupère les rendez-vous supprimables
                    $sql = "SELECT id_appointment, start_time, name_service FROM Appointment JOIN Users ON Appointment.id_user = Users.email NATURAL JOIN `Services` WHERE email = '".$id_user."' AND start_time > CURRENT_TIMESTAMP";
                    $result = mysqli_query($con, $sql);
                    
                    if ($result){
                        // Si la requête s'est bien passée, on affiche la liste des rendez-vous supprimables
                        $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
                        echo "
                        <div class=wrap>
                            <h2>Liste des rendez-vous supprimables</h2>
                            <ul>";
                            foreach ($rows as $row) {  
                                // Pour chaque rendez-vous, on affiche un lien pour le supprimer
                                echo "
                                <li>Supprimer le rendez-vous du <a href='rdv.php?q=rm&id=".$row["id_appointment"]."'>".$row["start_time"]." pour le service ".$row["name_service"]."</a></li>
                                ";
                            }
                            echo "</ul>
                            <button class='button' onclick='location.href=\"info.php\"'>Retour</button>
                        </div>";

                    } else {
                        // Sinon, on affiche un message d'erreur
                        echo "
                        <div class='wrap'>
                            <h2>Vous n'avez pas de rendez-vous pouvant être supprimé</h2>
                            <button class='button' onclick='location.href=\"info.php\"'>Retour</button>
                        </div>";
                    }
                }

        }
        ?>
    </body>
</html>