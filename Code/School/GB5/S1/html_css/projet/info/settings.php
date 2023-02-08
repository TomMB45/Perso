<?php
include("../connect/auth_session.php");

// include("../../connect/auth_session.php");
allowed(array("CV","CNV"), $_SESSION["role"]);
?>



<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet" href= "../common_css/button.css"></li>
        <link rel= "stylesheet" href= "../common_css/form.css"></li>
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Param&egravetres de votre compte</title>
    </head>

    <body>
        <?php
            include("../connect/db.php");
            // Récupération des informations de l'utilisateur connecté
            $query = "SELECT * FROM Users WHERE email = '".$_SESSION['email']."'";
            $result = mysqli_query($con, $query);
            $row = mysqli_fetch_array($result);

            $prenom = $row['first_name'];
            global $prenom;
            $nom = $row['last_name'];
            global $nom;
            $adresse = $row['adress'];
            global $adresse;
            $ville = $row['city'];
            global $ville;
            $code_postal = $row['postal_code'];
            global $code_postal;
            $pays = $row['country'];
            global $pays;
            $telephone = $row['phone_number'];
            global $telephone;

            // On affiche les informations de l'utilisateur dans un form en readonly
            ?>
        <div class=wrap>
            <h2>Param&egravetres de votre compte</h2>
            <h3>Vous êtes <?php echo $nom . ", " . $prenom; ?></h3>
            <form>
                <div class='user-box'>
                    <label>Pr&eacute;nom</label>
                    <input type='text' name='prenom' value= <?php echo $prenom; ?> readonly>
                </div>

                <div class='user-box'>
                    <label>Nom</label>
                    <input type='text' name='nom' value= <?php echo $nom; ?> readonly>
                </div>

                <div class='user-box'>
                    <label>Adresse</label>
                    <input type='text' name='adresse' value= <?php echo $adresse; ?> readonly>
                </div>

                <div class='user-box'>
                    <label>Ville</label>
                    <input type='text' name='ville' value= <?php echo $ville; ?> readonly>
                </div>

                <div class='user-box'>
                    <label>Code postal</label>
                    <input type='text' name='code_postal' value= <?php echo $code_postal; ?> readonly>
                </div>

                <div class='user-box'>
                    <label>Pays</label>
                    <input type='text' name='pays' value= <?php echo $pays; ?> readonly>
                </div>
                <div class='submit'>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <button onclick='location.href="change_info.php?i=adress"' type="button" class='update_param_b'>Changer d'adresse</button> <br>
                </div>

                <div class='user-box'>
                    <label>T&eacute;l&eacute;phone</label>
                    <input type='text' name='telephone' value= <?php echo $telephone; ?> readonly>
                </div>

                <div class='submit'>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <button onclick='location.href="change_info.php?i=tel"' type="button" class='update_param_b'>Changer de num&eacute;ro de t&eacute;l&eacute;phone</button> <br>
                </div>

                <div class='user-box'>
                    <label>Email</label>
                    <input type='text' name='email' value= <?php echo $_SESSION['email']; ?> readonly> 
                </div>

                <div class='submit'>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <button onclick='location.href="change_info.php?i=mail"' type="button" class='update_param_b'>Changer d'adresse mail</button> <br>
                </div>

                <div class='user-box'>
                    <label>Mot de passe</label>
                </div>

                <div class='submit'>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <button onclick='location.href="change_info.php?i=password"' type="button" class='update_param_b'>Modifier votre mot de passe</button> <br>
                </div>

                <div class='user-box'>
                    <label>Supprimer votre compte</label>
                </div>

                <div class='submit'>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <button onclick='location.href="change_info.php?i=rm_account"' type="button" class='update_param_b'>Supprimer votre compte</button> <br>
                </div>
            </form>
            <button onclick='location.href="info.php"' type="button">Retour</button>
        </div>
    </body>
</html>