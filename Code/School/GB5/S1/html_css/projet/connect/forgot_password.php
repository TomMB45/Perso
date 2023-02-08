<?php
$token = uniqid();
setcookie("psswrdToken", $token, time() + 900); 
?>
<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet " href= "../common_css/form.css"></li>
        <link rel= "stylesheet " href= "../common_css/basics.css"></li>
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Mot de passe oubli&eacute;</title>
    </head>

    <body>
        <?php
        

        // On regarde d'abord si jamais une erreur est survenue
        if (isset($_GET['error'])) {
            switch ($_GET['error']) {
                case 'unexpectedError':
                    echo "
                    <div class=wrap>
                        <h2>Une erreur est survenue</h2>
                    </div>
                    ";
                    header("Refresh: 5; url=forgot_password.php");
                    exit();
                    break;
                
                case 'wrongMail':
                    echo "
                    <div class=wrap>
                        <h2>Cet email n'existe pas</h2>
                    </div>
                    ";
                    header("Refresh: 5; url=forgot_password.php");
                    exit();
                    break;
            
                case 'passOK':
                    echo "
                    <div class=wrap>
                        <h2>Votre mot de passe a été changé avec succès</h2>
                    </div>
                    ";
                    header("Refresh: 5; url=../info/info.php");
                    exit();
                    break;
                
            }
        }
        


        require('db.php');
        include("../usefull_function/mailing.php"); 
        
        
        // On check si l'utilisateur a cliqué sur le lien envoyé par mail
        if (isset($_GET['token'])){
            
            // On récupère le token
            $token_get = $_GET['token'];

            $token_mail = substr($token_get, 13);
            $token_id = substr($token_get, 0, 13);
            
            $ciphering = "AES-128-CTR";
            $iv_length = openssl_cipher_iv_length($ciphering);
            // On déchiffre l'email
            $decryption_iv = '1234567891011121';
            $decryption_key = "UwU";
            $to = openssl_decrypt($token_mail, $ciphering, $decryption_key, 0, $decryption_iv);
            
            // On check si le token est bon
            if(isset($_COOKIE['psswrdToken'])){
                
                if ($token_id == $_COOKIE['psswrdToken']){
                    // On affiche le formulaire pour changer le mot de passe

                    echo"
                    <div class=wrap>
                        <h2>Changer de mot de passe</h1>
                        <form method='post' action='forgot_password.php?token=$token_get'>
                            <div class='user-box'>
                                <input type='password' name='password' required />
                                <label>Nouveau mot de passe</label>
                            </div>

                            <div class='submit'>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span> 

                                <input type='submit' name='submited' value='Changer' />
                            </div>
                        </form>
                    </div>";
                }
            }
        }

        // On check si l'utilisateur a cliqué sur le bouton "Changer" après avoir renseigné le nouveau mot de passe
        else

        if (isset($_POST['submited'])){
            $password = stripslashes($_POST['password']);
            $password = mysqli_real_escape_string($con, $password);

            $query = "UPDATE Users SET password = '". password_hash($password, PASSWORD_DEFAULT) ."' WHERE email = '$to'";
            $result = mysqli_query($con, $query) or die(mysql_error());
            
            if ($result){
                header("Location: forgot_password.php?error=passOK");
                exit();
            } else {
                header("Location: forgot_password.php?error=unexpectedError");
                exit();
            }
        }

        // On traite l'adresse mail entrée dans le formulaire

        elseif (isset($_POST['email']) && !isset($_GET['error'])){

            $email = stripslashes($_POST['email']); 
            $email = mysqli_real_escape_string($con, $email);
            
            $query    = "SELECT * FROM `Users` WHERE email='$email'";
            $result = mysqli_query($con, $query) or die(mysql_error());
            $rows = mysqli_num_rows($result);
            $rowParsed = mysqli_fetch_assoc($result);
            
            
            if ($rows == 1 and in_array($rowParsed['role'],array('CV','CNV','SU'))) {
                $to = $email;
                mdp_recovery($to, $token);
                echo "
                    <div class=wrap>
                        <h2>Un email pour le changement de votre mot de passe a été envoyé</h2>
                    </div>
                    ";
                    exit();       
            }
             else {
                header("Location: forgot_password.php?error=wrongMail");
                exit();
            }
        }
        
        
       // On affiche le formulaire pour rentrer l'adresse mail
        if (!isset($_GET['token'])){
            echo "
            <div class=wrap>
                <h2>Mot de passe oubi&eacute;</h1>
                <form method='post' action='forgot_password.php'>
                    <div class='user-box'>
                        <input type='email' name='email' required>
                        <label>Adresse mail</label>
                    </div>

                    <div class='submit'>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span> 
                        <input type='submit' value='Envoyer'>
                    </div>
                </form>
            </div>
            ";
        }
        ?>

        
    </body>
</html>