<?php

if (isset($_POST['CP'])) {
    if (!empty($_POST['CP']) && !is_int($_POST["CP"])) {
        echo 'Code postal : ' . $_POST['CP'] . '<br>';
    }else{
        echo 'Code postal vide<br>';
    }
} else {
    echo 'Code postal non défini<br>';
}

if (isset($_POST['hist'])) {
    if (!empty($_POST['hist']) && is_string($_POST["hist"])) {
        echo 'Votre histoire : ' . $_POST['hist'] . '<br>';
    }else{
        echo "Vous n'avez pas de vie <br>";
    }
} else {
    echo "Pas d'histoire définie<br>";
}

if (isset($_POST['pays'])) {
    if (!empty($_POST['pays']) && is_string($_POST["pays"])) {
        echo 'Pays : ' . $_POST['pays'] . '<br>';
    }else{
        echo 'Pays vide<br>';
    }
} else {
    echo 'Pays non défini<br>';
}

if (isset($_POST['nb_pref'])) {
    if (!empty($_POST['nb_pref']) && is_string($_POST["nb_pref"])) {
        echo 'Votre nombre préféré : ' . $_POST['nb_pref'] . '<br>';
    }else{
        echo 'Nombre vide<br>';
    }
} else {
    echo 'Nombre non défini<br>';
}

if (isset($_POST['heureux'])) {
    if (!empty($_POST['heureux']) && is_string($_POST["heureux"])) {
        echo 'Etes vous heureux : ' . $_POST['heureux'] . '<br>';
    }else{
        echo 'Vous n\'êtes pas heureux<br>';
    }
} else {
    echo 'Vous n\'êtes pas heureux<br>';
}

?>