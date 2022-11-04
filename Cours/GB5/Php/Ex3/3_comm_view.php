<?php 
$comm = array();
$f = fopen("3_data/3_commande.txt", "r");
while(!feof($f)){
    $line = fgets($f);
    $line = explode(":", $line);
    $comm[$line[0]] = $line[1];
}

print_r($comm);
?>