Le programme nécessite biopython, plotly et tkinter. De plus, il faut ouvrir le programme à l’aide d’un exécuteur de script Python.
Dépendances à installer avant d'executer le code : biopython et plotly


Utilisation :

	- Run le programme principal

	- Une fenêtre s’affiche afin que l'utilisateur entre le chemin d’accès dans lequel il veut que les fichiers de sortie soient enregistrés. 
	Si aucun chemin d'accès n’est rentré par l’utilisateur, les fichiers seront enregistrés dans le même répertoire que le programme.

	- Puis une fenêtre permet à l’utilisateur de renseigner s'il possède le fichier PDB dans son répertoire. 
	Si on clique sur “I have the file in my directory” cela va ouvrir un fichier PDB présent sur votre disque dur. 
	Alors que si l’on clique sur “I don’t have the file in my directory” cela va récupérer le contenu d’un fichier au format PDB 
	par l’interrogation du site web PDB avec le code PDB.

		=> Si on choisit de cliquer sur la première proposition, l’utilisateur va pouvoir grâce à un bouton parcourir son répertoire 
		pour trouver le fichier qu’il souhaite utiliser. Puis en appuyant sur “Continu”, cela va ouvrir un menu, 
		permettant à l’utilisateur d’obtenir les informations qu’il souhaite grâce à l’analyse de la séquence protéique.

		=> Si on choisit de cliquer sur la deuxième proposition, il faut rentrer un code PDB valide pour pouvoir récupérer 
			la séquence protéique sur internet.

	- Puis un menu s’affiche avec toutes les possibilités du programme, l’utilisateur a juste besoin de cliquer sur ce qui l’intéresse

	- Pour les fichiers téléchargeables une fenêtre s’affiche indiquant “File has been dowload”

	- Un bouton “Go main menu” permet de retourner à la fenêtre initiale


Les différents fichiers de sortie générés par notre programme sont :

	- Une page internet permettant de visualiser le graphique d'hydrophobicité à l’aide de la méthode de Fauchère

	- Une page internet permettant de visualiser le graphique d'hydrophobicité à l’aide de la méthode de Kyte

	- Une page internet permettant de visualiser un graphique montrant la proportion des acides aminés de la protéine comparé aux proportions moyennes

	- Une page internet permettant de visualiser la représentation heat map de la protéine

	- Un fichier au format .fasta nommé « `CODE_PDB`_FASTA.fasta » contenant :

		=> informations de la protéine

		=> séquence au format fasta

	- Un fichier au format .txt nommé « `CODE_PDB`_output_file.txt » contenant :

		=> la séquence protéique

		=> la méthode expérimentale utilisée pour déterminer la structure

		=> la résolution éventuelle

		=> les ponts disulfures possibles avec la position des cystéines concernées et leur distance les unes par rapport aux autres

		=> les cystéines non pontées

	- Un fichier au format .pdb nommé « `CODE_PDB`_B_fact_modif.pdb » avec une modification des B-factor afin d’obtenir une visualisation 
	des acides aminés par rapport à la physico-chimie des résidus.