/*1)*/
CREATE TABLE Repas 
(
	date DATE NOT NULL,
	invite VARCHAR(30) NOT NULL
)
CHARACTER SET utf8; 

CREATE TABLE Menu 
(
	date DATE NOT NULL,
	plat VARCHAR(30) NOT NULL
)
CHARACTER SET utf8; 

CREATE TABLE Preference 
(
	personne VARCHAR(30) NOT NULL ,
    	plat VARCHAR(30) NOT NULL
)
CHARACTER SET utf8;

4)
/*pi(plat) sigma(personne='Martin Paul')Preference*/
SELECT plat FROM `Preference` WHERE personne = 'Martin Paul' ;

5) 
/*pi(invite) sigma(date = '2021-12-24')Repas*/
SELECT invite FROM Repas WHERE (date = '2021-12-24') ;

6)
/*pi(plat) sigma (Menu.date = Repas.date & invite = 'Martin Marie')Menu x Repas*/
SELECT plat FROM Menu,Repas WHERE (Menu.date = Repas.date AND invite = 'Martin Marie') ;

7)
/*FAUX 
	pi(invite) sigma (invite = personne AND Repas.date = Menu.date)Menu x Repas X Preference 
	SELECT invite FROM `Repas`, Preference, Menu WHERE (invite = personne AND Repas.date = Menu.date AND );*/

/*Fonctionne :*/ 
SELECT DISTINCT invite FROM Repas NATURAL JOIN Menu NATURAL JOIN Preference WHERE invite = Preference.personne; /* NAtural Join*/
SELECT DISTINCT invite FROM Repas JOIN Menu USING date JOIN Preference ON (Menu.plat = Preference.plat AND invite = personne) ; /* Theta Join*/

/*
pi(invite) sigma(invite = Preference.personne) Repas |X| Menu |X|Preference => NATURAL JOIN 
pi(invite) Repas |X|[Repas.date=Menu.date] Menu |X|[Menu.plat = Preference.plat ^ invite = personne] Preference => Theta JOIN 

8)
Produit cartesien de Repas et Menu : date,invite,date,plat 

9)
FAUX
	pi(invite) sigma (invite != personne)Repas X Preference 
	SELECT invite FROM `Repas`, Preference WHERE (invite != personne) ;
VRAI */
SELECT DISTINCT personne FROM Preference WHERE personne NOT IN (SELECT invite FROM Repas); 
/* pi(personne)Preference \ pi(invite)Repas



/*10) Quels sont les invites qui sont venus a tous les repas ?
	SELECT DISTINCT invite FROM Repas INNER JOIN Menu ON Repas.date = Menu.date
	SELECT invite FROM Repas WHERE ( COUNT(*) = COUNT ( DISTINCT Menu.date)); 
	SELECT invite FROM Repas,Menu GROUP BY invite HAVING( SELECT COUNT(DISTINCT ( Menu.date) ) )
	SELECT invite FROM Repas,Menu GROUP BY invite HAVING( count(*) =  SELECT COUNT(DISTINCT ( date ) FROM Repas) ); 
	SELECT invite FROM Menu GROUP BY invite HAVING( COUNT(*) =  SELECT COUNT( DISTINCT date ) FROM Repas); 
*/
SELECT DISTINCT invite FROM Repas GROUP BY invite HAVING COUNT(*) = (SELECT COUNT( DISTINCT date ) FROM Repas) ; 
/* Repas/pi[date]Repas */

/*11) Quels sont les invites qui ont ete invites au moins 3 fois ? 
Est-ce que cette question est exprimable en algebre relationnelle ? Pourquoi ?
Est-elle exprimable en SQL ? 
Peut-on avoir pour ces invites le nombre de fois ou ils ont ete invites ?*/

/* FAUX => SELECT DISTINCT invite FROM Repas GROUP BY invite HAVING 3 <= (SELECT COUNT( DISTINCT date ) FROM Menu) ; car <= n'existe pas*/
SELECT COUNT(*) , invite FROM Repas GROUP BY invite HAVING count(*)>=3 ORDER BY invite DESC; 

/*
Non car COUNT est un operateur non algebrique non traduisible en algebre 
Oui voir en haut 
SELECT DISTINCT invite , COUNT(date) AS nb FROM Repas GROUP BY invite HAVING 3 <= (SELECT COUNT( DISTINCT date ) FROM Menu) ORDER BY nb DESC; */

/*
12)Est-ce que  Richird Paul a deja ete invite avec Martin Marie ?*/
SELECT DISTINCT date FROM Repas WHERE (invite = 'Richird Paul' AND date IN (SELECT date FROM Repas WHERE (invite = 'Martin Marie'))) ;
/*pi[date] sigma[invite = 'Richird Paul'](Repas) n pi[date] sigma[invite = 'Martin Marie'](Repas) */

/*13)Avec qui a deja ete invite Richird Paul ?
SELECT DISTINCT invite FROM Repas WHERE date IN (SELECT date FROM Repas WHERE (invite = 'Richird Paul')) ; => Pb paul Richir apparait comme ayant ete invite avec lui même*/
SELECT DISTINCT invite FROM Repas WHERE date IN (SELECT date FROM Repas WHERE (invite = 'Richird Paul')) AND invite != 'Richird Paul'; 
/* pi[invite]sigma[date] n sigma(invite = Richird Paul) */

