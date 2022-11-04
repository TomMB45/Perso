<?php 
session_start(); 

$_SESSION['nom'] = "MAUGER";
$_SESSION['prenom'] = "Tom";
$_SESSION['age'] = 24;

?>
<DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Ex2</title>
    </head>

    <body>
        <button onclick="location.href='5_2.php'" type="button">Infos</button>
        <button onclick="location.href='5_3.php'" type="button">Close session</button>
        </body>
</html>