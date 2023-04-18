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
-- Transport de France -> Espagne de trefles envahissant pour l'Espagne en 1 étape
INSERT INTO Vegetal (nom_vegetal, duree_survie_v) VALUES ('trefle', 7); -- espece envahissante testée

INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('France', 0);
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Espagne', 0);
INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (1, 1, 5 , 'avion', NULL, NULL, 'France', 'Espagne');
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('Espagne', 'trefle', 1, 0);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (1, 'trefle');

INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Grece', 0);
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Portugal', 0);
INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (2, 1, 5 , 'avion', NULL, NULL, 'Grece', 'Portugal');
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('Portugal', 'trefle', 1, 0);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (2, 'trefle');


-- SQL query to get the result
-- Test Pays pas encore touche (historique = 0) mais qui pourrait l'etre en une seule étape 
SELECT DISTINCT nom_pays_arrivee AS `Pays pouvant être envahis`FROM Trajet WHERE(
    nombre_etapes = 1 AND 
    nom_pays_arrivee IN (
            (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'trefle' AND caractere_envahissant = 1 AND historique = 0) 
            UNION 
            (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = "trefle" AND caractere_envahissant = 1 AND historique = 0)
            )
    AND 
    id_trajet IN (
        SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal 
        LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE 
        (
            (vegetal.nom_vegetal = 'trefle' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
            OR 
            (Parasite.nom_parasite = "trefle" AND 
            (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
        )
    ) 
);
-- Result : 
    -- Espagne
    -- Portugal

-- Test négatifs 
    -- Pays déjà touché par la plante envahissante
UPDATE sensible_volontairement SET historique = 1 WHERE (nom_pays = 'Espagne');
SELECT nom_pays_arrivee AS `Pays pouvant être envahis`FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    nom_pays_arrivee IN (
            (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'trefle' AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            UNION 
            (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = "trefle" AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            )
    AND 
    id_trajet IN (
        SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE 
        (
            (vegetal.nom_vegetal = 'trefle' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
            OR 
            (Parasite.nom_parasite = "trefle" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
        )
    ) -- Check si le trajet achemine le trefle
);

    -- Pays pas sensible à la plante envahissante
UPDATE sensible_volontairement SET historique = 0,caractere_envahissant=0 WHERE (nom_pays = 'Espagne');
SELECT nom_pays_arrivee AS `Pays pouvant être envahis`FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    nom_pays_arrivee IN (
            (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'trefle' AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            UNION 
            (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = "trefle" AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            )
    AND 
    id_trajet IN (
        SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE 
        (
            (vegetal.nom_vegetal = 'trefle' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
            OR 
            (Parasite.nom_parasite = "trefle" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
        )
    ) -- Check si le trajet achemine le trefle
);

    -- Transport en 0 et 2 étapes
UPDATE sensible_volontairement SET historique = 0,caractere_envahissant=1 WHERE (nom_pays = 'Espagne'); -- remise à l'état initial
UPDATE Trajet SET nombre_etapes = 0 WHERE (id_trajet = 1);
UPDATE Trajet SET nombre_etapes = 2 WHERE (id_trajet = 2);
SELECT nom_pays_arrivee AS `Pays pouvant être envahis`FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    nom_pays_arrivee IN (
            (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'trefle' AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            UNION 
            (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = "trefle" AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            )
    AND 
    id_trajet IN (
        SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE 
        (
            (vegetal.nom_vegetal = 'trefle' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
            OR 
            (Parasite.nom_parasite = "trefle" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
        )
    ) -- Check si le trajet achemine le trefle
);

    -- La plante meurt avant d'arriver
UPDATE Trajet SET nombre_etapes = 1 WHERE (id_trajet = 1); -- remise à l'état initial
UPDATE Trajet SET nombre_etapes = 1 WHERE (id_trajet = 2); -- remise à l'état initial
UPDATE Vegetal SET duree_survie_v = 1 WHERE (nom_vegetal = 'trefle');
SELECT nom_pays_arrivee AS `Pays pouvant être envahis`FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    nom_pays_arrivee IN (
            (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'trefle' AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            UNION 
            (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = "trefle" AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            )
    AND 
    id_trajet IN (
        SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE 
        (
            (vegetal.nom_vegetal = 'trefle' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
            OR 
            (Parasite.nom_parasite = "trefle" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
        )
    ) -- Check si le trajet achemine le trefle
);

-- Test parasite true 
DELETE FROM sensible_volontairement; 
INSERT INTO parasite (nom_parasite, regne, duree_survie_p) VALUES ('chien', "animal", 10);
INSERT INTO peut_transporter (nom_vegetal, nom_parasite, facteur_reduction) VALUES ('trefle', 'chien', 1);
INSERT INTO sensible_involontairement (nom_pays, nom_parasite, caractere_envahissant, historique) VALUES ('Espagne', 'chien', 1, 0);
INSERT INTO sensible_involontairement (nom_pays, nom_parasite, caractere_envahissant, historique) VALUES ('Portugal', 'chien', 1, 0);
UPDATE Vegetal SET duree_survie_v = 10 WHERE (nom_vegetal = 'trefle');
SELECT nom_pays_arrivee AS `Pays pouvant être envahis`FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    nom_pays_arrivee IN (
            (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'chien' AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            UNION 
            (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = "chien" AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            )
    AND 
    id_trajet IN (
        SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE 
        (
            (vegetal.nom_vegetal = 'chien' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
            OR 
            (Parasite.nom_parasite = "chien" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
        )
    ) -- Check si le trajet achemine le trefle
);

-- Test parasite false
-- Le parsite meurt avant d'arriver
UPDATE Parasite SET duree_survie_p = 1 WHERE (nom_parasite = 'chien');
SELECT nom_pays_arrivee AS `Pays pouvant être envahis`FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    nom_pays_arrivee IN (
            (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'chien' AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            UNION 
            (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = "chien" AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            )
    AND 
    id_trajet IN (
        SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE 
        (
            (vegetal.nom_vegetal = 'chien' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
            OR 
            (Parasite.nom_parasite = "chien" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
        )
    ) -- Check si le trajet achemine le trefle
);

-- Test parasite false
-- La plante meurt avant d'arriver donc le parasite meurt aussi 
UPDATE Vegetal SET duree_survie_v = 1 WHERE (nom_vegetal = 'trefle');
SELECT nom_pays_arrivee AS `Pays pouvant être envahis`FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    nom_pays_arrivee IN (
            (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'chien' AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            UNION 
            (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = "chien" AND caractere_envahissant = 1 AND historique = 0) -- Check si le pays arrivée est sensible au trefle
            )
    AND 
    id_trajet IN (
        SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE 
        (
            (vegetal.nom_vegetal = 'chien' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
            OR 
            (Parasite.nom_parasite = "chien" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
        )
    ) -- Check si le trajet achemine le trefle
);