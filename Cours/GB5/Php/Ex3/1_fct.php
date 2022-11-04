<?php 
function form(){
    $file = fopen("1_data.txt", "a+");
    if (flock($file, LOCK_EX)) {
        
    $ip = $_SERVER['REMOTE_ADDR']; 
    // if ($ip == "::1") {
    //     $ip = $_SERVER['HTTP_CLIENT_IP'];
    // };
    $date = date("d/m/Y");
    $time = date("H:i:s");
    // $nav = $_SERVER['HTTP_USER_AGENT'];
    $browser = get_browser(null, true);
    $browser = $browser['browser'];

    $data =  $date . " ". $time . " ; " . $ip . " ; " . $browser . "\n";
    fwrite($file, $data);
    fflush($file);
    flock($file, LOCK_UN);
    }
    fclose($file);
}

form();
?>