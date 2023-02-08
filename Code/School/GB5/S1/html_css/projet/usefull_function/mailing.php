<?php
    // $header = "From: test@chabotomarty.fr\r\n";

    // $header .= "CC: tommaugeriguet@gmail.com \r\n"; 
    // mail("tommaugeriguet@gmail.com", "test", "test_1", $header);


    function mdp_recovery($to, $token){
        require ("../connect/db.php"); 

        $ciphering = "AES-128-CTR";
        $iv_length = openssl_cipher_iv_length($ciphering);
        
    
        $encryption_iv = '1234567891011121';
        $encryption_key = "UwU";
        
        $token_email = openssl_encrypt($to, $ciphering, $encryption_key, 0, $encryption_iv);
        

        $subject = "ChaboToMarty lab: Mot de passe oubli&acute";
        $message = "<p>Bonjour</p>, <br><p>Vous avez demander une r&eacute;initialisation de votre mot de passe</p> <p>Veuillez cliquer <a href='https://chabotomarty.fr/testv2/connect/forgot_password.php?token=".$token.$token_email."'>ici</a> pour r&eacute;initialiser votre mot de passe</p><br> <p>Cordialement,</p> <br> <p>L'&eacute;quipe ChaboToMarty lab</p>";
        $headers = "MIME-Version: 1.0\r\n";
        //Set the content-type to html
        $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
        $headers .= "From: recovery@chabotomarty.fr";

        mail($to, $subject, $message, $headers);
        
    }

    function tchat($request, $to){
        include ("../connect/db.php"); 
        $subject = "Nouveau message de ".$_SESSION["email"];
        $message = $request;
        $headers = "From: tchat@chabotomarty.fr"; 
        mail($to, $subject, $message, $headers);
    }           

    function confirmRDV($to, $date, $time, $id_service){
        $service = $id_service; 
        $subject = "Confirmation de rendez-vous";
        $message = "<p>Bonjour, </p><br> <p>Votre rendez-vous pour le service " . $service . " est confirm&eacute; pour le  $date a  $time .</p><br> <p>Cordialement, </p><br> <p>L'&eacute;quipe ChaboToMarty lab</p>";
        $headers = "MIME-Version: 1.0\r\n";
        //Set the content-type to html
        $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
        $headers .= "From: no-reply@chabotomarty.fr";
        mail($to, $subject, $message,$headers);
    }
?>
