<?php 
function form($page_from){
    $file = fopen("2_data/".$page_from.".txt", "a+");
    if (flock($file, LOCK_EX)) {  
        $ip = $_SERVER['REMOTE_ADDR']; 
        $date = date("d/m/Y");
        $time = date("H:i:s");
        $browser = get_browser(null, true);
        $browser = $browser['browser'];

        $data =  $date . " ". $time . " ; " . $ip . " ; " . $browser . "\n";
        fwrite($file, $data);
        fflush($file);
        flock($file, LOCK_UN);
    }
    fclose($file);
}

function nb_acces($page_from)
{
    $file = fopen("2_data/".$page_from.".txt", "a+");
    if (flock($file, LOCK_EX)) {
        $nb = 0;
        while (!feof($file)) {
            $line = fgets($file);
            $nb++;
        }
        fflush($file);
        flock($file, LOCK_UN);
    }
    fclose($file);  
    return $nb-1; 
}
?>