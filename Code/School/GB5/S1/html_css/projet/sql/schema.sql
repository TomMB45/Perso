DROP TABLE User_has_result; 
DROP TABLE user_belongs_service; 
DROP TABLE Appointment; 
DROP TABLE Service;
DROP TABLE Result;
DROP TABLE Users;

CREATE TABLE IF NOT EXISTS Users (
    email varchar(50) NOT NULL,
    password varchar(250) NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    role varchar(20) NOT NULL,
    sexe varchar(15),
    birth_date date NOT NULL, 
    number_secu varchar(20),
    phone_number varchar(20), 
    country varchar(100),
    city varchar(50),
    postal_code varchar(5),  
    adress varchar(100),
    create_datetime datetime NOT NULL,

    PRIMARY KEY (email)
);

CREATE TABLE IF NOT EXISTS Services(
    name_service varchar(100) NOT NULL,
    slot_duration int NOT NULL,
    nb_simultaneous_slots int NOT NULL,
    PRIMARY KEY (name_service)
);

CREATE TABLE IF NOT EXISTS Appointment (
    id_appointment int NOT NULL AUTO_INCREMENT,
    name_service varchar(100) NOT NULL,
    id_user varchar(50) NOT NULL,    
    start_time datetime NOT NULL,

    PRIMARY KEY (id_appointment),
    FOREIGN KEY (name_service) REFERENCES Services(name_service),
    FOREIGN KEY (id_user) REFERENCES Users(email) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS user_belongs_service(
    id_service varchar(100) NOT NULL,
    id_user varchar(50) NOT NULL,

    FOREIGN KEY (id_serice) REFERENCES Services(name_service),
    FOREIGN KEY (id_user)  REFERENCES Users(email) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id_service, id_user)
);