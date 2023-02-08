<!DOCTYPE html>
<?php
include("../connect/auth_session.php");
// On vérifie que l'utilisateur est bien un super utilisateur
allowed(array(), $_SESSION["role"]);
?>
<html>
    <head>
        <link rel= "stylesheet " href= "../common_css/form.css"></li>
        <link rel="stylesheet" href="../common_css/button.css">
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Gestion des administrateurs hospitaliers</title>
    </head>

    <body>
        <?php
        $action = $_GET['action'];
        // On récupère l'action à effectuer (supprimer ou ajouter un compte)
        switch ($action){
            case "add": 
                // Ajouter un compte
                require('../connect/db.php');
                if (isset($_POST['first_name']) && isset($_POST['last_name']) && isset($_POST['password']) && isset($_POST['birth'])){
                    // Si les champs sont remplis, on récupère les données
                    // On supprime les backslashes et on échappe les caractères spéciaux

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

                    // On ajoute le compte dans la base de données
                    $query = "INSERT INTO `Users` (email, password, first_name, last_name, role, birth_date, create_datetime) VALUES ('$email', '" . password_hash($password, PASSWORD_DEFAULT) . "', '$first_name', '$last_name', 'AH', '$birth_date', '$create_datetime');"; 

                    $result = mysqli_query($con, $query);
                    if ($result) {
                        // Si l'ajout a réussi, on redirige vers la page de confirmation
                        header("Location: ../info/confirm.php?confirm=account_True");
                        exit();
                    } else {
                        // Sinon, on redirige vers la page d'erreur
                        header("Location: ../info/confirm.php?confirm=account_False");
                        exit();
                    }
                }
                // On affiche le formulaire d'ajout tant que les champs ne sont pas remplis
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
                        <button onclick='location.href="../info/info.php"' type="button" class="go_back">Retour</button>
                    </form>
                </div>
            <?php
                break;
        
            case "rm" : 
                // Supprimer un compte
                include("../connect/db.php");
                if (isset($_POST['SERV_id'])){
                    // Si l'utilisateur a sélectionné un compte
                    $email = $_POST['SERV_id'];
                    $sql = "DELETE FROM Users WHERE email = '$email' AND role = 'AH'";
                    // On supprime le compte de la base de données
                    $result = mysqli_query($con, $sql);
                    if ($result){
                        // Si la suppression a réussi, on redirige vers la page de confirmation
                        header("Location: ../../info/confirm.php?&confirm=rm_True");
                        exit();
                    } else {
                        // Sinon, on redirige vers la page d'erreur
                        header("Location: ../../info/confirm.php?&confirm=rm_False");
                        exit();
                    }
                }
                
                // Si l'utilisateur n'a pas sélectionné de compte, on affiche la liste des comptes
                include("../connect/db.php");
                $query = "SELECT * FROM Users WHERE role = 'AH'";
                // On récupère la liste des comptes AH dans la base de données
                $result = mysqli_query($con, $query);
                if (mysqli_num_rows($result) > 0) {
                    // Si la liste n'est pas vide, on affiche le formulaire de suppression
                    echo "
                    <div class='wrap'>
                        <form action='su.php?action=rm' method='post'>
                            <h2>S&eacutelectionner un compte a supprimer</h2>
                            <div class='user-box'>
                                <select name='SERV_id'>";
                            
                                    while($row = mysqli_fetch_assoc($result)) {
                                        // On ajoute chaque compte à la liste déroulante
                                        echo "<option value='".$row["email"]."'>".$row["email"]."</option>"; 
                                    }
                        echo "
                                </select>
                            </div>

                            <div class='submit'>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <input type='submit' value='Supprimer ce compte'>
                            </div>
                            <button onclick='location.href=\"../info/info.php\"' type='button' class='go_back'>Retour</button>
                        </form>
                    </div>";
                } else {
                    // Si la liste est vide, on affiche un message d'erreur
                    $account = "administrateur hospitalier"; 
                    echo "
                    <div class='wrap'>
                        <h2>Aucun compte $account ne peut être supprim&eacute;.</h2>
                    </div>";
                    header("Refresh:3; url=../info/info.php");
                    exit();
                } 
                break;
        }
                ?>        
    </body>
</html>