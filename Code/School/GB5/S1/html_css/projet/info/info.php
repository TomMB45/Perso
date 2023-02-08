<!DOCTYPE html>
<?php
session_start();
?>
<html>
    <head>
        <link rel= "stylesheet" href= "info.css"></li>
        <link rel= "stylesheet" href= "../common_css/button.css"></li>
        <meta name= "viewport" content= "width=device-width, initial-scale=1.0">
        <title>Accueil</title>
    </head>
    <body>
        <div class=en_tete_div>
            <img src="../image/logo.png" alt="logo du laboratoire d'analyse Chabotomarty" class="en_tete">
        </div>
        <?php
        // Si l'utilisateur est connecté, on affiche les boutons de déconnexion et de paramètres
        if (!empty($_SESSION)) {
            echo "
            <div class=header_right>
                <div class='you'>
                Vous êtes connect&eacute avec l'adresse email : ".$_SESSION['email']."
                </div>

                <div class=button>
                    <div>
                        <button onclick='location.href=\"../connect/logout.php\"' type='button'>Se d&eacuteconnecter</button>
                    </div>

                    <div>
                        <button onclick='location.href=\"settings.php\"' type='button'>Param&egravetres</button>
                    </div>
                </div>
            </div>";
            // Si l'utilisateur est un service ou une secrétaire, on affiche le champ de sélection d'utilisateur
                if ($_SESSION['role'] == "SU" or $_SESSION['role'] == "SEC" or $_SESSION['role'] == "SEV" ) {
                include("../connect/db.php");
                # Début de l'echo du form de sélection d'utilisateur
                echo "
                <div class=wrap>
                    <form action='info.php' method='post'>
                    ";
                    // Si l'utilisateur a sélectionné un utilisateur, on effectue la requête pour récupérer les infos de l'utilisateur
                    if (isset($_POST['submit_user']) && filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
                        $email = $_POST['email'];
                        $query = "SELECT * FROM `Users` WHERE email = '$email'";
                        
                        $result = mysqli_query($con, $query) or die(mysql_error());
                        $rows = mysqli_num_rows($result);
                        
                        
                    // Si l'utilisateur existe, on affiche les infos de l'utilisateur avec le bouton de suppression de la sélection
                        if ($rows == 1){
                            $row = mysqli_fetch_assoc($result);
                            $role = $row['role'];
                            // On vérifie que l'utilisateur ne soit pas un service ou une secrétaire ou un admin hospitalier
                            if ($role == "CV" or $role == "CNV" or $role == "SU"){
                                #FOR TESTING ONLY MUST REMOVE SU
                            $user = $row['email'];
                            $_SESSION['user_selected'] = $user;
                            echo "
                            <div class='user-box'>
                                <label for='email'>Utilisateur s&eacute;lectionn&eacute; : </label>
                                <input type='email' class=user_selected name='email' value='".$_SESSION['user_selected']."' readonly>
                            </div>

                            <div class='submit'>
                                <input type='submit' name='flush_user' value='Supprimer la s&eacute;lection'>
                            </div>"; 
                            } else {
                                // On gère le cas ou l'utilisateur n'est pas un client
                                echo "
                                <div class='user-box'>
                                    <label for='email'>Vous devez choisir uniquement des clients</label>
                                </div>

                                <div class='user-box'>
                                    <label for='email'>Email du client : </label>
                                    <input type='email' name='email'>
                                </div>

                                <div class='submit'>
                                    <input type='submit' name='submit_user' value='V&eacute;rifier'>
                                </div>
                                ";
                            }
                        
                        } else {
                            // On gère le casou l'utilisateur n'existe pas ou n'a pas été trouvé
                            echo "
                            <div class='user-box'>
                                <label for='email'>Aucun utilisateur trouv&eacute;/selectionn&eacute;</label>
                            </div>
                            <div class='user-box'>
                                <label for='email'>Email du client : </label>
                                <input type='email' name='email'>
                            </div>

                            <div class='submit'>
                                <input type='submit' name='submit_user' value='V&eacute;rifier'>
                            </div>
                            ";
                            unset($_POST['submit_user']);   
                        }
                    // On complète l'echo du form de sélection d'utilisateur
                        echo "
                    </form>
                </div>"; 
                    } else {
                        // On gère le cas ou l'utilisateur n'a pas encore sélectionné d'utilisateur
                    echo "
                        <div class='user-box'>
                            <label for='email'>Email du client : </label>
                            <input type='email' name='email'>
                        </div>

                        <div class='submit'>
                            <input type='submit' name='submit_user' value='V&eacute;rifier'>
                        </div>
                    </form>
                </div>"; 
                unset($_SESSION['user_selected']);
                }
                } elseif ($_SESSION['role'] == "CNV" or $_SESSION['role'] == "SU") {
                    // Si l'utilisateur est un client non vérifié, on affiche un message le lui disant
                    echo "
                    <div class='wrap user-box'>
                        <label style=\" font-weight: 600;color: #52AD9C; font-size: x-large\">Vous &ecirc;tes actuellement un client non v&eacute;rifi&eacute;, vous serez v&eacute;rifi&eacute;s à votre passage au laboratoire lors de votre premier rendez vous</label>
                    </div>
                    ";
                } 

        } else {
            // Si l'utilisateur n'est pas connecté, on affiche les boutons de connexion et d'inscription
            echo "
            <div class=connect> 
                <div class='connect_b'>
                    <button onclick='location.href=\"../connect/connect.php\"' type='button'> Connexion</button>
                </div>
                
                <div class='account_b'>
                    <button onclick='location.href=\"../connect/account.php\"' type='button'> Inscription</button>
                </div>
            </div>"; 
        }
        
        // On affiche le menu
        include("menu.php");




        // include("caroussel.php");
        ?>
        

        <!-- <h1>Informations</h1> -->
        <div class=info>
            <h1>Informations</h1>
        </div>
            <div  class="right_text">
                <img src="../image/info/Cardio.png" alt="logo d'un &eacute;lectrocardiogramme dans un coeur" id="Logo_Cardio">
                <h2> Cardiologie </h2>
                <p>Le service de cardiologie assure la prise en charge des pathologies cardiaques et la surveillance de l’insuffisance cardiaque, de l’insuffisance coronaire, de l’hypertension art&eacute;rielle, des troubles du rythme cardiaque, de la cardiopathie cong&eacute;nitale et des pathologies vasculaires. Le service assure une prise en charge des analyses par un m&eacute;decin cardiologue sur les plages horraires 8h-12h30 et 14h-17h30.
                Des collaborations avec les autres hôpitaux du d&eacute;partement sont mises en place au sein d’un groupement hospitalier de territoire.
                </p>
                <p><strong>Examens r&eacute;alis&eacute;s :</strong></p>
                <ul>
                    <li>Coronarographie</li>
                    <li>Echographie</li>
                    <li>Epreuve d'effort</li>
                </ul>
            </div>

            <div class="left_text">
            <img src="../image/info/Hemato.png" alt="logo d'une loupe avec une goutte de sang" id="Logo_Hemato">
            <h2> H&eacute;matologie </h2>
                <p>Le service d'H&eacute;matologie assure l'ensemble des demandes d'analyses h&eacute;matologiques. Les analyses effectu&eacute;es consistent à &eacute;valuer les &eacute;l&eacute;ments qui composent le sang, la moelle osseuse et les liquides biologiques.</p>
                <p><strong>Examens r&eacute;alis&eacute;s :</strong></p>
                <ul>
                    <li>Biopsie m&eacute;dullaire</li>
                    <li>Etude cytog&eacute;n&eacute;tique</li>
                    <li>H&eacute;mogramme</li>
                    <li>Immunoph&eacute;notypage</li>
                    <li>My&eacute;logramme</li>
                </ul>
                
            </div> 

            <div class="right_text">
                <img src="../image/info/Radio.png" alt="logo d'une personne réalisant un examen de radiologie du thorax" id="Logo_Radio">
                <h2> Imagerie m&eacute;dicale </h2>
                <p>Le service d'imagerie m&eacute;dicale est ouvert du lundi au samedi entre 8h-12h30 et 14h-17h30 </p>
                <p><strong>Examens r&eacute;alis&eacute;s :</strong></p>
                <ul>
                    <li>Radiologie</li>
                    <li>Mammographie</li>
                    <li>Ost&eacute;odensitom&eacute;trie</li>
                    <li>Echographie</li>
                    <li>IRM</li>
                </ul>
            </div>

            <div class="left_text">
            <img src="../image/info/Dermato.png" alt="logo d'une couche de peau avec 3 poils" id="Logo_Dermato">
            <h2> Dermatologie </h2>
                <p>
                    Les analyses cutan&eacutee sont effectu&eacutees pour d&eacuteterminer si la peau est s&egraveche, grasse ou mixte, pour analyser l'acn&eacute, les points noirs,
                    le vieillissement, les dommages subis par la peau et l'&eacutetat de d&eacuteshydratation de cette derni&egravere, permettant ainsi de mieux choisir le traitement adapt&eacute. 
                </p>
                <p><strong>Examens r&eacute;alis&eacute;s :</strong></p>
                <ul>
                    <li>Analyse dermatologique</li>

                </ul>
                
            </div> 

        <footer class="a_propos">
            <div class="content">
                <h1>A propos du labo</h1>
                <p><strong>Adresse:</strong> 930 Rte des Colles, 06410 Biot</p>
                <p>Si vous avez des difficult&eacutes &agrave trouver votre pointeur de souris, cliquez <a href="confirm.php?confirm=pointer">ici</a></p>
                <p><strong>Tel:</strong> <a href="tel:0512217297">0512217297</a> </p>
                <p><strong>Mail:</strong> <a href="mailto:support@chabotomarty.fr">support@chabotomarty.fr</a></p>
                <p><strong>Horaires d'ouverture:</strong> Du lundi au samedi de 8h-12h30 et 14h-17h30 </p>
            </div>
        </footer>
    </body>
</html>