/*14)La maitresse de maison veut inviter Richird Paul avec une autre personne, avec laquelle Paul Richird
n a pas encore ete invite. Mais elle souhaite servir du tiramisu et souhaite que l autre personne n ait
jamais goute a son tiramisu. Qui peut-elle inviter ?
	Pas sur -> SELECT DISTINCT invite FROM Repas NATURAL JOIN Menu WHERE date IN (SELECT date FROM Repas NATURAL JOIN Menu WHERE (invite = 'Richird Paul')) AND invite != 'Richird Paul' AND plat != 'tiramisu'

Decouper le PB 
Qui n'a jamais goute le tiramitsu ? */
SELECT invite FROM Repas NATURAL JOIN Menu WHERE (plat!='tiramitsu') ; 

/*Qui n'a jamais ete invite avec Paul ? */
SELECT DISTINCT invite FROM Repas WHERE date NOT IN (SELECT date FROM Repas WHERE (invite = 'Richird Paul')) AND invite != 'Richird Paul'; 

/*Sol finale */
SELECT DISTINCT invite FROM Repas WHERE date NOT IN (SELECT date FROM Repas WHERE (invite = 'Richird Paul')) AND invite != 'Richird Paul' UNION SELECT invite FROM Repas NATURAL JOIN Menu WHERE (plat!='tiramitsu') ; 

/*15)La maitresse de maison s est rendue compte que la base de donnees comporte des erreurs. Le plat
prefere de Paul Olivier (pizza) est en fait de la paella. Proposez un ordre SQL pour mettre a
jour la relation PREFERENCE.

Verification : */
SELECT plat FROM Preference WHERE (personne = 'Paul Olivier') ; 

/*Requette de modification de ligne */
UPDATE Preference SET plat = 'paella' WHERE (personne = 'Paul Olivier' AND plat = 'pizza') ; 


/*16) D autres erreurs se sont glissees dans la bases de donnees. L invitation du 24 decembre 2021 a en fait eu lieu le 22 decembre 2021.
	* Proposez un ordre unique SQL mettant a jour les differents tuples de la relation REPAS qui doivent etre mis a jours. Testez votre requete de mise a jours sur la base de donnees.
	* Quels sont les plats servis a Martin Jacques ?
	* Proposez une requete SQL mettant a jour la base de donnees pour que la question precedente donne le bon resultat.

Verification : */
	SELECT invite FROM `Repas` WHERE date = '2021-12-24';
/*Requette : 
MAJ */
UPDATE Repas SET date = '2021-12-22' WHERE date = '2021-12-24' ;
UPDATE Menu SET date = '2021-12-22' WHERE date = '2021-12-24' ;

/*Plat servis a martin jacques*/ 
SELECT * FROM Repas NATURAL JOIN Menu WHERE date = '2021-12-22' AND invite = 'Martin Jacques' ; 


/*17) Classez les invites par ordre decroissant de nombre de fois ou ils ont ete invites (SQL uniquement).*/
SELECT COUNT(*), invite AS nb FROM Repas GROUP BY invite ORDER BY (COUNT(*))DESC ; 
SELECT invite, COUNT(*)  AS nb FROM Repas GROUP BY invite ORDER BY (COUNT(*))DESC ; 

/*18) Quels sont les invites qui ont ete invites plus de fois que Paul Olivier (SQL uniquement).
Cb de fois a ete invite Paul ? */
SELECT COUNT(*) FROM Repas WHERE (invite = 'Paul Olivier') ; 

/*Selection des personnes qui ont plus d'invitation qu'un nombre int*/
	SELECT COUNT(*), invite AS nb FROM Repas GROUP BY invite HAVING ( 3 < (SELECT COUNT(*) FROM Menu)) ; 
	SELECT COUNT(*) , invite FROM Repas GROUP BY invite HAVING count(*)>=3 ; 

/*Solution finale : */
SELECT COUNT(*) , invite FROM Repas GROUP BY invite HAVING COUNT(*)>=(SELECT COUNT(*) FROM Repas WHERE (invite = 'Paul Olivier'))AND invite != 'Paul Olivier' ; 


/*19) Qui a ete invite a chaque fois que Paul Olivier l a ete ?
Selection des personnes invite au moins une fois en presence de Paul 
	SELECT DISTINCT invite FROM Repas WHERE date IN (SELECT date FROM Repas WHERE (invite = 'Paul Olivier')) AND invite != 'Paul Olivier'
Si le nombre de fois ou Paul a ete invite == nb de fois que qq1 d'autre de la selection precedente a ete invite. 
	Nb de fois que chaque personne invite avec Paul ont ete invite */
		SELECT invite, COUNT(*) AS nb FROM Repas WHERE date IN (SELECT date FROM Repas WHERE (invite = 'Paul Olivier')) GROUP BY invite ; 
	/*Nb de fois que Paul a ete invite */
		SELECT COUNT(*) FROM Repas WHERE (invite = 'Paul Olivier') ; 

/*Solution : */
SELECT invite FROM (SELECT invite, COUNT(*) AS nb FROM Repas WHERE date IN (SELECT date FROM Repas WHERE (invite = 'Paul Olivier')) GROUP BY invite )AS Nb_inv WHERE COUNT(*) = (SELECT COUNT(*) FROM Repas WHERE (invite = 'Paul Olivier') ; 
SELECT invite FROM (SELECT invite, COUNT(*) AS nb FROM Repas WHERE date IN (SELECT date FROM Repas WHERE (invite = 'Paul Olivier')) GROUP BY invite )AS Nb_inv WHERE COUNT(*) = (SELECT COUNT(*) FROM Repas WHERE (invite = 'Paul Olivier') ; 
SELECT invite, COUNT(*) AS nb FROM Repas WHERE (date IN (SELECT date FROM Repas WHERE (invite = 'Paul Olivier')) AND invite != 'Paul Olivier')GROUP BY invite HAVING (COUNT(*) = (SELECT COUNT(*) FROM Repas WHERE (invite = 'Paul Olivier'))) ; 