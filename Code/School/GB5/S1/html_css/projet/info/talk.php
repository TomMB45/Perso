<!DOCTYPE html>
<?php
include("../connect/auth_session.php");
allowed(array("CV"), $_SESSION["role"]);
?>

<html>
    <head>
        <link rel= "stylesheet" href= "../common_css/form.css">
        <link rel="stylesheet" href="../common_css/button.css">
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Demande de tchat</title>
    </head>

    <body>
        <?php
        if (isset($_POST['message']) && isset($_POST["rdv"])){
            // Si le message n'est pas vide et que le rdv est bien défini
            // On initialise des variables contenant les informations du message
            $email = $_SESSION['email'];
            $message = $_POST['message'];
            $rdv = $_POST['rdv'];
            $service = strtolower(explode("/", $rdv)[0]);
            if ($message != ""){
                // Si le message n'est pas vide
                include("../usefull_function/mailing.php");
                switch ($service) {
                    // Si le service est un service comportant des accents, on le remplace par son équivalent sans accent
                    case 'int&eacute;rimaire':
                        $service = "interimaire";
                        break;
                    case 'h&eacute;matologie':
                        $service = "hematologie";
                        break;
                }
                // On envoie le message au service concerné
                tchat($message, "$service@chabotomarty.fr");
                header("Location: ../info/confirm.php?&confirm=tchatOk");
                exit();

            }else{
                // Si le message est vide, on redirige vers la page de confirmation avec un message d'erreur
                header("Location: ../info/confirm.php?&confirm=tchatError");
                exit();
            }
        }
        ?>

        <div class="wrap">
            <form action="talk.php" method="post">
                <h2>Demande de tchat</h2>

                <div class="user-box">
                    <?php
                    include("../connect/db.php");
                    // On récupère les rendez-vous passés de l'utilisateur
                    $sql = "SELECT * FROM Appointment NATURAL JOIN Services WHERE start_time < CURRENT_DATE AND id_user = '".$_SESSION["email"]."';";
                    $result = mysqli_query($con, $sql);
                    $row = mysqli_fetch_all($result, MYSQLI_ASSOC);
                    if (count($row) == 0){
                        // Si l'utilisateur n'a pas de rendez-vous passé, on affiche une liste vide
                        echo "
                        <select name='state' id='state' required>
                        </select>
                        ";
                    } else {
                        // Sinon, on affiche la liste des rendez-vous passés
                        echo "
                        <select name='rdv' id='state' required>"; 
                            foreach ($row as $key => $value) {
                                $service = $value["name_service"];
                                $start_time = $value["start_time"];
                                echo "
                                    <option value='$service/$start_time'> $service : $start_time</option>";
                            }
                        echo "
                        </select>
                        ";
                    }
                    ?>
                    <label>Pour quel rendez-vous</label>
                </div>

                <div class="user-box">
                    <textarea name="message" placeholder="Message que vous souhaitez envoyer à un professionnel de sant&eacute;.&#10;Vous pouvez demander des conseils à propos de vos r&eacute;sultats ou toute autre question" required></textarea>
                    <label>Message</label>
                </div>

                <div class="submit">
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span> 

                    <input type="submit" value="Envoyer">
                </div>
                <button onclick='location.href="info.php"' type="button" class="go_back">Retour</button>
            </form>
        </div>
    </body>
</html>