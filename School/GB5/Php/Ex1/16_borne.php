<?php 
function borne($borne_min,$borne_max){

    for ($i=$borne_min; $i < $borne_max; $i++) { 
        echo "$i <br>"; 
    };
}

borne(10,500)
?>