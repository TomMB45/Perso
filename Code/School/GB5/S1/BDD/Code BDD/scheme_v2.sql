-- rm table
DROP TABLE IF EXISTS peut_transporter; 
DROP TABLE IF EXISTS achemine;
-- DROP TABLE IF EXISTS entre;
DROP TABLE IF EXISTS sensible_volontairement;
DROP TABLE IF EXISTS sensible_involontairement;

DROP TABLE IF EXISTS Trajet;
DROP TABLE IF EXISTS Parasite;
DROP TABLE IF EXISTS Vegetal;
DROP TABLE IF EXISTS Pays;

-- Entity table 
CREATE TABLE IF NOT EXISTS Pays (
    nom_pays varchar(50) NOT NULL,
    periode_quarantaine int(2) NOT NULL CHECK (periode_quarantaine >= 0 AND periode_quarantaine <= 100),

    PRIMARY KEY (nom_pays)
);

CREATE TABLE IF NOT EXISTS Vegetal (
    nom_vegetal varchar(50) NOT NULL,
    duree_survie_v int(2) NOT NULL,

    PRIMARY KEY (nom_vegetal)
);

CREATE TABLE IF NOT EXISTS Parasite (
    nom_parasite varchar(50) NOT NULL,
    regne varchar(50) NOT NULL,
    duree_survie_p int(2) NOT NULL,

    PRIMARY KEY (nom_parasite)
);

CREATE TABLE IF NOT EXISTS Trajet(
    id_trajet int(8) NOT NULL AUTO_INCREMENT,
    nombre_etapes int(2) NOT NULL CHECK (nombre_etapes >= 0 AND nombre_etapes <= 2),
    duree_trajet_sans_etape int(2) NOT NULL,
    moyen_transport_1 varchar(50) NOT NULL,
    moyen_transport_2 varchar(50) DEFAULT NULL,
    moyen_transport_3 varchar(50) DEFAULT NULL,
    nom_pays_depart varchar(50) NOT NULL,
    nom_pays_arrivee varchar(50) NOT NULL,

    PRIMARY KEY (id_trajet),
    FOREIGN KEY (nom_pays_depart) REFERENCES Pays(nom_pays) ON DELETE CASCADE,
    FOREIGN KEY (nom_pays_arrivee) REFERENCES Pays(nom_pays) ON DELETE CASCADE
);

-- Association table
CREATE TABLE IF NOT EXISTS sensible_volontairement(
    nom_pays varchar(50) NOT NULL,
    nom_vegetal varchar(50) NOT NULL,
    caractere_envahissant int(2) NOT NULL CHECK (caractere_envahissant >= 0 AND caractere_envahissant <= 1 ), 
    historique int(2) NOT NULL CHECK (historique >= 0 AND historique <= 1 ),

    FOREIGN KEY (nom_pays) REFERENCES Pays(nom_pays) ON DELETE CASCADE,
    FOREIGN KEY (nom_vegetal) REFERENCES Vegetal(nom_vegetal) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS sensible_involontairement(
    nom_pays varchar(50) NOT NULL,
    nom_parasite varchar(50) NOT NULL,
    caractere_envahissant int(2) NOT NULL CHECK (caractere_envahissant >= 0 AND caractere_envahissant <= 1 ),
    historique int(2) NOT NULL CHECK (historique >= 0 AND historique <= 1 ),

    FOREIGN KEY (nom_pays) REFERENCES Pays(nom_pays) ON DELETE CASCADE,
    FOREIGN KEY (nom_parasite) REFERENCES Parasite(nom_parasite) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS achemine(
    id_trajet int(8) NOT NULL,
    nom_vegetal varchar(50) NOT NULL,

    FOREIGN KEY (id_trajet) REFERENCES Trajet(id_trajet) ON DELETE CASCADE,
    FOREIGN KEY (nom_vegetal) REFERENCES Vegetal(nom_vegetal) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS peut_transporter(
    nom_vegetal varchar(50) NOT NULL,
    nom_parasite varchar(50) NOT NULL,
    facteur_reduction int(2) NOT NULL CHECK (facteur_reduction >= 0),

    FOREIGN KEY (nom_vegetal) REFERENCES Vegetal(nom_vegetal) ON DELETE CASCADE,
    FOREIGN KEY (nom_parasite) REFERENCES Parasite(nom_parasite) ON DELETE CASCADE
);