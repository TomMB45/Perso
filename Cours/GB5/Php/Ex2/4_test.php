<?php
if (isset($_FILES["f"])){
    if ($_FILES["f"]["size"] < 500_000_000){
        if ($_FILES["f"]["size"] > 10_000_000){
            $infosfichier = pathinfo($_FILES ['monfichier']['name']) ;
            $extension_upload = $infosfichier ['extension'];
            $extensions_autorisees = array('pdf');
            if (in_array($extension_upload, $extensions_autorisees)){
                echo "Le fichier est valide";
            }else{
                echo "Le fichier n'est pas valide";
            }
        }else{echo "Le fichier est trop petit";}

    }else {
        echo "Fichier trop gros";
    }
}else{
    echo "Pas de fichier";
}
?>