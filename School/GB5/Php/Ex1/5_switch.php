<?php 
$note=15; 
echo "Votre note : $note => ";

switch ($note) {
    case 0 :
    case 1 : 
    case 2 : 
    case 3 : 
    case 4 : 
    case 5 : 
        echo "NUUUULLLL";
        break;
    
    case 6 :
    case 7 : 
    case 8 : 
    case 9 : 
    case 10 : 
        echo "Peut mieux faire";
        break;

    case 11 :
    case 12 : 
    case 13 : 
    case 14 : 
    case 15 : 
        echo "Ok tiers";
        break;
    
    case 16 :
    case 17 : 
    case 18 : 
    case 19 : 
    case 20 : 
        echo "Excellent";
        break;

    default : 
        echo "Valeur incohérente"; 
        break; 
}
?>