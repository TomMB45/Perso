<?php
    session_start();
    // Destruction de la session
    if(session_destroy()) {
        // Redirection vers la page d'accueil
        header("Location: ../info/info.php");
    }
?>
