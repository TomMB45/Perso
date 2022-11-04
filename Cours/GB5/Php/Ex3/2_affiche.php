<?php 
include("2_fct.php"); 
?>
<!DOCTYPE html>
<html>
    <body>
        <p>
            <?php 
            form("1"); 
            echo "Nombre d'accès : " . nb_acces("1");
            ?>
        </p>
    </body>
</html>