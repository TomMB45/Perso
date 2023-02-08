#SERVICES --

INSERT INTO `Service` (`id_service`, `name_service`, `slot_duration`, `nb_simultaneous_slots`) VALUES (NULL, 'Radiologie', '30', '2');
INSERT INTO `Service` (`id_service`, `name_service`, `slot_duration`, `nb_simultaneous_slots`) VALUES (NULL, 'Gynécologie', '45', '1');

#CLIENTS --

INSERT INTO `Users` (`email`, `password`, `first_name`, `last_name`, `role`, `sexe`, `birth_date`, `number_secu`, `country`, `city`, `postal_code`, `adress`, `create_datetime`) VALUES ('romain.gauthier@projetweb.fr', 'toto_tutu', 'Romain', 'Gauthier', 'CNV', 'Homme', '1970/10/01', NULL, 'France', 'Antibes', '06160', 'IPMC', '2022-11-11 17:15:55.000000');

#CLIENTS_VERIFIES

INSERT INTO `Users` (`email`, `password`, `first_name`, `last_name`, `role`, `sexe`, `birth_date`, `number_secu`, `country`, `city`, `postal_code`, `adress`, `create_datetime`) VALUES ('jean-paul.commet@projetweb.fr', 'Vousavezfini?', 'Jean-Paul', 'Comet', 'CV', 'Homme', '1964/10/01', '12345678910', 'France', 'Antibes', '06160', 'IPMC', '2022-11-10 17:15:55.000000');
INSERT INTO `Users` (`email`, `password`, `first_name`, `last_name`, `role`, `sexe`, `birth_date`, `number_secu`, `country`, `city`, `postal_code`, `adress`, `create_datetime`) VALUES ('gilles.bernot@projetweb.fr', 'PlafondDeVerre', 'Gilles', 'Bernot', 'CV', 'Homme', '1968/10/01', '23456789110', 'France', 'Antibes', '06160', 'Polytech', '2022-11-9 17:15:55.000000');

#SECRETAIRES

INSERT INTO `Users` (`email`, `password`, `first_name`, `last_name`, `role`, `sexe`, `birth_date`, `number_secu`, `country`, `city`, `postal_code`, `adress`, `create_datetime`) VALUES ('julie.etrillard@projetweb.fr', 'ApexEvidement', 'Julie', 'Etrillard', 'SEC', 'Femme', '1999/10/01', NULL, NULL, NULL, NULL, NULL, '2022-11-9 17:15:55.000000');
INSERT INTO `Users` (`email`, `password`, `first_name`, `last_name`, `role`, `sexe`, `birth_date`, `number_secu`, `country`, `city`, `postal_code`, `adress`, `create_datetime`) VALUES ('celya.franc@projetweb.fr', 'Toronto', 'Celya', 'Franc', 'SEC', 'Femme', '2000/10/01', NULL, NULL, NULL, NULL, NULL, '2022-11-9 17:15:55.000000');

#SERVICES

INSERT INTO `Users` (`email`, `password`, `first_name`, `last_name`, `role`, `sexe`, `birth_date`, `number_secu`, `country`, `city`, `postal_code`, `adress`, `create_datetime`) VALUES ('jj.magdeleine@projetweb.fr', 'LaCorse', 'Jean-Jacques', 'Magdeleine', 'SEV', 'Homme', '1999/07/28', NULL, NULL, NULL, NULL, NULL, '2022-11-9 17:15:55.000000');
INSERT INTO `Users` (`email`, `password`, `first_name`, `last_name`, `role`, `sexe`, `birth_date`, `number_secu`, `country`, `city`, `postal_code`, `adress`, `create_datetime`) VALUES ('tiff.kerdiles@projetweb.fr', 'LaBretagne', 'Tiffany', 'Kerdiles', 'SEV', 'Femme', '1998/11/15', NULL, NULL, NULL, NULL, NULL, '2022-11-9 17:15:55.000000');

#ADMIN_HOSPITALIER

INSERT INTO `Users` (`email`, `password`, `first_name`, `last_name`, `role`, `sexe`, `birth_date`, `number_secu`, `country`, `city`, `postal_code`, `adress`, `create_datetime`) VALUES ('noe.robert@projetweb.fr', 'FuckingFred', 'Noe', 'Robert', 'AH', 'Homme', '1999/04/12', NULL, NULL, NULL, NULL, NULL, '2022-11-9 17:15:55.000000');

#ADMIN_SYSTEME

INSERT INTO users (`email`, `password`, `first_name`, `last_name`, `role`, `sexe`, `birth_date`, `number_secu`,`phone_number`, `country`, `city`, `postal_code`, `adress`, `create_datetime`) VALUES ('tommaugeriguet@gmail.com', '47bce5c74f589f4867dbd57e9ca9f808', 'Tom', 'Mauger-Birocheau', 'SU', NULL, '08/04/1998', '199199818819', '619603279', 'France', 'Biot', '6410', '74 Rue Evariste Galois', '2022-11-23 15:28:00');
INSERT INTO `users` (`email`, `password`, `first_name`, `last_name`, `role`, `sexe`, `birth_date`, `number_secu`, `country`, `city`, `postal_code`, `adress`, `create_datetime`) VALUES ('chab@chab', '174a3f4fa44c7bb22b3b6429cb4ea44c', 'Chab', 'Chab', 'SU', NULL, '08/04/1998', NULL, NULL, NULL, NULL, NULL, '2022-11-22 14:27:55');

#user_belongs_service 

INSERT INTO user_belongs_service (id_service, id_user) VALUES ('1', 'jj.magdeleine@projetweb.fr');
INSERT INTO user_belongs_service (id_service, id_user) VALUES ('2', 'tiff.kerdiles@projetweb.fr');