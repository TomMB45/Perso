-- rm the data 
DELETE FROM peut_transporte; 
DELETE FROM achemine;
-- DELETE FROM entre;
DELETE FROM sensible_volontairement;
DELETE FROM sensible_involontairement;
DELETE FROM Trajet;
DELETE FROM Parasite;
DELETE FROM Vegetal;
DELETE FROM Pays;

-- Fill the data in the table
INSERT INTO Pays (nom_pays, douane) VALUES ('France', 0);
INSERT INTO Pays (nom_pays, douane) VALUES ('Espagne', 0);

INSERT INTO Vegetal (nom_vegetal, survie) VALUES ('treffle', 7);
INSERT INTO Trajet (id_trajet, nb_etape,duree,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_d,nom_pays_a) VALUES (1, 1, 5 , 'avion', NULL, NULL, 'France', 'Espagne');
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('Espagne', 'treffle', 1, 0);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (1, 'treffle');
-- On considère que le temps est en jours


-- SQL query to get the result
-- Test d'envahissement entre espagne et france par le treffle en 1 étape (TRUE)
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nb_etape = 1 AND 
    (
        (nom_pays_d = 'Espagne' AND nom_pays_a = 'France' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) OR (
            nom_pays_d = 'France' AND nom_pays_a = 'Espagne' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporte ON Vegetal.nom_vegetal=peut_transporte.nom_vegetal LEFT JOIN Parasite ON peut_transporte.nom_parasite=Parasite.nom_parasite WHERE (
                    (Parasite.nom_parasite = NULL AND vegetal.nom_vegetal = 'treffle' AND Vegetal.survie > duree+nb_etape) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.survie > duree+nb_etape AND Vegetal.survie > duree+nb_etape+reduction_survie))
                )
            ) -- Check si le trajet achemine le treffle
        )
    )
);

-- Test négatif 
DELETE FROM Trajet; 
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nb_etape = 1 AND 
    (
        (nom_pays_d = 'Espagne' AND nom_pays_a = 'France' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) OR (
            nom_pays_d = 'France' AND nom_pays_a = 'Espagne' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporte ON Vegetal.nom_vegetal=peut_transporte.nom_vegetal LEFT JOIN Parasite ON peut_transporte.nom_parasite=Parasite.nom_parasite WHERE (
                    (Parasite.nom_parasite = NULL AND vegetal.nom_vegetal = 'treffle' AND Vegetal.survie > duree+nb_etape) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.survie > duree+nb_etape AND Vegetal.survie > duree+nb_etape+reduction_survie))
                )
            ) -- Check si le trajet achemine le treffle
        )
    )
);

-- Tes False si le végétal meurt avant l'arrivée dans le pays cible 
UPDATE Vegetal SET survie = 1 WHERE nom_vegetal = 'treffle';
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nb_etape = 1 AND 
    (
        (nom_pays_d = 'Espagne' AND nom_pays_a = 'France' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) OR (
            nom_pays_d = 'France' AND nom_pays_a = 'Espagne' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporte ON Vegetal.nom_vegetal=peut_transporte.nom_vegetal LEFT JOIN Parasite ON peut_transporte.nom_parasite=Parasite.nom_parasite WHERE (
                    (Parasite.nom_parasite = NULL AND vegetal.nom_vegetal = 'treffle' AND Vegetal.survie > duree+nb_etape) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.survie > duree+nb_etape AND Vegetal.survie > duree+nb_etape+reduction_survie))
                )
            ) -- Check si le trajet achemine le treffle
        )
    )
);

