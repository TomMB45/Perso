# Pages infos 
- [x] Afficher les infos précédentes du client dans le form en légende : fait mais manque adress et phone (23/11/2022)
- [x] Créer une unique page d'accueil
- [x] Créer une page de login
- [x] Créer une page de création de compte
- [x] Permettre de changer les infos du compte (adresse mail, mot de passe, etc.)
- [x] Permettre de supprimer le compte
- [x] Permettre de se déconnecter
- [x] Afficher un menu de navigation personnalité en fonction du role de l'utilisateur 
- [x] Créer une page de présentation des services et prise rdv
    - [ ] Ajouter le carousel
- [x] Créer un tableau des horaires d'ouvertures (8-12h30/14H-17h30 du lundi au samedi)
 
# Connection 
- [x] mdp oublié (23/11/2022)
    - [x] Mailer (22/11/2022)

# Client non vérifié
- [x] Afficher un message qui dit que le client n'est pas vérifié ainsi que les modalités de vérifications
- [x] Ne permettre la prise que d'un seul rdv 

# Client vérifié
- [x] Prendre un/des rdv 
- [x] Annuler un/des rdv
- [x] Modifier un/des rdv
- [x] Afficher les infos du client dans le form en légende
- [x] Accès aux résultats 
- [x] Echanger avec un professionnel (chat) (23/11/2022)

