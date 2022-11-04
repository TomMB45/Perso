<?php 
$comm = array();
$f = fopen("3_data/3_commande.txt", "r");
while(!feof($f)){
    $line = fgets($f);
    $line = explode(":", $line);
    $comm[$line[0]] = $line[1];
}
fclose($f);

foreach($_GET as $key => $value){
    if ($value != 0){
        $comm[$key] += $value;
    }
}

$f = fopen("3_data/3_commande.txt", "w");
foreach($comm as $key => $value){
    fwrite($f, $key . ":" . $value . "\n");
}
fclose($f);

?>

<!DOCTYPE html>
<html>
    <head>
        <title>Ex3</title>
    </head>
    <body>
        <h1>Commande passé</h1>
    </body>
</html>