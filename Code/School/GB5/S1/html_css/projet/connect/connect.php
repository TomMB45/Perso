<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet " href= "../common_css/form.css"></li>
        <link rel= "stylesheet " href= "../common_css/basics.css"></li>
        <link rel="stylesheet" href="../common_css/button.css"></li>
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Se connecter</title>
    </head>

    <body>
    <?php
    require('db.php');
    session_start();
    
    if(isset($_SESSION["email"])) {
        header("Location: ../info/info.php");
        exit();
    }
    
    // Quand le formulaire est envoyé 
    if (isset($_POST['email'])) {
        $email = stripslashes($_REQUEST['email']);    
        $email = mysqli_real_escape_string($con, $email);
        $password = stripslashes($_REQUEST['password']);
        $password = mysqli_real_escape_string($con, $password);
        
        
        // Check utilisateur existe dans la base de données
        $query    = "SELECT * FROM `Users` WHERE email='$email'";
        
        
        $result = mysqli_query($con, $query) or die(mysql_error());
        $rows = mysqli_num_rows($result);
        $rowParsed = mysqli_fetch_assoc($result);

        // Si l'utilisateur existe et que le mot de passe est correct
        if (($rows == 1) and password_verify($password, $rowParsed['password'])) {
            // Création des variables de session
            $_SESSION['email'] = $email;
            $_SESSION['role'] = $rowParsed['role'];
            header("Location: ../info/info.php");
        } else {
            echo "
            <div class=wrap>
                <h2>Erreur lors de la connection</h2>
                <br>
                <img src='../image/cpt.gif' alt='vilebrequin'>
                <label>Bravo vous avez réussit a trouver l'easter egg n°1 du site</label>
                <br>
                <button onclick='location.href=\"connect.php\"' type=\"button\" class=\"return\">Retour</button>
                <img src=\"../image/Eggs.png\" alt=\"easter egg logo\" style=\"width:calc(923px/10);height:calc(1000px/10);position: relative;float: right;\">
            </div>
            "; // Connection impossible 
            header("Refresh: 5; url=connect.php");
            exit();
        }
    } else {
?>
    <div class=wrap>
        <h2>Connexion</h2>
        <form method="post" action="connect.php">
            <div class="user-box">
                <input type="email" name="email" autocomplete="on" placeholder="" required>
                <label>Email</label>
            </div>
            
            <div class="user-box">
                <input type="password" name="password" placeholder="" required>
                <label>Mot de passe</label>
            </div>

            <div class="submit">
                <span></span>
                <span></span>
                <span></span>
                <span></span>  
                <input type="submit" value="Connexion">  
            </div>
        </form>
        <br>
        <div id='Fr_connect'>
            <label style = "text-align: center">Connectez vous avec France connect</label>
        </div>
        <div id='Fr_connect_logo'>
            <a href = '../info/confirm.php?confirm=fr_connect' 
            style= "display: block;
                margin-left: auto;
                margin-right: auto" >
                <img src="../image/Fr_Connect.png" alt="France connect">
            </a>
        </div>
        

        <div class=link>
            <p>Mot de passe oubli&eacute <a href="forgot_password.php">cliquez ici !</a> </p>
            <p>Vous n'avez pas encore de compte <a href="account.php">cliquez ici !</a></p>
        </div>
        <button onclick='location.href="../info/info.php"' type="button" class="go_back">Retour</button>
    </div>
    
<?php
    }
?>
    </body>
</html>