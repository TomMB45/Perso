<!DOCTYPE html>
<?php
include("../../connect/auth_session.php");
allowed(array("AH"), $_SESSION["role"]);
?>
<html>
    <head>
        <!-- <link rel= "stylesheet" href= "admin_page.css"></li> -->
        <link rel= "stylesheet" href= "../../common_css/form.css"></li>
        <link rel="stylesheet" href="../../common_css/button.css"></li>
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Gestion du personnel</title>
    </head>

    <body>
        <?php
        include("../../connect/db.php");
        if (isset($_POST['SERV_id'])){
            // Si le formulaire a été envoyé et que l'utilisateur a bien sélectionné un compte
            $email = $_POST['SERV_id'];
            // Suppression du compte
            $sql = "DELETE FROM Users WHERE email = '$email'";
            $result = mysqli_query($con, $sql);
            // Redirection vers la page de confirmation
            if ($result){
                header("Location: ../../info/confirm.php?&confirm=rm_True");
                exit();
            } else {
                header("Location: ../../info/confirm.php?&confirm=rm_False");
                exit();
            }
        }
        ?>
        
        <?php
        include("../../connect/db.php");
        if ($_GET['t'] != "SEC" and $_GET['t'] != "SEV"){
            // Si l'utilisateur à changé l'url pour accéder à cette page et que le paramètre n'est pas correct
            header("Location: ../../info/confirm.php?&confirm=perm_False");
            exit();
        }
        // Récupération des comptes à supprimer en fonction de leur role
        $query = "SELECT * FROM Users WHERE role = '".$_GET['t']."'";
        $result = mysqli_query($con, $query);
        if (mysqli_num_rows($result) > 0) {
            // Si il y a des comptes à supprimer
            echo "
            <div class='wrap'>
                <form action='rm_account.php?&t=".$_GET['t']."' method='post'>
                    <h2>S&eacutelectionner un compte a supprimer</h2>
                    <div class='user-box'>
                        <select name='SERV_id'>";
                    
                            while($row = mysqli_fetch_assoc($result)) {
                                // Affichage des comptes dans une liste déroulante
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
                    <button onclick='location.href=\"../../info/info.php\"' type='button' class='go_back'>Retour</button>
                </form>
            </div>";
        } else {
            // Si il n'y a pas de compte pouvant être supprimé
            $account = $_GET['t']; 
            if ($account == "SEV"){$account = "service";}else{$account = "secr&eacutetaire";}
            echo "
            <div class='wrap'>
                <h2>Aucun compte $account ne peut être supprim&eacute;.</h2>
            </div>";
            header("Refresh:3; url=../../info/info.php");
            exit();
        } 
        ?>
        
    </body>
</html>