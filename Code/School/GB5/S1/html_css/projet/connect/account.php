<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet " href= "../common_css/form.css"></li>
        <link rel= "stylesheet " href= "../common_css/basics.css"></li>
        <link rel="stylesheet" href="../common_css/button.css"></li>
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Cr&eacute;er un compte</title>
    </head>

    <body>     
        <?php
    require('db.php');
    // Quand le formulaire est envoyé on check les champs et on rempli la base de données
    if (isset($_POST['submited'])) {
        $first_name = stripslashes($_POST['first_name']); 
        $first_name = mysqli_real_escape_string($con, $first_name);

        $last_name = stripslashes($_POST['last_name']);
        $last_name = mysqli_real_escape_string($con, $last_name);

        $email = stripslashes($_POST['email']);
        $email = mysqli_real_escape_string($con, $email);

        $password = stripslashes($_POST['password']);
        $password = mysqli_real_escape_string($con, $password);
        $password = password_hash($password, PASSWORD_DEFAULT); // On hash le mot de passe

        $tel = stripslashes($_POST['phone_number']);
        $tel = mysqli_real_escape_string($con, $tel);

        $cq = stripslashes($_POST['CQ']);
        $cq = mysqli_real_escape_string($con, $cq);

        $pays = stripslashes($_POST['country']);
        $pays = mysqli_real_escape_string($con, $pays);

        $ville = stripslashes($_POST['city']);
        $ville = mysqli_real_escape_string($con, $ville);

        $code_postal = stripslashes($_POST['CP']);
        $code_postal = mysqli_real_escape_string($con, $code_postal);

        $adresse = stripslashes($_POST['adress']);
        $adresse = mysqli_real_escape_string($con, $adresse);

        $birth = stripslashes($_POST['birth']);
        $birth = mysqli_real_escape_string($con, $birth);

        $create_datetime = date("Y-m-d H:i:s");
        
        // On insère les données dans la base de données et on génère un message de succès ou d'échec
        $query    = "INSERT into `Users` 
        (email, password, first_name, last_name, role, birth_date, number_secu, phone_number, country, city, postal_code, adress, create_datetime)
                     VALUES ('$email', '" . $password . "', '$first_name', '$last_name', 'CNV', '$birth', '$cq', '$tel', '$pays', '$ville', '$code_postal', '$adresse' ,'$create_datetime')";
        $result   = mysqli_query($con, $query);
        if ($result) {
            echo "
            <div class='wrap'> 
                <div class='form'>
                    <h2>Votre compte a &eacute;t&eacute; cr&eacute;e avec succ&egrave;s</h2><br>
                    <p class='link'>Cliquez ici pour se <a href='connect.php'>connecter</a></p>
                </div>
            </div>";
        } else {
            echo "
            <div class='wrap'> 
                <div class='form'>
                    <h3>La cr&eacute;ation de votre compte a &eacute;chou&eacute;</h2><br>
                    <p class='link'>Cliquez ici pour vous <a href='account.php'>cr&eacute;er un compte</a> &agrave; nouveau.</p>
                </div>
            </div>
            ";
        }
    } else {
?>  
    <div class=wrap>
        <h2>Inscription</h2>
        <form action="account.php" method="post">
            <div class="user-box">
                <input type="text" name="first_name" autocomplete="on" required>
                <label>Votre pr&eacutenom </label>
            </div>

            <div class="user-box">
                <input type="text" name = "last_name" autocomplete="on" required>
                <label>Votre nom </label> 
            </div>

            <div class="user-box">
                <input type="text" name = "CQ" autocomplete="on" required>
                <label>Votre num&eacutero de s&eacutecurit&eacute sociale </label> 
            </div>
            
            <div class="user-box">
                <input type="email" name="email" autocomplete="on" required>
                <label>Votre mail </label>
            </div>

            <div class="user-box">
                <input type="date" name="birth" autocomplete="on" required>
                <label>Votre date de naissance </label>
            </div>

            <div class="user-box">
                <input type="text" name="genre" autocomplete="on" required>
                <label>Genre</label>
            </div>

            <div class="user-box">
                <input type="tel" name="phone_number" autocomplete="on" required>
                <label>Votre num&eacutero de t&eacutel&eacutephone </label>
            </div>

            <div class="user-box">
                <input type="text" name="country" autocomplete="on" required>
                <label>Votre pays </label>
            </div>

            <div class="user-box">
                <input type="text" name="city" autocomplete="on" required>
                <label>Votre ville </label>
            </div>

            <div class="user-box">
                <input type="text" name="CP" autocomplete="on" required>
                <label>Votre code postal </label>
            </div>

            <div class="user-box">
                <input type="text" name="adress" autocomplete="on" required>
                <label> Votre adresse </label>
            </div>

            <div class="user-box">
                <input type="password" name="password" autocomplete="on" required>
                <label> Mot de passe </label>
            </div>

            <div class="submit">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                <input type="submit" name ="submited" value="Cr&eacute;er votre compte">
            </div>
            <button onclick='location.href="../info/info.php"' type="button" class="go_back">Retour</button>
        </form>
    </div>
<?php
    }
?>
    
    </body>
</html>