<?php 
$oui = array("Oui","Non"); 
// echo "$oui <br>"; 

$last = array( 
    "Oui" => "Non",
    "Non" => "Oui",
);

foreach ($oui as $ok) {
    echo "$ok <br>";
};

foreach ($last as $key => $value) {
    echo "$key => $value <br>";
};

?>