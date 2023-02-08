<?php
if(!isset($_SESSION)){session_start();}

echo "
<div class='navbar'>
"; 

    if (isset($_SESSION['role'])){
        // Si le role est est set 
        switch (true){
            // On affiche le menu en fonction du role
            case ($_SESSION["role"] == "CV" or $_SESSION["role"] == "SU") : {
                // Si le role est client vérifié ou super user on affiche les menus suivants 
                echo "
                <div>
                    <button>Nos services</button>
                    <div>
                        <a href='services.php'>Pr&eacute;sentation des services</a>
                        <a href='info_s.php?s=covid'>Test covid</a>
                        <a href='info_s.php?s=vih'>Test vih</a>
                        <a href='#'>etc</a>
                    </div>
                </div>

                <div>
                    <button>Vos rendez-vous</button>
                    <div>
                        <a href='calendar.php'>Prendre un rendez-vous</a>
                        <a href='rdv.php?q=modif'>Modifier un rendez-vous</a>
                        <a href='rdv.php?q=rm'>Supprimer un rendez-vous</a>
                        <a href='rdv.php?q=info&state=curr'>Rendez-vous en cours</a>
                        <a href='rdv.php?q=info&state=past'>Rendez-vous pass&eacutes</a>
                    </div>
                </div>

                <div>
                    <button>Vos r&eacutesultats</button>
                    <div>
                        <a href='result.php?s=Dermatologie'>Consulter vos r&eacutesultats</a>
                        <a href='talk.php'>Demander conseil a propos d'un r&eacutesultats</a>
                    </div>
                </div>";
                if ($_SESSION['role'] != "SU"){
                    // Si le role n'est pas super user on arrete l'affichage du menu
                    // Cela permet de continuer a afficher le menu pour le role "SU"
                    break;
                }
            }
            
            case ($_SESSION['role'] == 'CNV' or $_SESSION['role'] == 'SU') : {
                // Si le role est client non vérifié ou super user on affiche les menus suivants
                echo "
                <div>
                    <button>Nos services</button>
                    <div>
                        <a href='services.php'>Pr&eacute;sentation des services</a>
                        <a href='info_s.php?s=covid'>Test covid</a>
                        <a href='info_s.php?s=vih'>Test vih</a>
                        <a href='#'>etc</a>
                    </div>
                </div>
                
                <div>
                    <button>Vos rendez-vous</button>
                    <div>
                        <a href='calendar.php'>Prendre un rendez-vous</a>
                        <a href='rdv.php?q=modif'>Modifier un rendez-vous</a>
                        <a href='rdv.php?q=rm'>Supprimer un rendez-vous</a>
                        <a href='rdv.php?q=info&state=curr'>Rendez-vous en cours</a>
                    </div>
                </div>";
                if ($_SESSION['role'] != "SU"){
                    // Si le role n'est pas super user on arrete l'affichage du menu
                    // Cela permet de continuer a afficher le menu pour le role "SU"
                    break;
                }
            }


            case ($_SESSION["role"] == "SEC" or $_SESSION["role"] == "SU") : {
                // Si le role est secrétaire ou super user on affiche les menus suivants
                echo "
                <div>
                    <button>Gestion des comptes client</button>
                    <div>
                        <a href='calendar.php'>Prendre un rendez-vous client</a>
                        <a href='rdv.php?q=modif'>Modifier un rendez-vous client</a>
                        <a href='rdv.php?q=rm'>Supprimer un rendez-vous client</a>
                        <a href='rdv.php?q=info&state=curr'>Voir les rendez-vous du client</a>
                    </div>
                </div>

                <div>
                    <button>Informations client</button>
                    <div>
                        <a href='../admin/secretaire/verif_client.php'>V&eacuterifier les informations d'un client</a>
                        <a href='../admin/secretaire/info.php'>Modifier les informations d'un client</a>
                    </div>
                </div>";
                if ($_SESSION['role'] != "SU"){
                    // Si le role n'est pas super user on arrete l'affichage du menu
                    // Cela permet de continuer a afficher le menu pour le role "SU"
                    break;
                }
            }

            case ($_SESSION["role"] == "SEV" or $_SESSION["role"] == "SU") : {
                // Si le role est service ou super user on affiche les menus suivants
                echo "
                <div>
                    <button>Ajouter des r&eacutesultats</button>
                    <div>
                        <a href='../admin/service/result.php?action=add'>Ajouter un r&eacutesultat</a>
                        <a href='../admin/service/result.php?action=rm'>Supprimer un r&eacutesultat</a>
                    </div>
                </div>";
                if ($_SESSION['role'] != "SU"){
                    // Si le role n'est pas super user on arrete l'affichage du menu
                    // Cela permet de continuer a afficher le menu pour le role "SU"
                    break;
                }
            }

            case ($_SESSION["role"] == "AH" or $_SESSION["role"] == "SU") : {
                // Si le role est administrateur hospitalier ou super user on affiche les menus suivants
                echo "
                <div>
                    <button>Gestion des comptes secr&eacutetaire</button>
                    <div>
                        <a href='../admin/admin/account_part.php?&t=SEC'>Ajouter une/une secr&eacutetaire</a>
                        <a href='../admin/admin/rm_account.php?&t=SEC'>Supprimer une/une secr&eacutetaire</a>
                    </div>
                </div>

                <div>
                    <button>Gestion des comptes services</button>
                    <div>
                        <a href='../admin/admin/account_part.php?&t=SEV'>Ajouter un compte service</a>
                        <a href='../admin/admin/rm_account.php?&t=SEV'>Supprimer un compte service</a>
                    </div>
                </div>";
                if ($_SESSION['role'] != "SU"){
                    // Si le role n'est pas super user on arrete l'affichage du menu
                    // Cela permet de continuer a afficher le menu pour le role "SU"
                    break;
                }
            }
            case ($_SESSION["role"] == "SU") : {
                // Si le role est super user on affiche les menus suivants
                echo " 
                <div>
                    <button>Gestion des comptes administrateur hospitalier</button>
                    <div>
                        <a href='../admin/su.php?action=add'>Ajouter un compte administrateur hospitalier</a>
                        <a href='../admin/su.php?action=rm'>Supprimer un compte administrateur hospitalier</a>
                    </div>
                </div>";
                break; 
            }
        }
    } else {
        // Si l'utilisateur n'est pas connecté on affiche les menus suivants
        echo "
        <div>
            <button>Nos services</button>
            <div>
                <a href='services.php'>Pr&eacute;sentation des services</a>
                <a href='info_s.php?s=covid'>Test covid</a>
                <a href='info_s.php?s=vih'>Test vih</a>
                <a href='#'>etc</a>
            </div>
        </div>"; 
    }

    ?>
</div>
