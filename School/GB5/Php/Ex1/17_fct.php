<?php
function inutile($cdc){
    $new_cdc = strtoupper($cdc);
    $out = str_shuffle($new_cdc);
    echo "$out <br>"; 
}

inutile("Je suis inutile")
?>