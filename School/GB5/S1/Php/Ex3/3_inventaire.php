<?php 
session_start(); 

$_SESSION['nom'] = "MAUGER";
$_SESSION['prenom'] = "Tom";
$_SESSION['date'] = date("d/m/Y");
?>
<!DOCTYPE html>
<html>
    <head>
        <title>Ex3</title>
    </head>
    <body>
        <div>
            <h1>Voici ton inventaire</h1>
        </div>
        <div>
            <form action="3_test.php" method="get">
                <label for="inventaire">Commandes a faire : </label> <br>
                <!-- Liste de courses -->
                <label for="pain">Pain</label>
                <select name="pain">
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select> <br>

                <label for="lait">Lait</label>
                <select name="lait">
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select> <br>

                <label for="oeuf">Oeuf</label>
                <select name="oeuf">
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select> <br> <br>


                <input type="submit" value="Envoyer">
            </form>
        </div>
    </body>
</html>