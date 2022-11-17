<?php
$note = array(
    "Martin" => 16, 
    "Chab" => 21, 
    "Tommy" => 18
); 

function disp($tab){
    foreach ($tab as $key => $value) {
        echo "$key à eut : $value <br>"; 
    };
};

disp($note);

function mean($tab){
    $mean = 0 ; 
    $i = 1 ; 
    while($i <= 3){
        $mean = $mean+$tab[$i];
        $i++;
    };
    $mean = $mean/$i;
    echo "La moyenne du tableau est égale à $mean"; 
};


?>