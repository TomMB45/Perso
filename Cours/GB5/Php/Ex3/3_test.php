<!DOCTYPE html>
<html>
    <head>
        <title>Ex3</title>
    </head>
    <body>
        <h1>Résumé de la commande</h1>
        <div>
            <?php 
            $str = "3_commande.php?"; 
            foreach($_GET as $key => $value){
                if ($value != 0){
                    echo "<li>" . $key . " : " . $value . "</li>";
                    $str .= $key . "=" . $value . "&";
                }
            }
            // ?pain=3&lait=0&oeuf=2
            $str = substr($str, 0,-1);

            ?>
        </div>
        <div>
            <button onclick='location.href="3_inventaire.php"'>Retour</button>
            <button onclick='location.href="<?php echo $str; ?>"'>Valider</button>
        </div>
    </body>
</html>

