<?php

if (isset($_GET['CP'])) {
    if (!empty($_GET['CP']) && !is_int($_GET["CP"])) {
        echo 'Code postal : ' . $_GET['CP'] . '<br>';
    }else{
        echo 'Code postal vide<br>';
    }
} else {
    echo 'Code postal non défini<br>';
}

if (isset($_GET['ville'])) {
    if (!empty($_GET['ville']) && is_string($_GET["ville"])) {
        echo 'Ville : ' . $_GET['ville'] . '<br>';
    }else{
        echo 'Ville vide<br>';
    }
} else {
    echo 'Ville non définie<br>';
}

if (isset($_GET['pays'])) {
    if (!empty($_GET['pays']) && is_string($_GET["pays"])) {
        echo 'Pays : ' . $_GET['pays'] . '<br>';
    }else{
        echo 'Pays vide<br>';
    }
} else {
    echo 'Pays non défini<br>';
}

?>