<!DOCTYPE html>
<?php
include("../../connect/auth_session.php");
allowed(array("SEV"), $_SESSION["role"]);
?>

<html>
    <head>
        <link rel= "stylesheet " href= "../../common_css/form.css"></li>
        <link rel= "stylesheet " href= "../../common_css/basics.css"></li>
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Gestion des r&eacute;sultats</title>
    </head>

    <body>
        <?php
        if (isset($_POST["rdv"])) {
            // Si l'utilisateur du service a choisi un rendez-vous

            // On récupère le service et la date du rendez-vous
            $service = explode("/",$_POST["rdv"])[0];
            $date = explode("/",$_POST["rdv"])[1];
            $email = $_SESSION['user_selected'];
            // On se rend dans le dossier relatif au service
            chdir("../../generation_test/results/$service");
            $action = $_GET["action"];
            switch ($action){
                case 'add' : 
                    // Si l'utilisateur veut ajouter un résultat
                    echo "<div class='wrap'>"; 
                        if (is_dir($email)){
                            // Si le dossier de l'utilisateur existe
                            // on se rend dans le dossier de l'utilisateur
                            chdir($email);
                            // On met en forme la date pour la comparer avec les dossiers existants
                            $date = explode(" ", $date);
                            $date = $date[0]."_".$date[1];
                            $date = explode(":", $date);
                            $date = $date[0]."-".$date[1]."-".$date[2];

                            if (is_dir($date)){
                                // Si le dossier de la date existe, on se rend dedans
                                chdir($date);
                            } else {
                                // Si le dossier de la date n'existe pas, on le crée et on se rend dedans
                                mkdir($date);
                                chdir($date);
                            } 
                        } else {
                            // Si le dossier de l'utilisateur n'existe pas, on le crée
                            $date = explode(" ", $date);
                            $date = $date[0]."_".$date[1];
                            $date = explode(":", $date);
                            $date = $date[0]."-".$date[1]."-".$date[2];

                            mkdir($email);
                            chdir($email);
                            mkdir($date);
                            chdir($date);
                        }
                        if (isset($_FILES["CR"]) && $_FILES["CR"]["size"] != 0) {
                            // Si l'utilisateur a envoyé un compte rendu
                            $infosfichier = pathinfo($_FILES ['CR']['name']) ;
                            $extension_upload = $infosfichier ['extension'];
                            // On vérifie que l'extension du fichier est autorisée
                            $extensions_autorisees = array('pdf', 'docx', 'doc', 'txt', 'odt');
                            if (!in_array($extension_upload, $extensions_autorisees)){
                                // Si l'extension n'est pas autorisée, on affiche un message d'erreur
                                echo "<h2>Extension non autoris&eacutee pour le compte rendu</h2> <ul>Extension autoris&eacutee : <li>pdf</li> <li>docx</li> <li>doc</li> <li>txt</li> <li>odt</li> </ul>";
                            } else {
                                // Si l'extension est autorisée, on renomme le fichier
                                $CR = $_FILES["CR"];
                                $CR = $CR["name"];
                                $CR = explode(".", $CR);
                                $CR = $CR[0]."_".date("Y-m-d").".".$CR[1];
                                if (move_uploaded_file($_FILES["CR"]["tmp_name"] ,$CR)){
                                    // Si le fichier a bien été renommé et déplacé dans l'arborescence, on affiche un message de succès
                                    echo "<h2>Compte rendu envoy&eacute</h2>
                                    <br>";
                                } else {
                                    // Si le fichier à été renommé mais qu'il n'a pas pu être déplacé dans l'arborescence, on affiche un message d'erreur
                                    echo "<h2>Erreur de l'envoi du compte rendu</h2>
                                    <br>";
                                }
                            }
                        }
                        if (isset($_FILES["RES"]) && $_FILES["RES"]["size"] != 0) {
                            // Si l'utilisateur a envoyé un résultat
                            $infosfichier = pathinfo($_FILES ['RES']['name']) ;
                            $extension_upload = $infosfichier ['extension'];
                            // On vérifie que l'extension du fichier est autorisée
                            $extensions_autorisees = array('pdf', 'docx', 'doc', 'txt', 'odt');
                            if (!in_array($extension_upload, $extensions_autorisees)){
                                // Si l'extension n'est pas autorisée, on affiche un message d'erreur
                                echo "<h2>Extension non autoris&eacutee pour le compte rendu</h2> <ul>Extension autoris&eacutee : <li>pdf</li> <li>docx</li> <li>doc</li> <li>txt</li> <li>odt</li> </ul>";
                            } else {
                                // Si l'extension est autorisée, on renomme le fichier
                                $RES = $_FILES["RES"];
                                $RES = $RES["name"];
                                $RES = explode(".", $RES);
                                $RES = $RES[0]."_".date("Y-m-d").".".$RES[1];
                                if (move_uploaded_file($_FILES["RES"]["tmp_name"], $RES)) {
                                    // Si le fichier a bien été renommé et déplacé dans l'arborescence, on affiche un message de succès
                                    echo "<h2>R&eacutesultat envoy&eacute</h2>
                                    <br>";
                                } else {
                                    // Si le fichier à été renommé mais qu'il n'a pas pu être déplacé dans l'arborescence, on affiche un message d'erreur
                                    echo "<h2>Erreur de l'envoi du r&eacutesultat</h2>
                                    <br>";
                                }
                            }
                        }
                        if (isset($_FILES["IMG"]) && $_FILES["IMG"]["size"] != 0) {
                            // Si l'utilisateur a envoyé une image
                            $infosfichier = pathinfo($_FILES ['IMG']['name']) ;
                            $extension_upload = $infosfichier ['extension'];
                            // On vérifie que l'extension du fichier est autorisée
                            $extensions_autorisees = array("jpg", "jpeg", "png", "svg");
                            if (!in_array($extension_upload, $extensions_autorisees)){
                                // Si l'extension n'est pas autorisée, on affiche un message d'erreur
                                echo "<h2>Extension non autoris&eacutee pour le compte rendu</h2> <ul>Extension autoris&eacutee : <li>jpg</li> <li>jpeg</li> <li>png</li> <li>svg</li> </ul>";
                            } else {
                                // Si l'extension est autorisée, on renomme le fichier
                                $IMG = $_FILES["IMG"];
                                $IMG = $IMG["name"];
                                $IMG = explode(".", $IMG);
                                $IMG = $IMG[0]."_".date("Y-m-d").".".$IMG[1];
                                if (move_uploaded_file($_FILES["IMG"]["tmp_name"], $IMG)) {
                                    // Si le fichier a bien été renommé et déplacé dans l'arborescence, on affiche un message de succès
                                    echo "<h2>Image envoy&eacute</h2>
                                    <br>";
                                } else {
                                    // Si le fichier à été renommé mais qu'il n'a pas pu être déplacé dans l'arborescence, on affiche un message d'erreur
                                    echo "<h2>Erreur de l'envoi de l'image</h2>
                                    <br>";
                                }
                            }
                        }
                        echo "<button onclick='location.href=\"../../info/info.php\"'>Retour</button>
                    </div>";
                    header("Refresh: 5; url=../../info/info.php"); 
                    break;
                
                case 'rm' :
                    // Si l'utilisateur veut supprimer un fichier
                    echo "<div class='wrap'>"; 
                        if (is_dir($email)){
                            // Si le dossier de l'utilisateur existe, on se déplace dedans
                            chdir($email);
                            $date = explode(" ", $date);
                            $date = $date[0]."_".$date[1];
                            $date = explode(":", $date);
                            $date = $date[0]."-".$date[1]."-".$date[2];
                            if (is_dir($date)){
                                // Si le dossier de la date existe, on se déplace dedans
                                chdir($date);
                                // On récupère le nom du fichier relatif à ce patient pour cette date 
                                $files = glob("*");
                                foreach($files as $key => $value){
                                    // Pour tout les fichiers, on affiche un bouton pour supprimer le fichier
                                    echo "
                                    <button onclick='location.href=\"result.php?action=".$_GET["action"]."&f=$value&email=$email&date=$date&s=$service\"'>$value</button> <br>
                                    "; 
                                }                                
                            } else {
                                // Si le dossier de la date n'existe pas, on affiche un message d'erreur
                                echo "<h2>Pas de r&eacute;sultats pour cette date</h2>
                                <button onclick='location.href=\"../../info/info.php\"'>Retour</button>";
                                header("Refresh: 5; url=../../info/info.php");
                                exit(); 
                            }
                        } else {
                            // Si le dossier de l'utilisateur n'existe pas, on affiche un message d'erreur
                            echo "<h2>Pas de r&eacute;sultats pour ce patient</h2>
                            <button onclick='location.href=\"../../info/info.php\"'>Retour</button>";
                            header("Refresh: 5; url=../../info/info.php");
                            exit(); 
                        }
                    echo "
                    <button onclick='location.href=\"../../info/info.php\"'>Retour</button>
                    </div>
                    ";
                    break;
            }
            
        } else if ($_GET["action"] == "rm" && isset($_GET["f"]) && isset($_GET["date"]) && isset($_GET["s"])){
            // Si l'utilisateur a cliqué sur un bouton pour supprimer un fichier
            echo "<div class='wrap'>";
                // On récupère les informations du fichier à supprimer
                $service = $_GET["s"];
                $email = $_SESSION["user_selected"];
                $date = $_GET["date"];
                $file = $_GET["f"];

                // On se déplace dans l'arborescence pour supprimer le fichier
                chdir("../../generation_test/results/$service");
                if (is_dir($email)){
                    // Si le dossier de l'utilisateur existe, on se déplace dedans
                    chdir($email);
                    if (is_dir($date)){
                        // Si le dossier de la date existe, on se déplace dedans
                        chdir($date);
                        if (is_file($file)){
                            // Si le fichier existe, on le supprime
                            unlink($file);
                            echo "<h2>Le fichier à bien &eacute;t&eacute; supprim&eacute;</h2>
                            <button onclick='location.href=\"../../info/info.php\"'>Retour</button>";
                            header("Refresh: 5; url=../../info/info.php");
                            exit();
                        } else {
                            // Si le fichier n'existe pas, on affiche un message d'erreur
                            echo "<h2>Fichier introuvable</h2>
                            <button onclick='location.href=\"../../info/info.php\"'>Retour</button>";
                            header("Refresh: 5; url=../../info/info.php");
                            exit();
                        }
                    } else {
                        // Si le dossier de la date n'existe pas, on affiche un message d'erreur
                        echo "<h2>Aucun r&eacute;sultat pour cette date</h2>
                        <button onclick='location.href=\"../../info/info.php\"'>Retour</button>";
                        header("Refresh: 5; url=../../info/info.php");
                        exit(); 
                    }
                } else {
                    // Si le dossier de l'utilisateur n'existe pas, on affiche un message d'erreur
                    echo "<h2>Aucun r&eacute;sultats pour ce patient</h2>
                    <button onclick='location.href=\"../../info/info.php\"'>Retour</button>";
                    header("Refresh: 5; url=../../info/info.php");
                    exit(); 
                }
            echo "</div>
            <button onclick='location.href=\"../../info/info.php\"'>Retour</button>";
        } else {
            // Si l'utilisateur n'a pas cliqué sur un bouton pour supprimer un fichier, on affiche un message d'erreur
            ?>
            <div class='wrap'>
                <form action="result.php?action=<?php echo $_GET["action"] ?>" method="post" enctype="multipart/form-data">
                    <h2>Choix du patient</h2>
                    <div class='user-box'>
                        <?php
                        include("../../connect/db.php");
                        // On récupère les informations de l'utilisateur du service connecté
                        $sql2 = "SELECT * FROM Services NATURAL JOIN user_belongs_service WHERE name = '".$_SESSION['email']."'";
                        $result2 = mysqli_query($con, $sql2);
                        $rowS = mysqli_fetch_assoc($result2);

                        if (!isset($_SESSION['user_selected'])){
                            // Si l'utilisateur n'a pas encore choisi de patient, on affiche un select avec tous les patients du service
                            header("Location: ../../info/info.php"); 
                            exit(); 
                        }
                        // On récupère les informations du patient sélectionné
                        $sql = "SELECT * FROM Appointment JOIN Users ON Appointment.id_user = Users.email NATURAL JOIN `Services` WHERE start_time < CURRENT_DATE AND email = '".$_SESSION['user_selected']."' AND name_service = '".$rowS['name_service']."'";
                        $result = mysqli_query($con, $sql);
                        $rows = mysqli_num_rows($result);
                        if ($rows == 0){
                            // Si le patient n'a pas de rendez-vous, on affiche une liste vide
                            echo "
                                <select name='rdv' id='state' required>
                                </select>
                                ";
                        } else {
                            // Si le patient a des rendez-vous, on affiche un select avec tous les rendez-vous du patient
                            $rowA = mysqli_fetch_all($result, MYSQLI_ASSOC);
                            echo "
                            <select name='rdv' id='state' required>"; 
                                foreach ($rowA as $key => $value) {
                                    // On récupère les informations du rendez-vous
                                    $service = $value["name_service"];
                                    $start_time = $value["start_time"];
                                    if ($service = $rowS['name_service']) {
                                        // Si le rendez-vous est du service connecté, on l'affiche
                                        echo "
                                        <option value='$service/$start_time'>$start_time</option>";
                                    }
                                }
                            echo "
                            </select>
                            ";
                        }
                        ?>
                        <label for="rdv">Rendez-vous</label>
                    </div>

                    <?php
                    $action = $_GET["action"];
                    switch ($action){
                        // On affiche les boutons en fonction de l'action
                        case 'add' : 
                            // Si l'utilisateur veut ajouter un fichier, on affiche les boutons pour ajouter un fichier
                            echo "
                            <div class='user-box'>
                                <input type='file' class = 'button' name='CR' value='CR'></input>
                                <label>compte rendu</label>
                            </div>

                            <div class='user-box'>
                                <input type='file' class = 'button' name='RES' value='RES'></input>
                                <label>r&eacutesultat</label>
                            </div>

                            <div class='user-box'>
                                <input type='file' class = 'button' name='IMG' value='IMG'></input>
                                <label>image</label>
                            </div>

                            <div class='submit'>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <input type='submit' value='Envoyer les r&eacute;sultats du patient' class='input_b'>
                            </div>";
                            break;

                        case 'rm' : 
                            // Si l'utilisateur veut supprimer un fichier, on affiche les boutons pour supprimer un fichier
                            echo "
                            <div class='submit'>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <input type='submit' value='Supprimer les r&eacute;sultats du patient' class='input_b'>
                            </div>";
                            break;
                    }
                    ?>
                </form>
                <button onclick='location.href="../../info/info.php"'>Retour</button>
            </div>
        <?php
    }
    ?>
    </body>
</html>