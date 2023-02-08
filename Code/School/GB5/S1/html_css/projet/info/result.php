<!DOCTYPE html>
<?php
include("../connect/auth_session.php");
allowed(array("CV"), $_SESSION["role"]);
?>

<html>
    <head>
        <meta charset="utf-8">
        <title>Vos r&eacute;sultat</title>
        <link rel="stylesheet" href="result.css">
        <link rel="stylesheet" href="../common_css/button.css">
        <link rel="stylesheet" href="../common_css/wrap.css">
    </head>

    <body>
        <div class=wrap>
            <?php
            include("../connect/db.php"); 
            // On récupère les noms des services dans la base de données
            $query = "SELECT name_service FROM `Services`";
            $result = mysqli_query($con, $query) or die("Il n'y a pas de services disponibles");
            $row = mysqli_fetch_all($result, MYSQLI_ASSOC);
            
            foreach ($row as $key => $value) {
                // On affiche les boutons pour chaque service en mettant en évidence le service sélectionné
                $classe = $value['name_service'] != $_GET['s'] ? "services not_selected" : "services";
                echo "<button onclick='location.href=\"result.php?s=". $value["name_service"] ."\"' type=\"button\" class='$classe'> ". $value["name_service"] ."</button>";
            }

            if (isset($_GET["s"])){
                // Si un service est sélectionné, on affiche les résultats disponibles
                $service = $_GET["s"];
                $path = "../generation_test/results/$service/".$_SESSION["email"].""; 
                if (is_dir($path)){
                    // SI le dossier existe, on affiche les résultats
                    echo "<h2>Choisissez une date</h2>";
                    chdir($path);
                    $dir = glob("*");
                    echo "<ul>";
                    foreach ($dir as $key => $value) {
                        // On affiche les résultats par date
                        $tmp = explode("_", $value);
                        $date = explode("-", $tmp[0]);
                        $date = $date[2]."/".$date[1]."/".$date[0];

                        $time = explode("-", $tmp[1]); 
                        $time = $time[0].":".$time[1];

                        echo "
                        <li class=level1>R&eacute;sultats pour votre rendez-vous du $date à $time</li>
                            <ul>"; 
                        chdir("$value");
                        $dir2 = glob("*");
                        foreach ($dir2 as $key2 => $value2) {
                            // On crée un lien de téléchargement pour chaque fichier
                            echo "<li class=level2><a href='$path/$value/$value2'  download='$value2' >$value2</a></li>";
                        }
                        echo "</ul>";
                        chdir(".."); // Dark magic, do not touch
                    }
                    echo "</ul>";
                } else {
                    // Si le dossier n'existe pas, on affiche un message
                    echo "<h2>Vous n'avez pas encore de r&eacute;sultats pour ce service</h2>";
                }
            } else {
                // Si aucun service n'est sélectionné, on affiche un message
                echo "<h2>Veuillez selectionner un service</h2>";
            }

            echo "<button onclick='location.href=\"info.php\"' type=\"button\" class=go_back>Retour</button>";
            ?>
        </div>
    </body>
</html>