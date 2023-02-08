<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../common_css/form.css">
</head>
<body>

<?php
if (isset($_GET['confirm'])){
    $confirm = $_GET['confirm'];
}


switch ($confirm) {
    case 'rdvTrue':
        // Si le rdv a été pris, on affiche un message de confirmation
        echo "
        <div class=wrap>
            <h2> Votre rendez-vous a bien &eacutet&eacute pris </h2>
            <br>
            <button onclick='location.href=\"info.php\"' type=\"button\" class=\"return\">Retour</button>
        </div>
        ";
        break;
    
    case 'rdvFalse':
        // Si le rdv n'a pas été pris, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Une erreur est survenue lors de la prise de rendez-vous</h2>
            <br>
            <button onclick='location.href=\"info.php\"' type=\"button\" class=\"return\">Retour</button>
        </div>
        ";
        break;
    
    case 'passwordChange':
        // Si le mot de passe à été changé, on affiche un message de confirmation
        echo "
        <div class=wrap>
            <h2>Votre mot de passe a &eacute;t&eacute; chang&eacute; avec succ&egrave;s</h2>
            <br><h3>Vous allez etre redirig&eacute prochainement</h3>
        </div>
        ";
         
        header("Refresh:5; url=info.php");
        exit();
        break;

    case 'tchatOk': 
        // Si le message a été envoyé, on affiche un message de confirmation
        echo "
        <div class=wrap>
            <h2>Votre message a bien &eacutet&eacute envoy&eacute</h2>
            <br>
            <button onclick='location.href=\"info.php\"' type=\"button\" class=\"return\">Retour</button>
        </div>
        ";
        break;        
    
    case 'tchatError':
        // Si le message n'a pas été envoyé, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Une erreur est survenue lors de l'envoi de votre message</h2>
            <br>
            <button onclick='location.href=\"info.php\"' type=\"button\" class=\"return\">Retour</button>
        </div>
        ";
        break;

    case 'account_True':
        // Si le compte a été créé, on affiche un message de confirmation
        echo "
        <div class=wrap>
            <h2>Votre compte a bien &eacutet&eacute cr&eacutee</h2>
            <br>
            <button onclick='location.href=\"info.php\"' type=\"button\" class=\"return\">Retour</button>
        </div>";
        header("Refresh:5; url=info.php");
        exit(); 
        break;

    case 'account_False':
        // Si le compte n'a pas pu être créé, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Une erreur est survenue lors de la cr&eacuteation de votre compte</h2>
            <br>
            <button onclick='location.href=\"info.php\"' type=\"button\" class=\"return\">Retour</button>
        </div>";
        header("Refresh:5; url=info.php");
        exit();
        break;

    case 'rm_True':
        // Si le compte a été supprimé, on affiche un message de confirmation
        echo "
        <div class=wrap>
            <h2>Le compte a bien &eacutet&eacute supprim&eacute</h2>
            <br>
        </div>";
        header("Refresh:5; url=../connect/logout.php");
        break;

    case 'rm_False':
        // Si le compte n'a pas pu être supprimé, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Une erreur est survenue lors de la suppression du compte</h2>
            <br>
            <button onclick='location.href=\"info.php\"' type=\"button\" class=\"return\">Retour</button>
        </div>";
        break;

    case 'perm_False':
        // Si l'utilisateur n'a pas les droits pour accéder à la page, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Vous n'avez pas les droits pour acc&eacuteder &agrave cette page</h2>
            <br>
            <button onclick='location.href=\"info.php\"' type=\"button\" class=\"return\">Retour</button>
        </div>
        ";
        break;

    case 'modif_True': 
        // Si la modification a été prise en compte, on affiche un message de confirmation
        echo "
        <div class=wrap>
            <h2>Votre modification a bien &eacutet&eacute prise en compte</h2>
            <br>
        </div>
        ";
        header("Refresh:5; url=info.php");
        exit();
        break;

    case 'modif_False' :
        // Si la modification n'a pas été prise en compte, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Une erreur est survenue lors du changement</h2>
            <p>Veuilez r&eacuteessayer</p>
            <br>
        </div>";
        header("Refresh:5; url=info.php");
        exit();
        break;

    case 'info_False' : 
        // Si la modification n'a pas été prise en compte, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Une erreur est survenue sur la page de modification de vos informations</h2>
            <h3>Veuilez r&eacuteessayer</h3>
            <br>
            <p>Le probl&egrave;me peut venir :</p>
            <ul>
                <li>D'une modification de l'URL de redirecton</li>
                <li>Erreur de redirection interne au site web</li>
            </ul>
            <br>
            <p>Si le probl&egrave;me persiste, veuillez contacter l'administrateur du site</p>

        </div>";
        header("Refresh:5; url=info.php");
        exit();
        break;

    case 'rdv_delete' : 
        // Si la suppression du rendez-vous à échoué, on affiche un message d'erreur
        header("Refresh:0; url=calendar.php");
        exit();
        break;

    case 'rdv_delete_2' :
        // Si la suppression du rendez-vous à fonctionner, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Votre rendez-vous a bien &eacutet&eacute supprim&eacute</h2>
            <br>
            <button onclick='location.href=\"info.php\"' type=\"button\" class=\"return\">Retour</button>
        </div>";
        header("Refresh:5; url=info.php");
        exit();
        break;
    
    case 'rdv_delete_error' :
        // Si la suppression du rendez-vous à échoué, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Une erreur est survenue lors de la modification du rendez-vous</h2>
            <br>
        </div>"; 
        header("Refresh:5; url=info.php");
        exit();
        break;

    case 'redirect_err' : 
        // Si la redirection à échoué, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Une erreur est survenue lors de la redirection</h2>
            <br>
        </div>"; 
        header("Refresh:5; url=info.php");
        exit();
        break;

    case 'verif_client_ok' : 
        // Si la vérification du patient à fonctionner, on affiche un message de confirmation
        echo "
        <div class=wrap>
            <h2>Le patient a &eacute;t&eacute; v&eacute;rifi&eacute;</h2>
            <br>
        </div>";
        header("Refresh:5; url=info.php");
        exit();
        break;
    
    case 'verif_client_error' :
        // Si la vérification du patient à échoué, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Une erreur est survenue lors de la v&eacute;rification du patient</h2>
            <br> 
            <p>Veuillez r&eacute;essayer</p>
            <br>
        </div>"; 
        header("Refresh:5; url=info.php");
        exit();
        break;
    
    case 'CNV_max_rdv' :
        // Si le patient a atteint le nombre maximum de rendez-vous, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>En tant que client non v&eacute;rifi&eacute; vous ne pouvez pas prendre un nouveau rdv </h2>
            <br> 
            <p>Si il s'agit d'un erreur, n'h&eacute;sitez pas à nous contacter</p>
            <br>
        </div>"; 
        header("Refresh:5; url=info.php");
        exit();
        break;
    
    case 'SEC_no_user_selected' : 
        // Si la secrétaire n'a pas sélectionné de patient, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Vous devez s&eacute;lectionner un patient pour acc&eacute;der au calendrier</h2>
            <br>
        </div>"; 
        header("Refresh:5; url=info.php");
        exit();
        break;

    case 'fr_connect' : 
        // Si la connexion à échoué, on affiche un message d'erreur
        echo "
        <div class=wrap>
            <h2>Nous n'avons pas r&eacute;ussit à obtenir <br>les habilitations nécessaire</h2>
            <p>Pour plus de rensignements, veuillez cliquer <a href=\"https://api.gouv.fr/les-api/franceconnect/demande-acces\" target=\"_blank\">ici</a></p>
            <br>
            <label>Bravo vous avez trouvé l'easter egg n°2 du site !</label>
            <button onclick='location.href=\"../connect/connect.php\"' type=\"button\" class=\"return\">Retour</button>
            <img src=\"../image/Eggs.png\" alt=\"easter egg logo\" style=\"width:calc(923px/10);height:calc(1000px/10);position: relative;float: right;\">
        </div>"; 
        break;

    case 'pointer' :
        echo "
        <div class=wrap>
            <h2>Vous avez trouvé l'easter egg n°3 du site !</h2>
            <br>
            <label>Bravo vous avez trouvé l'easter egg n°3 !</label>
            <br> 
            <p>Pour voir cet easter egg, veuillez cliquer <a href=\"https://pointerpointer.com/\" target=\"_blank\">ici</a></p>
            <button onclick='location.href=\"info.php\"' type=\"button\" class=\"return\">Retour</button>
            <img src=\"../image/Eggs.png\" alt=\"easter egg logo\" style=\"width:calc(923px/10);height:calc(1000px/10);position: relative;float: right;\">
        </div>";
    
        
}

?>


</body>
</html>
