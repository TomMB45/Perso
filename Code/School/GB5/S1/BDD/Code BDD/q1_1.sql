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

INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('France', 'trefle', 1, 0);
INSERT INTO sensible_volontairement (nom_pays, nom_vegetal,caractere_envahissant,historique) VALUES ('France', 'pissenlit', 0, 0);

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
-- Return TRUE car trefle et france sont référencés dans la table sensible volontairement et caractere envahissant = 1 

SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE (
    nom_pays = 'Espagne' -- On ne prend que le pays d'intérets
    AND 
        (
            nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'trefle' AND caractere_envahissant = 1) -- Si une plante est envhissante 
            OR 
            nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = 'trefle' AND caractere_envahissant = 1) -- Si on cherche un parasite
        ) -- Si on cherche un parasite
);
-- Return FALSE car Espagne n'est pas dans la table presente volontairement 

SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE (
    nom_pays = 'France' -- On ne prend que le pays d'intérets
    AND 
        (
            nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'pissenlit' AND caractere_envahissant = 1) -- Si une plante est envhissante 
            OR 
            nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = 'pissenlit' AND caractere_envahissant = 1) -- Si on cherche un parasite
        ) -- Si on cherche un parasite
);
-- Return FALSE car dans l'association France pissenlit de la table sensible volontairement, le caractere envahissant = 0


INSERT INTO parasite(nom_parasite,regne,duree_survie_p) VALUES ('chien', "animal", 1);
INSERT INTO sensible_involontairement (nom_pays, nom_parasite,caractere_envahissant,historique) VALUES ('France', 'chien', 1, 0);

SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE (
    nom_pays = 'France' -- On ne prend que le pays d'intérets
    AND 
        (
            nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Si une plante est envhissante 
            OR 
            nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = 'chien' AND caractere_envahissant = 1) -- Si on cherche un parasite
        ) -- Si on cherche un parasite
);
-- Return TRUE car France est sensible au chien 


UPDATE sensible_involontairement SET caractere_envahissant = 0 WHERE nom_parasite = 'chien';
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE (
    nom_pays = 'France' -- On ne prend que le pays d'intérets
    AND 
        (
            nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Si une plante est envhissante 
            OR 
            nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = 'chien' AND caractere_envahissant = 1) -- Si on cherche un parasite
        ) -- Si on cherche un parasite
);
-- Return False car le caractere envahissant du chien est passé à 0

DELETE FROM sensible_involontairement WHERE nom_parasite = 'chien';
SELECT IF(COUNT(*)>0 ,'TRUE','FALSE') AS result FROM Pays WHERE (
    nom_pays = 'France' -- On ne prend que le pays d'intérets
    AND 
        (
            nom_pays = (SELECT nom_pays FROM sensible_volontairement WHERE nom_vegetal = 'chien' AND caractere_envahissant = 1) -- Si une plante est envhissante 
            OR 
            nom_pays = (SELECT nom_pays FROM sensible_involontairement WHERE nom_parasite = 'chien' AND caractere_envahissant = 1) -- Si on cherche un parasite
        ) -- Si on cherche un parasite
);
-- Return False car la france n'est sensible à rien