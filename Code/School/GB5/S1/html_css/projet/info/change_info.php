<!DOCTYPE html>
<?php
include("../connect/auth_session.php");
allowed(array('CV', 'CNV'), $_SESSION["role"]);
?>

<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet " href= "settings.css"></li>
        <link rel= "stylesheet " href= "../common_css/form.css"></li>
        <link rel= "stylesheet " href= "../common_css/button.css"></li>
        <link rel= "stylesheet " href= "../common_css/basics.css"></li>
        <meta charset="utf-8">
        <title>Param&egrave;tres</title>
    </head>
    <body>
        <?php
        // On récupère quel information doit être changé et on l'affiche
        $info_change = $_GET['i'];
        switch ($info_change) {
            case 'tel':
                // Si on doit changer le numéro de téléphone
                include("../connect/db.php");
                if (isset($_POST['tel']) && preg_match("/^[0-9]{10}+$/", $_POST["tel"])) {
                    // On vérifie que le numéro de téléphone est valide
                    $tel = $_POST['tel'];
                    $id = $_SESSION['email'];
                    // On met à jour la base de données
                    $sql = "UPDATE Users SET phone_number = '$tel' WHERE email = '$id'";
                    $result = mysqli_query($con, $sql);
                
                    if ($result) {
                        // Si la modification a été effectuée, on redirige vers la page de confirmation
                        header("Location: confirm.php?&confirm=modif_True");
                        exit();
                    } else {
                        // Sinon on redirige vers la page d'erreur
                        header("Location: confirm.php?&confirm=modif_False");
                        exit();
                    }
                } else {
                    // Si le numéro de téléphone n'est pas valide, on redirige vers la page d'erreur
                    $query = "SELECT phone_number FROM Users WHERE email = '".$_SESSION['email']."'";
                    // On récupère le numéro de téléphone actuel
                    $result = mysqli_query($con, $query);
                    $row = mysqli_fetch_array($result);
                    $telephone = $row['phone_number'];
                    global $telephone;
                }
        // On affiche le formulaire de changement de numéro de téléphone
        ?> 
        <div class = wrap>
            <form action="change_info.php?i=<?php echo $_GET["i"]?>" method="post">
                <h2>Modifier votre num&eacute;ro de t&eacute;l&eacute;phone</h2>
                <div class='user-box'>
                    <label for="tel">Nouveau num&eacutero :</label>
                    <input type="text" name="tel" value= "<?php echo $telephone ;?>"require>
                </div>
                
                <div class='submit'>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <input type="submit" value="Valider le changement">
                </div>
            </form>
            <button onclick='location.href="settings.php"' type="button">Retour</button>
        </div>
    </body>
</html>
        
        <?php
                break;
        
            case 'mail': 
                // Si on doit changer l'adresse mail
        ?>
        <?php
                include("../connect/db.php");

                if (isset($_POST['mail']) && filter_var($_POST["mail"], FILTER_VALIDATE_EMAIL)) {
                    // On vérifie que l'adresse mail est valide
                    $email = $_POST['mail'];
                    $sql = "UPDATE users SET email = '$email' WHERE email = '$email'";
                    // On met à jour la base de données
                    $result = mysqli_query($con, $sql);  
                    if ($result) {
                        // Si la modification a été effectuée, on redirige vers la page de confirmation
                        $_SESSION['email'] = $email;
                        header("Location: confirm.php?&confirm=modif_True");
                        exit();
                    } else {
                        // Sinon on redirige vers la page d'erreur
                        header("Location: confirm.php?&confirm=modif_False");
                        exit();
                    }
                }
                // On affiche le formulaire de changement d'adresse mail
        ?>
                <div class='wrap'>
                    <form action="change_info.php?i=<?php echo $_GET["i"]?>" method="post">
                        <h2>D&eacuteclarer un changement d'adresse mail</h2>
                        <div class='user-box'>
                            <label for="mail">Nouvelle adresse mail :</label>
                            <input type="text" name="mail" value= "<?php echo $_SESSION["email"];?>" require>
                        </div>
                        <div class='submit'>
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                            <input type="submit" value="Valider le changement">
                        </div>
                    </form>
                    <button onclick='location.href="settings.php"' class="return" type="button">Retour</button>
                </div>
            </body>
        </html>
        <?php
                break;
            case 'adress' :
                // Si on doit changer l'adresse
        ?>
        <?php
                include("../connect/db.php");

                if (isset($_POST['num']) && isset($_POST['rue']) && isset($_POST['ville']) && isset($_POST['code_postal'])) {
                    // On vérifie que les champs sont remplis
                    $adress = $_POST['num'] . " " . $_POST['rue'];
                    $ville = $_POST['ville'];
                    $code_postal = $_POST['code_postal'];
                    $id = $_SESSION['email'];
                    // On met à jour la base de données
                    $sql = "UPDATE Users SET adress = '$adress', city = '$ville', postal_code = '$code_postal' WHERE email = '$id'";
                    $result = mysqli_query($con, $sql);

                    if ($result) {
                        // Si la modification a été effectuée, on redirige vers la page de confirmation
                        header("Location: confirm.php?&confirm=modif_True");
                        exit();
                    } else {
                        // Sinon on redirige vers la page d'erreur
                        header("Location: confirm.php?&confirm=modif_False");
                        exit();
                    }
                // On affiche le formulaire de changement d'adresse
                } else {        
                    // On récupère les informations de l'utilisateur            
                    include("../connect/db.php");
                    $query = "SELECT * FROM Users WHERE email = '".$_SESSION['email']."'";
                    $result = mysqli_query($con, $query);
                    $row = mysqli_fetch_array($result);
                    $adresse = $row['adress'];
                    global $adresse;
                    $ville = $row['city'];
                    global $ville;
                    $code_postal = $row['postal_code'];
                    global $code_postal;
                    $pays = $row['country'];
                    global $pays;
                }
                // On affiche le formulaire de changement d'adresse
        ?>
                <div class='wrap'>
                    <form action="change_info.php?i=<?php echo $_GET["i"]?>" method="post">
                        <h2>D&eacuteclarer un changement d'adresse</h2>
                        <div class='user-box'>
                            <label for="num">Nouveau num&eacutero :</label>
                            <input type="text" name="num" value="<?php echo explode(" ", $adresse)[0];?>"require>
                        </div>

                        <div class='user-box'>
                            <label for="rue">Nouveau nom de rue :</label>
                            <input type="text" name="rue" value="<?php 
                            $res = ""; 
                            for ($i = 1; $i < count(explode(" ", $adresse)); $i++) {
                                // On récupère le nom de la rue
                                $res .= explode(" ", $adresse)[$i] . " ";
                            }
                            echo $res;
                            ?>" require>
                        </div>

                        <div class='user-box'>
                            <label for="ville">Nouvelle ville :</label>
                            <input type="text" name="ville" value="<?php echo $ville; ?>" require>
                        </div>

                        <div class='user-box'>
                            <label for="code_postal">Nouveau code postal :</label>
                            <input type="text" name="code_postal" value="<?php echo $code_postal; ?>" require>
                        </div>
                        
                        <div class='submit'>
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                            <input type="submit" value="Valider le changement">
                        </div>
                    </form>
                    <button onclick='location.href="settings.php"' type="button">Retour</button>
                </div>
            </body>
        </html>
        <?php
                break;
            case 'password': 
                // Si on doit changer le mot de passe
        ?>
        <?php
                include("../connect/db.php");
                if (isset($_POST['mdp']) && isset($_POST['mdp2']) && $_POST['mdp'] == $_POST['mdp2']) {
                    // On vérifie que les champs sont remplis
                    $mdp = $_POST['mdp'];
                    $email = $_SESSION['email'];
                    // On hash le mot de passe
                    $mdp = password_hash($mdp, PASSWORD_DEFAULT);
                    // On met à jour la base de données
                    $sql = "UPDATE Users SET password = '$mdp' WHERE email = '$email'"; 
                    $result = mysqli_query($con, $sql);  
                    if ($result) {
                        // Si la modification a été effectuée, on redirige vers la page de confirmation
                        header("Location: confirm.php?&confirm=modif_True");
                        exit();
                    } else {
                        // Sinon on redirige vers la page d'erreur
                        header("Location: ../info/confirm.php?&confirm=modif_False");
                        exit();
                    }
                }
                // On affiche le formulaire de changement de mot de passe
                
        ?>
                <div class='wrap'>
                    <form action="change_info.php?i=<?php echo $_GET["i"]?>" method="post">
                        <h2>D&eacuteclarer un changement de mot de passe</h2>
                        <div class='user-box'>                       
                            <label for="mdp">Nouveau mot de passe</label>
                            <input type="password" name="mdp" placeholder="Nouveau mot de passe" require>
                        </div>

                        <div class='user-box'>
                            <label for="mdp">Confirmer le nouveau mot de passe</label>
                            <input type="password" name="mdp2" placeholder="Confirmer le nouveau mot de passe" require>
                        </div>

                        <div class='submit'>
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                            <input type="submit" value="Valider le changement">
                        </div>
                    </form>
                    <button onclick='location.href="settings.php"' type="button">Retour</button>
                </div>
            </body>
        </html>
        <?php
                break;

            case 'rm_account' : 
                // Si on doit supprimer le compte
                if (isset($_GET['rm']) && $_GET['rm'] == "OK") {
                    // Si on a confirmé la suppression du compte
                    include("../connect/db.php");
                    $email = $_SESSION['email'];
                    // On supprime le compte de la base de données
                    $sql = "DELETE FROM Users WHERE email = '$email'";
                    $result = mysqli_query($con, $sql);
                    if ($result) {
                        // Si la suppression a été effectuée, on redirige vers la page de confirmation
                        header("Location: ../info/confirm.php?&confirm=rm_True");
                        exit();
                    } else {
                        // Sinon on redirige vers la page d'erreur
                        header("Location: ../info/confirm.php?&confirm=rm_False");
                        exit();
                    }
                } else {
                    // Si on n'a pas confirmé la suppression du compte
                ?> 
                <div class='wrap'>
                    <h2>Suppression de votre compte</h2>
                    <p>Vous &ecirctes sur le point de supprimer votre compte. Cette action est irr&eacutecup&eacute;rable.<br> Voulez-vous continuer ?</p>
                    <div class='submit'>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <button onclick='location.href="change_info.php?i=rm_account&rm=OK"' type="button" class='.update_param_b'>Oui</button>
                    </div>
                    <div class='submit'>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <button onclick='location.href="settings.php"' type="button" class='.update_param_b'>Non</button>
                    </div>
                </div>
            </body>
        </html>
                <?php
                }
                break; 

            default: 
                header("Location: confirm.php?&confirm=info_False");
                exit();
        }
        ?>
