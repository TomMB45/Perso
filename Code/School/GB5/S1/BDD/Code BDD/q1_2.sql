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
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('France', 0); 
INSERT INTO Pays (nom_pays, periode_quarantaine) VALUES ('Espagne', 0);

INSERT INTO Vegetal (nom_vegetal, duree_survie_v) VALUES ('trefle', 0); -- duree_survie_v -> 10 bcse 0 not logical even if duree_survie_v not used
INSERT INTO Vegetal (nom_vegetal, duree_survie_v) VALUES ('pissenlit', 0);

INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('France', 'trefle', 1, 1);
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('France', 'pissenlit', 1, 0);

-- SQL query to get the result
-- Ici on test si le trefle à un caractère envahissant pour la france et qu'il est présent dans historique
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE (
    nom_pays = 'France' 
    AND 
        (
            nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'trefle' AND caractere_envahissant = 1 AND historique = 1) 
            OR 
            nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = 'trefle' AND caractere_envahissant = 1 AND historique = 1) 
        ) 
);
-- Return TRUE

-- Ici on test si le pissenlit à un caractère envahissant pour la france et qu'il est présent dans historique
-- Or il n'est pas présent dans historique donc on doit avoir FALSE
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE (
    nom_pays = 'France' -- On ne prend que le pays d'intérets
    AND 
        (
            nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'pissenlit' AND caractere_envahissant = 1 AND historique = 1) -- Si une plante est envhissante 
            OR 
            nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = 'pissenlit' AND caractere_envahissant = 1 AND historique = 1) -- Si on cherche un parasite
        ) -- Si on cherche un parasite
);
-- Return FALSE

-- Test avec le parasite
DELETE FROM sensible_volontairement;

INSERT INTO parasite(nom_parasite,regne,duree_survie_p) VALUES ('chien', "animal", 1);
INSERT INTO sensible_involontairement (nom_pays, nom_parasite,caractere_envahissant,historique) VALUES ('France', 'chien', 1, 1);

SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE (
    nom_pays = 'France' 
    AND 
        (
            nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'chien' AND caractere_envahissant = 1 AND historique = 1) 
            OR 
            nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = 'chien' AND caractere_envahissant = 1 AND historique = 1) 
        )
);
-- Return TRUE car le chien est envahissant pour la france et présent dans historique 

UPDATE sensible_involontairement SET historique = 0 WHERE nom_pays = 'France'; -- On met historique à 0 pour le chien
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE (
    nom_pays = 'France' -- On ne prend que le pays d'intérets
    AND 
        (
            nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'chien' AND caractere_envahissant = 1 AND historique = 1) -- Si une plante est envhissante 
            OR 
            nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = 'chien' AND caractere_envahissant = 1 AND historique = 1) -- Si on cherche un parasite
        ) -- Si on cherche un parasite
);
-- Return FALSE car le chien est envahissant pour la france mais n'est pas présent dans historique
