<?php 
if (isset($_POST["o_n"])){
    if ($_POST["o_n"] == "on"){
        setcookie("nom", $_POST["nom"], time()+3600*24*365.25);
        setcookie("prenom", $_POST["prenom"], time()+3600*24*365.25);
        header("Location: 6_res.php");
    }else{
        header("Location: 6_save.php");
    }
}else{
    header("Location: 6_save.php");
}
?>