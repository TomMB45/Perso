<!DOCTYPE html>
<?php
include("../../connect/auth_session.php");
allowed(array("AH"), $_SESSION["role"]);
?>
<html>
    <head>
        <link rel= "stylesheet " href= "../../common_css/form.css"></li>
        <link rel="stylesheet" href="../../common_css/button.css">
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Gestion du personnel</title>
    </head>

    <body>
        <?php
        require('../../connect/db.php');
        if (isset($_POST['first_name']) && isset($_POST['last_name']) && isset($_POST['password']) && isset($_POST['birth'])){
            // Si le form est bien remplis 
            // On récupère les valeurs entrées par l'utilisateur que l'on stripslashes et on échappe les caractères spéciaux
            $first_name = stripslashes($_REQUEST['first_name']); // removes backslashes
            $first_name = mysqli_real_escape_string($con, $first_name); //escapes special characters in a string

            $last_name = stripslashes($_REQUEST['last_name']);
            $last_name = mysqli_real_escape_string($con, $last_name);

            $email = $first_name.".".$last_name."@chabotomarty.fr";

            $birth_date = stripslashes($_REQUEST['birth']);
            $birth_date = mysqli_real_escape_string($con, $birth_date);
            $birth_date = date("Y-m-d", strtotime($birth_date));

            $password = stripslashes($_REQUEST['password']);
            $password = mysqli_real_escape_string($con, $password);

            $create_datetime = date("Y-m-d H:i:s"); 

            if ($_GET['t'] == "SEV"){
                // Si le compte est un compte service
                $service = $_POST["service"];
                // On insère les données reçues dans la base de données
                $query = "INSERT INTO `Users` (email, password, first_name, last_name, role, birth_date, create_datetime) VALUES ('$email', '" . password_hash($password, PASSWORD_DEFAULT) . "', '$first_name', '$last_name', '".$_GET['t']."', '$birth_date', '$create_datetime');";
                $result = mysqli_query($con, $query);
                if ($result){
                    // On insère ce nouvel utilisateur dans le service correspondant
                    $query = "INSERT INTO `user_belongs_service` (name_service, name) VALUES ('$service', '$email')"; 
                } else {
                    header("Location: ../../info/confirm.php?confirm=account_False");
                    exit();
                }
            } else {
                // Si le compte est un compte secrétaire, on ajoute juste l'utilisateur dans la base de données
                $query = "INSERT INTO `Users` (email, password, first_name, last_name, role, birth_date, create_datetime) VALUES ('$email', '" . password_hash($password, PASSWORD_DEFAULT) . "', '$first_name', '$last_name', '".$_GET['t']."', '$birth_date', '$create_datetime');"; 
            }
            $result = mysqli_query($con, $query);
            // On redirige l'utilisateur vers la page de confirmation en fonction du résultat de la requête
            if ($result) {
                header("Location: ../../info/confirm.php?confirm=account_True");
                exit();
            } else {
                header("Location: ../../info/confirm.php?confirm=account_False");
                exit();
            }
        }
        ?>
        <div class = wrap>
            <form action="" method="post"> 
                <h2>Cr&eacute;er un compte </h2>
                <div class="user-box">
                    <input type="text" name="first_name" required>
                    <label>Pr&eacute;nom</label>
                </div>

                <div class="user-box">
                    <input type="text" name="last_name" required>
                    <label>Nom</label>
                </div>
                <?php
                if ($_GET['t'] == "SEV"){
                    // Si le compte est un compte service, on affiche la liste des services pour que l'utilisateur puisse choisir le service auquel il doit ajouté l'utilisateur
                    echo "
                    <div class='user-box'>
                        <label>Service</label>
                        <select name='service'> ";
                            include('../../connect/db.php');
                            $query = 'SELECT * FROM `Services`';
                            $result = mysqli_query($con, $query);
                            while ($row = mysqli_fetch_array($result)) {
                                echo "<option value='" . $row['name_service'] . "'>" . $row['name_service'] . "</option>";
                            }
                        echo "
                        </select>
                    </div>"; 
                }
                ?>

                <div class="user-box">
                    <input type="date" name="birth" required>
                    <label>Date de naissance</label>
                </div>

                <div class="user-box">
                    <input type="password" name="password" required>
                    <label>Mot de passe</label>
                </div>

                <div class="submit">
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <input type="submit" name="submit" value="Cr&eacute;er le compte">
                </div>
                <button onclick='location.href="../../info/info.php"' type="button" class="go_back">Retour</button>
            </form>
        </div>
    </body>
</html>