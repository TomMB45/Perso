<?php 
include("2_fct.php"); 
?>
<!DOCTYPE html>
<html>
    <body>
        <p>
            <?php 
            form("2"); 
            echo "Nombre d'accès : " . nb_acces("2");
            ?>
        </p>
    </body>
</html>