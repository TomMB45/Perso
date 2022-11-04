<?php
session_start(); 
?>
<DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Ex2</title>
    </head>

    <body>
        <p>Vous êtes : <?php echo $_SESSION["prenom"]." ".$_SESSION["nom"]." et vous avez ".$_SESSION["age"]." ans !"?></p>
    </body>
</html>