-- Test false si le pays d'arrivé n'est pas sensible au végétal (aavec caractere_envahissant = 0)
UPDATE sensible_volontairement SET caractere_envahissant = 0 WHERE nom_pays = 'Espagne';
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nb_etape = 1 AND 
    (
        (nom_pays_d = 'Espagne' AND nom_pays_a = 'France' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) OR (
            nom_pays_d = 'France' AND nom_pays_a = 'Espagne' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporte ON Vegetal.nom_vegetal=peut_transporte.nom_vegetal LEFT JOIN Parasite ON peut_transporte.nom_parasite=Parasite.nom_parasite WHERE (
                    (Parasite.nom_parasite = NULL AND vegetal.nom_vegetal = 'treffle' AND Vegetal.survie > duree+nb_etape) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.survie > duree+nb_etape AND Vegetal.survie > duree+nb_etape+reduction_survie))
                )
            ) -- Check si le trajet achemine le treffle
        )
    )
);



-- Test false si le pays d'arrivé n'est pas dans la table sensible_volontairement
INSERT INTO Pays (nom_pays, douane) VALUES ('Allemagne', 0);
INSERT INTO Trajet (id_trajet, nb_etape,duree,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_d,nom_pays_a) VALUES (2, 1, 5 , 'avion', NULL, NULL, 'Espagne', 'Allemagne');
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (2, 'treffle');
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nb_etape = 1 AND 
    (
        (nom_pays_d = 'Espagne' AND nom_pays_a = 'France' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) OR (
            nom_pays_d = 'France' AND nom_pays_a = 'Espagne' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporte ON Vegetal.nom_vegetal=peut_transporte.nom_vegetal LEFT JOIN Parasite ON peut_transporte.nom_parasite=Parasite.nom_parasite WHERE (
                    (Parasite.nom_parasite = NULL AND vegetal.nom_vegetal = 'treffle' AND Vegetal.survie > duree+nb_etape) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.survie > duree+nb_etape AND Vegetal.survie > duree+nb_etape+reduction_survie))
                )
            ) -- Check si le trajet achemine le treffle
        )
    )
);


DELETE FROM peut_transporte; 
DELETE FROM achemine;
-- DELETE FROM entre;
DELETE FROM sensible_volontairement;
DELETE FROM sensible_involontairement;
DELETE FROM Trajet;
DELETE FROM Parasite;
DELETE FROM Vegetal;
DELETE FROM Pays;

-- Fill the data in the table
INSERT INTO Pays (nom_pays, douane) VALUES ('France', 0);
INSERT INTO Pays (nom_pays, douane) VALUES ('Espagne', 0);
INSERT INTO Vegetal (nom_vegetal, survie) VALUES ('treffle', 7);
INSERT INTO Parasite (nom_parasite, regne, survie) VALUES ('chien', "animal", 6);

INSERT INTO Trajet (id_trajet, nb_etape,duree,moyen_transport_1,moyen_transport_2,moyen_transport_3,nom_pays_d,nom_pays_a) VALUES (1, 1, 4 , 'avion', NULL, NULL, 'France', 'Espagne');
INSERT INTO sensible_involontairement (nom_pays, nom_parasite,caractere_envahissant,historique) VALUES ('Espagne', 'chien', 1, 0);
INSERT INTO peut_transporte (nom_vegetal, nom_parasite, reduction_survie) VALUES ('treffle', 'chien', 1);
INSERT INTO achemine (id_trajet, nom_vegetal) VALUES (1, 'treffle');

-- Test True Le pays d'arrivée est sensible au parasite chien en 1 étape et le trajet achemine par le treffle qui survie 
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nb_etape = 1 AND 
    (
        (nom_pays_d = 'Espagne' AND nom_pays_a = 'France' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) OR (
            nom_pays_d = 'France' AND nom_pays_a = 'Espagne' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporte ON Vegetal.nom_vegetal=peut_transporte.nom_vegetal LEFT JOIN Parasite ON peut_transporte.nom_parasite=Parasite.nom_parasite WHERE (
                    (Parasite.nom_parasite = NULL AND vegetal.nom_vegetal = 'treffle' AND Vegetal.survie > duree+nb_etape) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.survie > duree+nb_etape AND Vegetal.survie > duree+nb_etape+reduction_survie))
                )
            ) -- Check si le trajet achemine le treffle
        )
    )
);

