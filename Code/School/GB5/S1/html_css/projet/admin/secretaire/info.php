<?php
include("../../connect/auth_session.php");
allowed(array("SEC"), $_SESSION["role"]);
?>
<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet " href= "../../common_css/form.css"></li>
        <link rel="stylesheet" href="../../common_css/button.css"></li>
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>V&eacute;rifier un client</title>
    </head>

    <body>
        <?php
        if (isset($_GET["valid"]) && $_GET["valid"] == "ok" && isset($_GET["email"]) && filter_var($_GET['email'], FILTER_VALIDATE_EMAIL)) {
            // On vérifie que l'url présente bien un email valide et que l'utilisateur a bien cliqué sur le bouton "Valider"
            $email = $_GET["email"]; 
            include("../../connect/db.php");
            // On met à jour les informations du client
            $sql = "UPDATE Users SET 
            last_name = '".$_POST['nom']."', first_name = '".$_POST['prenom']."', sexe = '".$_POST['sexe']."', birth_date = '".$_POST['date_naissance']."', number_secu = '".$_POST['CQ']."', phone_number = '".$_POST['tel']."', adress = '".$_POST['adresse']."', city = '".$_POST['ville']."', postal_code = '".$_POST['code_postal']."', country = '".$_POST['pays']."' 
            WHERE email = '$email'";
            $result = mysqli_query($con, $sql);
            // On redirige l'utilisateur vers la page de confirmation
            if($result){
                header("Location: ../../info/confirm.php?confirm=modif_True");
                exit(); 
            }else{
                header("Location: ../../info/confirm.php?confirm=modif_False");
                exit();
            }
        }
        else {
            // Si l'utilisateur n'a pas cliqué sur le bouton "Valider" ou que l'email est incorrect, on affiche le formulaire
            if (isset($_SESSION['user_selected']) && filter_var($_SESSION['user_selected'], FILTER_VALIDATE_EMAIL)){
                // Si l'utilisateur est une secrétaire, on vérfie que l'email de l'utilisateur sélectionné est bien valide
                $email = $_SESSION['user_selected'];
            }
            else if (isset($_GET['email']) && filter_var($_GET['email'], FILTER_VALIDATE_EMAIL)) {
                // Si l'utilisateur est un client, on vérifie que l'email est bien valide
                $email = $_GET['email'];
            } else {
                // Sinon, on redirige l'utilisateur vers la page d'information
                header("Location : ../../info/info.php");
                exit();
            }
            include("../../connect/db.php");
            // On récupère les informations du client
            $sql = "SELECT * FROM Users WHERE email = '$email'";
            $result = mysqli_query($con, $sql);

            if (mysqli_num_rows($result) > 0) {
                // On vérifie que le client existe bien
                $row = mysqli_fetch_assoc($result);
                // On affiche le formulaire avec les informations du client 
                echo "
                <div class='wrap'>
                    <form action='info.php?email=$email&valid=ok' method='post'>
                        <h2>Liste des informations client</h2>
                        <div class='user-box'>
                            <label for='nom'>Nom</label>
                            <input type='text' name='nom' value='".$row['last_name']."' require> <br>
                        </div>

                        <div class='user-box'>
                            <label for='prenom'>Pr&eacutenom</label>
                            <input type='text' name='prenom' value='".$row['first_name']."' require> <br>
                        </div>

                        <div class='user-box'>
                            <label for='sexe'>Sexe</label>
                            <input type='text' name='sexe' value='".$row['sexe']."' require> <br>
                        </div>

                        <div class='user-box'>
                            <label for='date_naissance'>Date de naissance</label>
                            <input type='date' name='date_naissance' value='".$row['birth_date']."' require> <br>
                        </div>

                        <div class='user-box'>
                            <label for='CQ'>Num&eacutero de s&eacutecurit&eacute sociale</label>
                            <input type='text' name='CQ' value='".$row['number_secu']."' require> <br>
                        </div>

                        <div class='user-box'>
                            <label for='tel'>Num&eacutero de t&eacutel&eacutephone</label>
                            <input type='text' name='tel' value='".$row['phone_number']."' require> <br>
                        </div>

                        <div class='user-box'>
                            <label for='adresse'>Adresse</label>
                            <input type='text' name='adresse' value='".$row['adress']."' require> <br>
                        </div>

                        <div class='user-box'>
                            <label for='ville'>Ville</label>
                            <input type='text' name='ville' value='".$row['city']."' require> <br>
                        </div>

                        <div class='user-box'>
                            <label for='code_postal'>Code postal</label>
                            <input type='text' name='code_postal' value='".$row['postal_code']."' require> <br>
                        </div>

                        <div class='user-box'>
                            <label for='pays'>Pays</label>
                            <input type='text' name='pays' value='".$row['country']."' require> <br>
                        </div>

                        <div class='submit'>
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                            <input type='submit' value='Modifier ces informations'>
                        </div>
                        <button onclick='location.href=\"../../info/info.php\"' type='button' class='go_back'>Retour</button>
                    </form>
                </div>";
            } else {
                // Si le client n'existe pas, on affiche un message d'erreur
                echo "
                <div class='wrap'>
                    <h2>Aucun client n'a &eacute;t&eacute; trouv&eacute; à cette adresse</h2>
                </div>";
                header("Refresh:5; url=../../info/info.php");
                exit();
            }
        }

        ?>
    </body>
</html>
