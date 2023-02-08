<?php
include ("../connect/db.php");

$query ="SELECT * FROM Appointment NATURAL JOIN Service WHERE start_time BETWEEN DATE_ADD(CURRENT_DATE(), INTERVAL +1 DAY) and DATE_ADD(CURRENT_DATE(), INTERVAL +2 DAY)";
$result = mysqli_query($con, $query);
$rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
foreach ($rows as $row) {
    $service = $row["name_service"];
    $subject = "Rappel rendez-vous ChaboToMarty lab";
    $datetime = explode(' ', $row['start_time']);
    $date = $datetime[0];
    $time = $datetime[1];
    $message = "Bonjour, <br> Votre rendez-vous pour le service " . $service . " est prévu pour le " . $date . " a " . $time . ".<br> Cordialement, <br> L'équipe ChaboToMarty lab";
    $headers = "MIME-Version: 1.0\r\n";
    //Set the content-type to html
    $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
    $headers .= "From: no-reply@chabotomarty.fr";
    mail($row['id_user'], $subject, $message, $headers);
}
echo "ok";
?>