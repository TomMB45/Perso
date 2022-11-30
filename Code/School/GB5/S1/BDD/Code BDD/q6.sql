
-- rm the data 
DELETE FROM peut_transporter; 
DELETE FROM achemine;
-- DELETE FROM entre;
DELETE FROM sensible_volontairement;
DELETE FROM sensible_involontairement;
DELETE FROM Trajet;
DELETE FROM Parasite;
DELETE FROM Vegetal;
DELETE FROM Pays;

-- Fill the data in the table

-- SQL query to get the result
-- En supposant que la periode_quarantaine puisse imposer une période de quarantaine, quels sont les pays qui seraient protéger par une telle mesure en une seule étape ? 
INSERT INTO Vegetal (nom_vegetal, survie) VALUES ('trefle', 10); -- espece envahissante testée
INSERT INTO Vegetal (nom_vegetal, survie) VALUES ('pissenlit', 10); -- espece envahissante testée

INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('France', 0);
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Espagne', 30);
INSERT INTO Trajet (id_trajet, nombre_etapes,duree,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (1, 1, 5 , 'avion', NULL, NULL, 'France', 'Espagne');
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('Espagne', 'trefle', 1, 0);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (1, 'trefle');

-- 
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Grece', 0);
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Portugal', 100);
INSERT INTO Trajet (id_trajet, nombre_etapes,duree,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (2, 1, 5 , 'avion', NULL, NULL, 'Grece', 'Portugal');
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('Portugal', 'pissenlit', 1, 0);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (2, 'pissenlit');

-- Le delete est bien récursif => il supprime aussi la ligne (1, 'trefle') dans achemine car le trajet d'identifiant 1 a été supprimé
DELETE FROM Trajet WHERE nom_pays_depart = 'France' AND nom_pays_arrivee = 'Espagne';

INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (1, 1, 5 , 'avion', NULL, NULL, 'France', 'Espagne');
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (1, 'trefle');
