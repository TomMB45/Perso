<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>URL</title>
</head>
<body>
    <form action="2_affiche.php" method="post">
        <label for="nom">Code postal</label>
        <input type="text" name="CP">
        <br>

        <label for="hist">Votre histoire</label>
        <textarea name="hist" id="hist" cols="30" rows="10"></textarea>
        <br>

        <label for="pays">Choississez un pays</label>
        <select name="pays">
            <option value="France" selected="selected">France</option>
            <option value="Belgique">Belgique</option>
            <option value="Suisse">Suisse</option>
        </select>
        <br>

        <label for="o_n">nb_préféré</label>
        <input type="checkbox" name="nb_pref"> <label for="1">1</label>
        <input type="checkbox" name="nb_pref"> <label for="2">2</label>
        <input type="checkbox" name="nb_pref"> <label for="3">3</label>
        <input type="checkbox" name="nb_pref"> <label for="4">4</label>



        <label for="heureux">Etes vous heureux</label>
        <input type="radio" name="heureux" value="oui"> <label for="oui">oui</label>
        <input type="radio" name="heureux" value="non"> <label for="non">non</label>

        <input type="button" value="B1">
        <input type="button" value="B2">
        
        <input type="submit" value="Envoyer">
    </form>
</body>
</html>