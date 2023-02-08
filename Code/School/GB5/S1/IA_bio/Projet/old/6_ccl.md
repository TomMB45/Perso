- Point positif : 
    - Le script ne nous crée pas des points aléatoirement positionné sur la carte
    - Développement de nos connaissances en machine learning
    - Développement de notre esprit critique vis a vis de nos résultats
    - Première approche de validation plus graphique que numérique -> bonne MAE ne veut pas dire que le modèle est bon (voir graphique)


- Point négatif :
    - Prédiction très éloignée de la réalité
    - Trop optimiste vis a vis du dataset (trop de donnée et pas assez de features intéressantes)


Raisons de la difficulté :
- Le dataset n'est pas très addapté, il ne contient pas beaucoup de features interessantes pour le vol de voiture (la marque de voiture,  le modèle, le fait qu’elle soit verrouillé ou non, qu’elles soit dans une zone considérée comme propice ou non à un vol de voiture, etc...)

- Il n'existe peut être pas de pattern entre le vol de voiture et la date. 

- Les méthodes de machine learning ne sont pas assez puissantes pour trouver des patterns dans ces données précisément (si il existe). il faudrais peut être mettre en place des méthodes de deep learning bien plus complexes et lourdes a mettre en place.