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
INSERT INTO Vegetal (nom_vegetal, duree_survie_v) VALUES ('trefle', 10); -- espece envahissante testée

INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('France', 0);
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Espagne', 30);
INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (1, 1, 5 , 'avion', NULL, NULL, 'France', 'Espagne');
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('Espagne', 'trefle', 1, 0);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (1, 'trefle');

-- 
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Grece', 0);
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Portugal', 100);
INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (2, 1, 5 , 'avion', NULL, NULL, 'Grece', 'Portugal');
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('Portugal', 'trefle', 1, 0);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (2, 'trefle');

-- SQL query to get the result
-- Pays qui seraient protégés des importations en une étape par la mise en place d'une periode_quarantaine aux frontières

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

-- Result
    -- Portugal 

-- test si le pays n'applique plus la periode_quarantaine  
UPDATE Pays SET periode_quarantaine = 0 WHERE nom_pays = 'Portugal';
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
-- Result
    -- NULL

-- test pour deux pays sensibles
UPDATE Pays SET periode_quarantaine = 100 WHERE nom_pays = 'Portugal';
UPDATE Pays SET periode_quarantaine = 100 WHERE nom_pays = 'Espagne';
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
-- Result
    -- Espagne
    -- Portugal
    -- Car les pays ont mis en place une periode_quarantaine sufficante 

-- test pour un parasite 
DELETE FROM sensible_volontairement WHERE nom_pays = 'Espagne'; 
UPDATE Vegetal SET duree_survie_v = 20 WHERE nom_vegetal = 'trefle';
INSERT INTO Parasite (nom_parasite, regne, duree_survie_p) VALUES ('chien', "animal",20);
INSERT INTO sensible_involontairement (nom_pays, nom_parasite, caractere_envahissant,historique) VALUES ('Espagne', 'chien', 1,0);
INSERT INTO peut_transporter (nom_vegetal, nom_parasite,facteur_reduction) VALUES ('trefle', 'chien',0);

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
-- Ici les valeurs n'ont pas de sens duree_survie_v ou duree_survie_p aurait pu être set à 4,5,6,7,8,9,10,11 par exemple. 
-- En effet, tant que la durée de survie du parasite et du végétal est inférieur à 12 strictement on renvoie : Espagne, Portugal. 
-- Car le Portugal est sensible au trèfle qui peut meurt lors du trajt et l'Espagne est sensible au chien qui meurt aussi
-- dans le trajet que ça soit du 
-- à sa durée de survie propre ou à la durée de survie de végétal

-- Result
    -- Espagne
    -- Portugal
    -- Car la survie de la plante est trop faible 