-- Resultat : TRUE

-- Test False le pasite meurt avant l'arrivée du trajet
UPDATE Parasite SET survie = 1 WHERE nom_parasite = 'chien';
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nb_etape = 1 AND 
    (
        (nom_pays_d = 'Espagne' AND nom_pays_a = 'France' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) OR (
            nom_pays_d = 'France' AND nom_pays_a = 'Espagne' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporte ON Vegetal.nom_vegetal=peut_transporte.nom_vegetal LEFT JOIN Parasite ON peut_transporte.nom_parasite=Parasite.nom_parasite WHERE (
                    (Parasite.nom_parasite = NULL AND vegetal.nom_vegetal = 'treffle' AND Vegetal.survie > duree+nb_etape) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.survie > duree+nb_etape AND Vegetal.survie > duree+nb_etape+reduction_survie))
                )
            ) -- Check si le trajet achemine le treffle
        )
    )
);
-- Resultat : FALSE

-- Test False la plante meurt avant l'arrivée du trajet
UPDATE Parasite SET survie = 5 WHERE nom_parasite = 'chien';
UPDATE Vegetal SET survie = 1 WHERE nom_vegetal = 'treffle';

SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nb_etape = 1 AND 
    (
        (nom_pays_d = 'Espagne' AND nom_pays_a = 'France' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) OR (
            nom_pays_d = 'France' AND nom_pays_a = 'Espagne' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporte ON Vegetal.nom_vegetal=peut_transporte.nom_vegetal LEFT JOIN Parasite ON peut_transporte.nom_parasite=Parasite.nom_parasite WHERE (
                    (Parasite.nom_parasite = NULL AND vegetal.nom_vegetal = 'treffle' AND Vegetal.survie > duree+nb_etape) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.survie > duree+nb_etape AND Vegetal.survie > duree+nb_etape+reduction_survie))
                )
            ) -- Check si le trajet achemine le treffle
        )
    )
);
-- Resultat : FALSE

-- Test False le parasite tue la plante durant le trajet 
UPDATE Parasite SET survie = 5 WHERE nom_parasite = 'chien';
UPDATE Vegetal SET survie = 7 WHERE nom_vegetal = 'treffle';
UPDATE peut_transporte SET reduction_survie = 10 WHERE nom_parasite = 'chien';

SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Trajet WHERE(
    -- Activité d'import export entre deux pays d'une plante envahissante
    nb_etape = 1 AND 
    (
        (nom_pays_d = 'Espagne' AND nom_pays_a = 'France' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'France' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'France' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) OR (
            nom_pays_d = 'France' AND nom_pays_a = 'Espagne' AND (
            nom_pays_a = (SELECT nom_pays FROM sensible_volontairement WHERE nom_pays = 'Espagne' AND nom_vegetal = 'treffle' AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            OR 
            nom_pays_a = (SELECT nom_pays FROM sensible_involontairement  WHERE nom_pays = 'Espagne' AND nom_parasite = "chien" AND caractere_envahissant = 1) -- Check si le pays arrivée est sensible au treffle
            )
        ) AND (
            id_trajet IN (
                SELECT id_trajet FROM achemine NATURAL JOIN Vegetal LEFT JOIN peut_transporte ON Vegetal.nom_vegetal=peut_transporte.nom_vegetal LEFT JOIN Parasite ON peut_transporte.nom_parasite=Parasite.nom_parasite WHERE (
                    (Parasite.nom_parasite = NULL AND vegetal.nom_vegetal = 'treffle' AND Vegetal.survie > duree+nb_etape) 
                    OR 
                    (Parasite.nom_parasite = "chien" AND (Parasite.survie > duree+nb_etape AND Vegetal.survie > duree+nb_etape+reduction_survie))
                )
            ) -- Check si le trajet achemine le treffle
        )
    )
);
-- Resultat : FALSE