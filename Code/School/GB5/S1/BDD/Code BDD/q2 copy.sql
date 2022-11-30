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
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('France', 0);
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Espagne', 0);

INSERT INTO Vegetal (nom_vegetal, duree_survie_v) VALUES ('trefle', 7);
INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (1, 1, 5 , 'avion', NULL, NULL, 'France', 'Espagne');
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('Espagne', 'trefle', 1, 0);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (1, 'trefle');
-- On considère que le temps est en jours


-- SQL query to get the result
-- Test d'envahissement entre espagne et france par le trefle en 1 étape (TRUE)
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    nombre_etapes = 1 AND 
    (
        (nom_pays_depart = 'Espagne' AND nom_pays_arrivee = 'France' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'trefle' AND caractere_envahissant = 1) 
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "trefle" AND caractere_envahissant = 1) 
            )
        ) OR (
            nom_pays_depart = 'France' AND nom_pays_arrivee = 'Espagne' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'trefle' AND caractere_envahissant = 1) 
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "trefle" AND caractere_envahissant = 1) 
            )
        )
    ) AND (
        id_trajet IN (
            SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal 
            LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE (
                (Vegetal.nom_vegetal = 'trefle' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                OR 
                (
                    Parasite.nom_parasite = "trefle" AND 
                    (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction)
                )
            )
        ) 
    )
);

-- Test négatif 
DELETE FROM Trajet; 
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    (
        (nom_pays_depart = 'Espagne' AND nom_pays_arrivee = 'France' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'trefle' AND caractere_envahissant = 1) 
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "trefle" AND caractere_envahissant = 1) 
            )
        ) OR (
            nom_pays_depart = 'France' AND nom_pays_arrivee = 'Espagne' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'trefle' AND caractere_envahissant = 1) 
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "trefle" AND caractere_envahissant = 1) 
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE (
                    (vegetal.nom_vegetal = 'trefle' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                    OR 
                    (Parasite.nom_parasite = "trefle" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
                )
            ) -- Check si le trajet achemine le trefle
        )
    )
);

-- Tes False si le végétal meurt avant l'arrivée dans le pays cible 
INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (1, 1, 5 , 'avion', NULL, NULL, 'France', 'Espagne');
UPDATE Vegetal SET duree_survie_v = 1 WHERE nom_vegetal = 'trefle';
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    (
        (nom_pays_depart = 'Espagne' AND nom_pays_arrivee = 'France' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'trefle' AND caractere_envahissant = 1) 
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "trefle" AND caractere_envahissant = 1) 
            )
        ) OR (
            nom_pays_depart = 'France' AND nom_pays_arrivee = 'Espagne' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'trefle' AND caractere_envahissant = 1) 
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "trefle" AND caractere_envahissant = 1) 
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE (
                    (vegetal.nom_vegetal = 'trefle' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                    OR 
                    (Parasite.nom_parasite = "trefle" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
                )
            ) -- Check si le trajet achemine le trefle
        )
    )
);

-- Test false si le pays d'arrivé n'est pas sensible au végétal (aavec caractere_envahissant = 0)
UPDATE sensible_volontairement SET caractere_envahissant = 0 WHERE nom_pays = 'Espagne';
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    (
        (nom_pays_depart = 'Espagne' AND nom_pays_arrivee = 'France' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'trefle' AND caractere_envahissant = 1) 
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "trefle" AND caractere_envahissant = 1) 
            )
        ) OR (
            nom_pays_depart = 'France' AND nom_pays_arrivee = 'Espagne' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'trefle' AND caractere_envahissant = 1) 
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "trefle" AND caractere_envahissant = 1) 
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE (
                    (vegetal.nom_vegetal = 'trefle' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                    OR 
                    (Parasite.nom_parasite = "trefle" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
                )
            ) 
        )
    )
);



