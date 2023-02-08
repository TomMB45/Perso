<?php
include("../../connect/auth_session.php");
allowed(array("SEC"), $_SESSION["role"]);
?>

<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet" href= "../../common_css/form.css">
        <link rel="stylesheet" href="../../common_css/button.css">
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>V&eacute;rifier un client</title>
    </head>

    <body>
        <?php
        
        if (isset($_GET["verif"]) && $_GET["verif"] == "ok") {
            // Si la secrétaire à cliquer sur le bouton "Vérifier ce patient"
            echo "<h2>V&eacute;rifier le patient dont l'adresse email est".$_GET['client']."</h2>"; 
            include("../../connect/db.php");
            // On met à jour le rôle du patient en "CV" (Client vérifié)
            $sql = "UPDATE Users SET role = 'CV' WHERE email = '".$_GET['client']."'";
            $result = mysqli_query($con, $sql);
            // On vérifie que la requête s'est bien exécutée et on redirige vers la page de confirmation
            if($result){
                header("Location: ../../info/confirm.php?confirm=verif_client_ok");
                exit();
            }else{
                header("Location: ../../info/confirm.php?confirm=verif_client_error");
                exit();
            }   
        }
        elseif (isset($_POST['client']) && filter_var($_POST['client'], FILTER_VALIDATE_EMAIL)) {
            // Si la secrétaire à entré un email et que celui-ci est valide
            include("../../connect/db.php");
            // On récupère les informations du patient
            $sql = "SELECT * FROM Users WHERE email = '".$_POST['client']."'";
            $result = mysqli_query($con, $sql);
            if (mysqli_num_rows($result) > 0) {
                // Si le patient existe, on affiche ses informations en read only 
                $row = mysqli_fetch_array($result); 
                echo "
                <div class='wrap'>
                    <form action='verif_client.php?client=".$_POST['client']."&verif=ok' method='post'>
                        <h2>Informations du patient a valider</h2>
                        <div class='user-box'>
                            <label>Nom</label>
                            <input type='text' name='nom' value='".$row['last_name']."' readonly>
                        </div>

                        <div class='user-box'>
                            <label>Pr&eacute;nom</label>
                            <input type='text' name='prenom' value='".$row['first_name']."' readonly>
                        </div>

                        <div class='user-box'>
                            <label>Sexe</label>
                            <input type='text' name='sexe' value='".$row['sexe']."' readonly>
                        </div>

                        <div class='user-box'>
                            <label>Date de naissance</label>
                            <input type='text' name='date_naissance' value='".$row['birth_date']."' readonly>
                        </div>

                        <div class='user-box'>
                            <label>Num&eacutero de s&eacutecurit&eacute sociale</label>
                            <input type='text' name='num_secu' value='".$row['number_secu']."' readonly>
                        </div>

                        <div class='user-box'>
                            <label>Num&eacutero de t&eacutephone</label>
                            <input type='text' name='num_tel' value='".$row['phone_number']."' readonly>
                        </div>

                        <div class='user-box'>
                            <label>Adresse</label>
                            <input type='text' name='adresse' value='".$row['adress']."' readonly>
                        </div>

                        <div class='user-box'>
                            <label>Ville</label>
                            <input type='text' name='ville' value='".$row['city']."' readonly>
                        </div>

                        <div class='user-box'>
                            <label>Pays</label>
                            <input type='text' name='pays' value='".$row['country']."' readonly>
                        </div>

                        <div class='user-box'>
                            <label>Code postal</label>
                            <input type='text' name='code_postal' value='".$row['postal_code']."' readonly>
                        </div>

                        <div class='submit'>
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                            <input type='submit' value='V&eacute;rifier ce patient'>
                        </div>
                    </form>
                    <div class='link'>
                        <p>Si les informations du patient sont incrorrectes, veuillez <a href='info.php?email=".$_POST['client']."'>cliquer ici</a></p>
                    </div>
                </div>";
            } else {
                // Si le patient n'existe pas, on redirige vers la page d'erreur
                header("Location: ../../info/confirm.php?confirm=verif_client_error");
                exit();
            }
        }
        else {
            // Si la secrétaire n'a pas encore choisi de patient à vérifier
            include("../../connect/db.php");
            $sql = "SELECT email FROM Users WHERE role = 'CNV'";
            $result = mysqli_query($con, $sql);
            // On récupère les patients non vérifiés
            if (mysqli_num_rows($result) > 0) {
                // Si il y a des patients non vérifiés dans la base de données, on affiche la liste
                echo "
                <div class='wrap'>
                    <form action='verif_client.php' method='post'>
                        <h2>Liste des client non v&eacute;rifier</h2>
                        <div class='user-box'>
                            <label>Email du patient à v&eacute;rifier</label>
                            <select name='client'>";
                                while($row = mysqli_fetch_assoc($result)) {
                                    // On ajoute en option de la liste déroulante les emails des patients non vérifiés
                                    echo "<option value='".$row["email"]."'>".$row["email"]."</option>"; 
                                }
                echo "
                            </select
                            
                        </div>

                        <div class='submit'>
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                            <input type='submit' value='V&eacute;rifier ce patient'>
                        </div>
                        <button onclick='location.href=\"../../info/info.php\"' type='button' class='go_back'>Retour</button>
                    </form>
                </div>";
            } else {
                // Si il n'y a pas de patients non vérifiés dans la base de données, on affiche un message d'erreur
                echo "
                <div class='wrap'>
                    <h2>Il n'y a aucun client non v&eacute;rifier dans la base de donn&eacute;es</h2>
                </div>";
                header("Refresh: 5; url=../../info/info.php");
                exit();
            }
        }
        ?>
    </body>
</html>
