DELETE FROM peut_transporter; 
DELETE FROM achemine;
DELETE FROM sensible_volontairement;
DELETE FROM sensible_involontairement;
DELETE FROM Trajet;
DELETE FROM Parasite;
DELETE FROM Vegetal;
DELETE FROM Pays;

-- Fill the data in the table
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('France', 0); 

INSERT INTO Vegetal (nom_vegetal, duree_survie_v) VALUES ('trefle', 0);

INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('France', 'trefle', 1, 0);

-- SQL query to get the result
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE (
    nom_pays = 'France' 
    AND 
        (
            nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'trefle' AND caractere_envahissant = 1)
            OR 
            nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = 'trefle' AND caractere_envahissant = 1)
        )
);


-- rm the data 
DELETE FROM peut_transporter; 
DELETE FROM achemine;
DELETE FROM sensible_volontairement;
DELETE FROM sensible_involontairement;
DELETE FROM Trajet;
DELETE FROM Parasite;
DELETE FROM Vegetal;
DELETE FROM Pays;

-- Fill the data in the table
INSERT INTO Vegetal (nom_vegetal, duree_survie_v) VALUES ('trefle', 10);

INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('France', 0);
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Espagne', 0);
INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (1, 1, 5 , 'avion', NULL, NULL, 'France', 'Espagne');
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('Espagne', 'trefle', 1, 0);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (1, 'trefle');

INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Grece', 0);
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Portugal', 100);
INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (2, 1, 5 , 'avion', NULL, NULL, 'Grece', 'Portugal');
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('Portugal', 'trefle', 1, 0);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (2, 'trefle');

-- SQL query to get the result
SELECT DISTINCT nom_pays_arrivee AS `Pays protégés` FROM Trajet JOIN pays ON trajet.nom_pays_arrivee=pays.nom_pays WHERE(
    nombre_etapes = 1 AND
    nom_pays_arrivee IN (
        (SELECT nom_pays FROM sensible_volontairement WHERE caractere_envahissant = 1) 
        UNION 
        (SELECT nom_pays FROM sensible_involontairement WHERE caractere_envahissant = 1)
    ) AND 
    id_trajet IN (
        SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal 
        LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE 
        (
            (Vegetal.duree_survie_v < duree_trajet_sans_etape+(periode_quarantaine/100*duree_trajet_sans_etape)+nombre_etapes) 
            OR 
            (
                Parasite.duree_survie_p < duree_trajet_sans_etape+(periode_quarantaine/100*duree_trajet_sans_etape)+nombre_etapes
                AND Vegetal.duree_survie_v < duree_trajet_sans_etape+(periode_quarantaine/100*duree_trajet_sans_etape)+nombre_etapes+facteur_reduction
            )
        )
    )
);