-- Test false si le pays d'arrivé n'est pas dans la table sensible_volontairement
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Allemagne', 0);
INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (2, 1, 5 , 'avion', NULL, NULL, 'Espagne', 'Allemagne');
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (2, 'trefle');
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    (
        (nom_pays_depart = 'Espagne' AND nom_pays_arrivee = 'France' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'trefle' AND caractere_envahissant = 1) 
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "trefle" AND caractere_envahissant = 1) 
            )
        ) OR (
            nom_pays_depart = 'France' AND nom_pays_arrivee = 'Espagne' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'trefle' AND caractere_envahissant = 1) 
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "trefle" AND caractere_envahissant = 1) 
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE (
                    (vegetal.nom_vegetal = 'trefle' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                    OR 
                    (Parasite.nom_parasite = "trefle" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
                )
            ) -- Check si le trajet achemine le trefle
        )
    )
);


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
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('France', 0);
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Espagne', 0);
INSERT INTO Vegetal (nom_vegetal, duree_survie_v) VALUES ('trefle', 7);
INSERT INTO Parasite (nom_parasite, regne, duree_survie_p) VALUES ('chien', "animal", 6);

INSERT INTO Trajet (id_trajet, nombre_etapes,duree_trajet_sans_etape,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_depart,nom_pays_arrivee) VALUES (1, 1, 4 , 'avion', NULL, NULL, 'France', 'Espagne');
INSERT INTO sensible_involontairement (nom_pays, nom_parasite,caractere_envahissant,historique) VALUES ('Espagne', 'chien', 1, 0);
INSERT INTO peut_transporter (nom_vegetal, nom_parasite, facteur_reduction) VALUES ('trefle', 'chien', 1);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (1, 'trefle');

-- Test True Le pays d'arrivée est sensible au parasite trefle en 1 étape et le trajet achemine par le trefle qui duree_survie_v 
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    (
        (nom_pays_depart = 'Espagne' AND nom_pays_arrivee = 'France' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            )
        ) OR (
            nom_pays_depart = 'France' AND nom_pays_arrivee = 'Espagne' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE (
                    (vegetal.nom_vegetal = 'chien' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
                )
            ) -- Check si le trajet achemine le chien
        )
    )
);

-- Resultat : TRUE

-- Test False Le parasite meurt avant d'arriver au pays d'arrivée
UPDATE Parasite SET duree_survie_p = 1 WHERE nom_parasite = 'chien';
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    (
        (nom_pays_depart = 'Espagne' AND nom_pays_arrivee = 'France' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            )
        ) OR (
            nom_pays_depart = 'France' AND nom_pays_arrivee = 'Espagne' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE (
                    (vegetal.nom_vegetal = 'chien' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
                )
            ) -- Check si le trajet achemine le chien
        )
    )
);

-- Test False la plante meurt avant l'arrivée du trajet
UPDATE Parasite SET duree_survie_p = 5 WHERE nom_parasite = 'chien';
UPDATE Vegetal SET duree_survie_v = 1 WHERE nom_vegetal = 'trefle';

SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    (
        (nom_pays_depart = 'Espagne' AND nom_pays_arrivee = 'France' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            )
        ) OR (
            nom_pays_depart = 'France' AND nom_pays_arrivee = 'Espagne' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE (
                    (vegetal.nom_vegetal = 'chien' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
                )
            ) -- Check si le trajet achemine le chien
        )
    )
);
-- Resultat : FALSE

-- Test False le parasite tue la plante durant le trajet 
UPDATE Parasite SET duree_survie_p = 5 WHERE nom_parasite = 'chien';
UPDATE Vegetal SET duree_survie_v = 7 WHERE nom_vegetal = 'trefle';
UPDATE peut_transporter SET facteur_reduction = 10 WHERE nom_parasite = 'chien';

SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nombre_etapes = 1 AND 
    (
        (nom_pays_depart = 'Espagne' AND nom_pays_arrivee = 'France' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            )
        ) OR (
            nom_pays_depart = 'France' AND nom_pays_arrivee = 'Espagne' AND (
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            OR 
            nom_pays_arrivee = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au chien
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporter ON Vegetal.nom_vegetal=peut_transporter.nom_vegetal LEFT JOIN Parasite ON peut_transporter.nom_parasite=Parasite.nom_parasite WHERE (
                    (vegetal.nom_vegetal = 'chien' AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.duree_survie_p >duree_trajet_sans_etape+nombre_etapes AND Vegetal.duree_survie_v >duree_trajet_sans_etape+nombre_etapes+facteur_reduction))
                )
            ) -- Check si le trajet achemine le trefle
        )
    )
);
-- Resultat : FALSE