# Secrétaire
- [x] Prendre rdv pour un client
- [x] valider un client (vérification de l'identité) (23/11/2022) (pas testé par chab)
- [x] Annuler un/des rdv
- [x] Modifier infos personnelles (23/11/2022) (testé par tommy)
- [x] Gérer le cas ou aucun utilisiteur n'est sélectionné

# Service 
- [mails] Accès tchat => pas besoin c'est ses mails  
- [x] upload des résultats (23/11/2022) html 
- [x] upload des résultats (23/11/2022) serveur
- [x] Requete du dernier rdv d'un client
- [x] modifier des résultats 
- [ ] Gérer qui a pris le rdv 

# Admin hospitalier
- [x] Créer des comptes aux droits particuliers
- [x] supprimer des comptes aux droits particuliers
- [x] Page pour voir tous les comptes services et secrétaire

# SU 
- [github] Accès a tout le code 
- [ ] Créer un/des compte(s) admin hospitalier (peut-être une page à part si jamais le temps)

# Paramètres
- [x] Fusionner les _form et les _modify
- [x] mdp oublié
    - [x] checker le role du mail (on veut pas d'un mdp secrétaire oublié)
- [x] Compléter toutes les confirmations sur la page confirm.php

# Calendar 
- [x] griser les jours du Seigneur
- [x] griser les jours qui ne peuvent pas être sélectionnés car complets pour ce service (23/11/2022)
- [x] Merge calendar avec select_serviceS
- [x] Changement de mois possible (23/11/2022)
- [x] Prise de rdv infinie quand refresh à fix (23/11/2022)
- [x] Faire un check if le client est vérifier ou non vérifier exclusif 
- [x] Envoyer un mail la veille d'un rendez-vous (à un SU)
- [x] Envoyer un mail à la prise d'un rdv
- [ ] Lier employé du srevice et rdv (checker si l'emplyé esy dispo)

# Formulaire de communication
- [x] Créer un formulaire
- [x] Envoyer depuis user vers service par mail

# Sécurité
- [ ] Checker les champs (regex)
- [x] Modifier le système de hash des mdp (current : md5)
- [ ] Encoder les données sensibles (mail, mdp, etc.)
- [x] Empêcher les injections SQL
- [ ] Empêcher les injections XSS
- [x] Empêcher les injections CSRF
- [ ] Empêcher les injections de fichiers
- [ ] Empêcher les injections de commandes
- [ ] Empêcher les injections de requêtes HTTP
- [ ] Sécuriser les pages du site non accessibles et vérifier les droits de l'utilisateur selon son rôle

# Pour Marty
- [x] Récupérer la date du dernier rdv d'un client en fonction d'un service
- [x] Récupérer liste des rdvs qui n'ont pas encore eu lieu
- [x] Supprime dans la table rdv les rdvs de plus d'un mois
- [ ] query to get all rdv for this user in function of state => info needed output : start_time, service, id_appointment
- [ ] query to get results for this service for this user
- [x] Ajout du CSS pour les résultats 
- [x] Ajout du CSS pour le formulaire de communication
- [x] Ajout du CSS pour le formulaire de prise de rdv
- [x] Ajout du CSS pour le formulaire de modification de rdv
- [x] Ajout du CSS pour le formulaire de suppression de rdv
- [x] Ajout du CSS pour le formulaire de création de compte
- [x] Ajout du CSS pour le formulaire de modification de compte
- [x] Ajout du CSS pour le formulaire de connexion
- [x] Ajout du CSS pour le formulaire de mot de passe oublié
- [x] Ajout du CSS pour le formulaire de vérification de compte
- [x] Ajout du CSS pour le formulaire de création de compte service
- [x] Ajout du CSS pour le formulaire de suppression de compte service
- [x] Ajout du CSS pour le formulaire de création de compte secrétaire
- [x] Ajout du CSS pour le formulaire de suppression de compte secrétaire
- [x] Ajout du CSS pour le formulaire de création de compte user
- [x] Ajout du CSS pour la page d'info 
- [x] Ajout du CSS pour la page de confirmation


# BDD
- [X] Vérifier qu'on utilise tous les champs
- [X] Vérifier les on delete et on update cascade
- [X] Supprimer les rdv de plus de 3 mois
- [X] Supprimer les comptes CNV de plus de 3 mois
- [X] Supprimer l'id Service (+ primary key user_belongs_service) 

# Verification 
## Admin hospitalier 
- [x] Créer des comptes secrétaires 
- [x] Créer des comptes services
- [x] Supprimer des comptes services
- [x] Supprimer des comptes secrétaires

## Client vérifié
- [x] Prendre un rdv pour un client vérifié
    - [x] Choisir un service
    - [x] Calendrier
    - [x] Heures 
- [x] Modifier un rdv pour un client vérifié
- [x] Afficher les résultats d'un client vérifié
- [x] Télécharger les résultats pour un client vérifié
- [x] Demande de tchat => should be debugged
- [x] Accès aux informations personnelles et possibilité de les modifier

## Client non vérifier 
- [x] Prendre un rdv pour un client non vérifié
- [x] Modifier un rdv pour un client non vérifié

## Secrétaire
- [x] Prise de rdv par une secrétaire pour un client 
- [x] Suppression de rdv par une secrétaire pour un client
- [x] Modification de rdv par une secrétaire pour un client
- [x] Vérifier les infos d'un client non vérifier par une secrétaire
- [x] Modifier les infos d'un client par une secrétaire

## Service
- [x] Ajouter un résultat par un service
- [x] supprimer un résultat par un service


# Easter egg
- [x] Sur une mauvaise redirection ajouter un gif de villebrequin avec le CPT 
- [x] France connect 
- [x] redirection étrange => https://theuselessweb.com/ or https://pointerpointer.com/
- [ ] CAPCHA coupe histo pour créer un compte service histo
- [ ] Thème jap pour Mr Bernot => japanese font
- [ ] Checker les injections sql => redirection vers une page "bien essayer !" 
- [ ] Fausses pubs
- [ ] Recommendations défilantes sur le carousel avec les avis des profs et leur photo
 
# A penser a changer 
- [ ] SU par défaut dans la connection (/connect/account.php)


# A Faire ce soir, A trier après 

- [x] Secrétaire ne doit pas pouvoir prendre de rdv elle même
- [x] Clients vérifies non vérifiés, CF plus haut
- [x] Rajouter l'email user selcted pour les résultats
- [x] Renvoyer sur la page confirm
- [x] Sécu à vérifier / compléter
- [x] Check du type de fichier pour les résultats
- [x] Mail 
- [x] Permissions des pages

- [x] Check de la TODO
- [x] Corriger les inputs de la secrétaire quand elle se sélectionne elle même 
- [x] Admin Hospitalier, ajouter le SEV dans la table user_belongs_service

# Tommy 10/12/2022
- [x] Cron state 
- [x] rm state from sql 
- [x] update css 
- [x] cron CNV 
- [x] add users
- [x] some typos and é => `&eacute;` etc 
- [x] some bug fix 
- [x] nb_slot cron 
- [x] add title for all pages
- [x] update menu 
- [x] add check of extension for results files 