<?php
    // On vérifie si l'utilisateur est connecté
    session_start();
    if(!isset($_SESSION["email"])) {
        header("Location: ../info/info.php");
        exit();
    }

    // On vérifie si l'utilisateur a le droit d'accéder à la page
    function allowed($roleAllowed, $roleCheck){
        if (!in_array($roleCheck, $roleAllowed) && $roleCheck != "SU") {
            header("Location: ../info/info.php");
            exit();
        }
    }
?>
